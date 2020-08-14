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

#include "serialServo/serialServoSlave.h"


// Config Servos
#define NUMSERVOS 3
#define IDOFF 0

const uint8_t SERVOADDRESSES[] = {0 + IDOFF,
								  1 + IDOFF,
								  2 + IDOFF};




// Variables

static uint16_t cachepos[NUMSERVOS];
static uint16_t cmdpos[NUMSERVOS];
static uint16_t _cmdpos[NUMSERVOS];
static uint8_t listen[NUMSERVOS];


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
	
	
	// Manually command the servos
	for (int i = 0; i < NUMSERVOS; i++)
	{
		// Set the hidden and commanded values to different,
		//	so that it automatically gets set.
		cmdpos[i] = calcNumClocks(0);
		_cmdpos[i] = 0;
	}
	// Initialise the serial servo controller
	serialServoSlave_setup(&cmdpos, &cachepos, &listen, NUMSERVOS, &SERVOADDRESSES);



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
		
		timer_set_oc_value(TIM2, TIM_OC2, 25*_cmdpos[0]);
		timer_set_oc_value(TIM2, TIM_OC3, 25*_cmdpos[1]);
		timer_set_oc_value(TIM2, TIM_OC4, 25*_cmdpos[2]);
		
		
		
		
	}


	return 0;
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
		reply = serialServoSlave_dobyte(rxData);

	}
}