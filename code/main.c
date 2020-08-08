#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
//#include <libopencm3/stm32/rtc.h>
#include <libopencm3/stm32/usart.h>
//#include <libopencm3/stm32/pwr.h>
#include <libopencm3/cm3/nvic.h>
#include <libopencm3/stm32/timer.h>
//#include <libopencm3/stm32/dac.h>
//#include <libopencm3/stm32/dma.h>

#include <libopencm3/stm32/syscfg.h>

#include "stdint.h"
//#include "stdbool.h"
//#include <string.h> //For memcpy
//#include <stdio.h>	// For snprintf


// Define Functions
#define IsHigh(BIT, PORT) ((PORT & (1 << BIT)) != 0)
#define IsLow(BIT, PORT) ((PORT & (1 << BIT)) == 0)
#define SetBit(BIT, PORT) PORT |= (1 << BIT)
#define ClearBit(BIT, PORT) PORT &= ~(1 << BIT)

// Specific to the comms protocol
#define PackBits(V, P) (((V << 5) & 0xFF00) | (V & 0x07) | 0x8000 | (P << 3))

// Comms
typedef enum servoFlags_e
{
	ENGCACHE = 0,
	SERVOON,
	SERVOOFF,
	CMD2CUR
} servoFlags_t;

// Config Servos
#define NUMSERVOS 3
#define IDOFF 0

const uint8_t SERVOADDRESSES[] = {0 + IDOFF,
								  1 + IDOFF,
								  2 + IDOFF};


#define Version 5

#define ReplyPos 0
#define ReplyCur 1
#define ReplyVer 2

// Variables

static uint16_t cachepos[NUMSERVOS];
static uint16_t cmdpos[NUMSERVOS];
static uint16_t _cmdpos[NUMSERVOS];
static uint8_t listen[NUMSERVOS];

//comms side stuff
unsigned int dobyte(char data);
unsigned int servoCmd(unsigned int command, unsigned int argument);


uint16_t clocksPerMilliSecond = 9500;

////////////////////////////////////////////////////////
///////////////////uC setup/////////////////////////////
////////////////////////////////////////////////////////

static void clock_setup(void)
{
	rcc_clock_setup_in_hse_8mhz_out_48mhz();
	//rcc_clock_setup_in_hsi_out_48mhz();

	// GPIO
	rcc_periph_clock_enable(RCC_GPIOA);
	
	// Timer2 for PWM
	rcc_periph_clock_enable(RCC_TIM2);
	
	// USART1
	rcc_periph_clock_enable(RCC_USART1);

}

static void usart_setup(void)
{
	usart_set_baudrate(USART1, 9600);
	usart_set_databits(USART1, 8);
	usart_set_parity(USART1, USART_PARITY_NONE);
	usart_set_stopbits(USART1, USART_CR2_STOPBITS_1);
	usart_set_mode(USART1, USART_MODE_RX);
	usart_set_flow_control(USART1, USART_FLOWCONTROL_NONE);
	
	usart_enable_rx_interrupt(USART1);

	// Turn it on
	usart_enable(USART1);
}

static void gpio_setup(void)
{
	// PWM pins
	gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_NONE, GPIO1 | GPIO2 | GPIO3);
	gpio_set_output_options(GPIOA, GPIO_OTYPE_PP, GPIO_OSPEED_HIGH, GPIO1 | GPIO2 | GPIO3);
	// Set alternate functions for TIM2 OC channels 2(GPIO1), 3(GPIO2), 4(GPIO3)
	gpio_set_af(GPIOA, GPIO_AF2, GPIO1 | GPIO2 | GPIO3);
	
	// USART 1
	gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_NONE, GPIO10);
	// Set alternate function
	gpio_set_af(GPIOA, GPIO_AF1, GPIO10);

}

static void nvic_setup(void)
{
	nvic_enable_irq(NVIC_USART1_IRQ);
}

static void timer_setup(void)
{

	// Configure TIM 2, with all the channels. This does the pulse widths for each channel
	timer_disable_counter(TIM2);
	timer_set_mode(TIM2, TIM_CR1_CKD_CK_INT, TIM_CR1_CMS_EDGE, TIM_CR1_DIR_UP);

	// ???????????
	timer_disable_preload(TIM2);
	// Set prescaler
	//	Must use a prescaler, as want to capture 3 ms in a uint16_t
	//	1/((3e-3)/(2^16)) = ~22 MHz max clock speed
	//	Therefore just pick a prescaler of 4
	timer_set_prescaler(TIM2, 4);
	// Set to 50 Hz
	//	48 MHz /4 = 12 MHz /50 Hz = 240,000 clock ticks
	//	Note: /4 due to the prescaler
	timer_set_period(TIM2, 190000);  // TODO: Determine why this doesn't quite work
	// Enable continuous mode for repeat
	timer_continuous_mode(TIM2);

	
	// Configure the channels
	//	Put into PWM mode
	timer_set_oc_mode(TIM2, TIM_OC2, TIM_OCM_PWM1);
	timer_set_oc_mode(TIM2, TIM_OC3, TIM_OCM_PWM1);
	timer_set_oc_mode(TIM2, TIM_OC4, TIM_OCM_PWM1);
	// Enable auto-preload
	timer_enable_oc_preload(TIM2, TIM_OC2);
	timer_enable_oc_preload(TIM2, TIM_OC3);
	timer_enable_oc_preload(TIM2, TIM_OC4);
	//	Put fast mode to speed up transitions
	timer_set_oc_fast_mode(TIM2, TIM_OC2);
	timer_set_oc_fast_mode(TIM2, TIM_OC3);
	timer_set_oc_fast_mode(TIM2, TIM_OC4);
	// Set specific OC values for duration
	timer_set_oc_value(TIM2, TIM_OC2, _cmdpos[0]);
	timer_set_oc_value(TIM2, TIM_OC3, _cmdpos[1]);
	timer_set_oc_value(TIM2, TIM_OC4, _cmdpos[2]);
	// Set it to actually do it
	timer_enable_oc_output(TIM2, TIM_OC2);
	timer_enable_oc_output(TIM2, TIM_OC3);
	timer_enable_oc_output(TIM2, TIM_OC4);
	
	// Start
	timer_generate_event(TIM2, TIM_EGR_UG);
	timer_enable_counter(TIM2);
	
	
	

}


static uint16_t calcNumClocks(float ms){
	uint16_t value = (uint16_t) (ms*clocksPerMilliSecond);
	return value;
}

////////////////////////////////////////////////////////
//////////////main//////////////////////////////////////
////////////////////////////////////////////////////////

int main(void)
{
	
	
	// Manually centre the legs
	for (int i = 0; i < NUMSERVOS; i++)
	{
		// Set the hidden and commanded values to different,
		//	so that it automatically gets set.
		cmdpos[i] = calcNumClocks(0);
		_cmdpos[i] = 0;
	}
	// wait for it to apply
	for (int i = 0; i < 100000; i++)
	{
		__asm__("nop");
	}

	//other
	clock_setup();
	gpio_setup();
	timer_setup();
	usart_setup();

	// Enable interrupts
	nvic_setup();

	gpio_clear(GPIOA, GPIO1 | GPIO2 | GPIO3);
	
	
	
	
	
	
	
	
	int c = 0;
	int j = 0;
	
	
	while (1)
	{
		// Update position to servos every x time
		
		
		for (int i=0; i<1000000/4; i++){
			__asm__("nop");
		}
		
		for( int i=0; i<NUMSERVOS;i++){
			_cmdpos[i] = cmdpos[i];
		}
		
		timer_set_oc_value(TIM2, TIM_OC2, _cmdpos[0]);
		timer_set_oc_value(TIM2, TIM_OC3, _cmdpos[1]);
		timer_set_oc_value(TIM2, TIM_OC4, _cmdpos[2]);
		
		
		
		
	}


	return 0;
}

// Functions

void debugToggle(void)
{
	//pass
}


/////////////////////////////////////////////////////
////////////// Comms Stuff //////////////////////////
/////////////////////////////////////////////////////

unsigned int dobyte(char data)
{

	static unsigned char state = 0;
	static unsigned int command;
	static unsigned int argument;

	if (state == 0)
	{
		if (IsLow(7, data))
		{
			state = 1;
			command = (data >> 3);
			argument = (argument & 0xFFF8) | (data & 0x07); // glue in its 0 through 2
		}
	}
	else
	{
		state = 0;
		if (IsHigh(7, data))
		{
			argument = (argument & 0x0007) | ((data & 0x7F) << 3); //glue in bits 3 through 9
			return servoCmd(command, argument);
		}
	}

	return 0;
}

// 0  listen (servo number) 256 = all                      {always obey command} // sticks through listen once
// 1  ignore (servo number) 256 = all                      {always obey command} // overrides listen once
// 2  One Time listen (servo number)                       {always obey command}
// 3  set flags (flags) (+toggle debug)                    { bitwise obey }
//    0 enguage cached position                              {always obey command}
//    1 turn servo on                                        {obey if listening}
//    2 turn servo off                                       {obey if listening}
//    3 set cmdpos to curpos                                 {obey if listening}
// 4  set servo position (position)                        {obey if listening}
// 5  set cached position (position)                       {obey if listening}
// 6 get servo current  (servo number)                    {servo number}
// 7 get servo position (servo number)                    {servo number}
// 8 send device model  (servo number)                    {servo number}

unsigned int servoCmd(unsigned int command, unsigned int argument)
{

	unsigned int reply;
	static unsigned int chainAddress = 1023;

	reply = 0;

	switch (command)
	{

	case 0: // listen(id)
		chainAddress = 1023;
		if (argument == 256)
		{
			// Listen all
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				listen[servoIdx] |= 2;
			}
		}
		else
		{
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				if (argument == SERVOADDRESSES[servoIdx])
				{
					listen[servoIdx] |= 2;
					break;
				}
			}
		}
		break;

	case 1: // ignore(id)
		chainAddress = 1023;
		if (argument == 256)
		{
			// Listen all
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				listen[servoIdx] = 0;
			}
		}
		else
		{
			// Listen Specific
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				if (argument == SERVOADDRESSES[servoIdx])
				{
					listen[servoIdx] = 2;
					break;
				}
			}
		}
		break;

	case 2: // listen to only the next command
		chainAddress = 1023;
		if (argument == 256)
		{
			// Listen all
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				listen[servoIdx] |= 1;
			}
		}
		else if (argument >= 512)
		{
			//Update chainAddress
			chainAddress = argument - 512;
			// Then set listen based on chainAddress
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				if (chainAddress == SERVOADDRESSES[servoIdx])
				{
					listen[servoIdx] |= 1;
					break;
				}
			}
		}
		else
		{
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				if (argument == SERVOADDRESSES[servoIdx])
				{
					listen[servoIdx] |= 1;
					break;
				}
			}
		}
		break;

		//       0 enguage cached position                              {always obey command}
		//       1 turn servo on                                        {obey if listening}
		//       2 turn servo off                                       {obey if listening}
		//       3 set cmdpos to curpos                                 {obey if listening}

	case 3: // set flags
		debugToggle();

		if (IsHigh(ENGCACHE, argument))
		{
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				cmdpos[servoIdx] = cachepos[servoIdx];
			}
		}

		if (IsHigh(CMD2CUR, argument))
		{
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				if (listen[servoIdx])
				{
					cmdpos[servoIdx] = 0xFF; // Rue originally read the ADC values
				}
			}
		}

		if (IsHigh(SERVOON, argument))
		{
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				if (listen[servoIdx])
				{
					// Turn on
				}
			}
		}
		else if (IsHigh(SERVOOFF, argument))
		{
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				if (listen[servoIdx])
				{
					// Turn Off
				}
			}
		}
		break;

	case 4: // set servo position
		for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
		{
			if (listen[servoIdx])
			{
				cmdpos[servoIdx] = argument;
			}
		}
		break;

	case 5: // set cached position
		for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
		{
			if (listen[servoIdx])
			{
				cachepos[servoIdx] = argument;
			}
		}
		break;

	case 6: // get servo current
		for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
		{
			if (argument == SERVOADDRESSES[servoIdx])
			{
				reply = PackBits(0, ReplyCur);
				break;
			}
		}
		break;

	case 7: // get servo position
		for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
		{
			if (argument == SERVOADDRESSES[servoIdx])
			{
				reply = PackBits(1, ReplyCur);
				break;
			}
		}
		break;

	case 8: // get model
		for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
		{
			if (argument == SERVOADDRESSES[servoIdx])
			{
				reply = PackBits(Version, ReplyCur);
				break;
			}
		}
		break;
	}

	switch (command)
	{ // clear one time flags
	case 3:
	case 4:
	case 5:
		for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
		{
			listen[servoIdx] &= 2;
		}
		if (chainAddress != 1023)
		{
			chainAddress++;
			for (uint8_t servoIdx = 0; servoIdx < NUMSERVOS; servoIdx++)
			{
				if (chainAddress == SERVOADDRESSES[servoIdx])
				{
					listen[servoIdx] = 1;
					break;
				}
			}
		}
		break;
	}

	return reply;
}


void usart1_isr(void)
{
	uint16_t rxData = 0xFF;
	uint16_t reply = 0xFF;
	
	if( usart_get_flag(USART1, USART_ISR_RXNE) )
	{

		// Receieve the data, using the MiniSSC protocol
		//	This protocol has a header byte (0xFF), followed
		//	by a number (0->254) followed by a number (0-254)
		rxData = usart_recv(USART1);
		reply = dobyte(rxData);

	}
}