#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/cm3/nvic.h>
#include <libopencm3/stm32/timer.h>

#include <libopencm3/stm32/syscfg.h>
#include "stdint.h"


// Datatype for the sequence patterns
typedef struct Command {
	uint32_t time_ms;
	uint8_t channel;
	uint8_t brightness;
	bool initial_on;
	uint32_t time_on_ms;
	uint32_t time_off_ms;
} Command;


/*
static const Command sequence[] = {
	{0,			    0, 0x00, true,  1, 1},  // Dummy row
	{2,     		0, 255, false, 1000, 1000},
	{2,     		1, 255, true,  1000, 1000},
	{2,     		2, 255, false, 1000, 1000},
	{2,     		3, 255, true,  1000, 1000},
	{8000,     		0, 255, true,  1000, 500},
	{8000,     		1, 255, true,  500, 1000},
	{8000,     		2, 255, true,  2000, 2000},
	{8000,     		3, 255, false, 2000, 2000},
	{16000, 		0, 0x00, true,  1, 1}  // Dummy row at end to mark restart
};
uint32_t sequence_length = 10;
*/

static const Command sequence[] = {
	{0,			    0, 0x02, true,  1, 1},  // Dummy row
	{2,     		2, 0x02, true, 1000, 1000},  // 2 off
	{2,     		0, 0xFF, true, 1000, 1000},  // 0 on

	{500,     		3, 0x02, true, 1000, 1000},  // 3 off
	{500,     		0, 0x1f, true, 1000, 1000},  // 0 dim
	{500,     		1, 0xFF, true, 1000, 1000},  // 1 on

	{1000,     		1, 0x1f, true, 1000, 1000},  // 1 dim
	{1000,     		0, 0x02, true, 1000, 1000},  // 0 off
	{1000,     		2, 0xFF, true, 1000, 1000},  // 2 on

	{1500,     		2, 0x1f, true, 1000, 1000},  // 2 dim
	{1000,     		1, 0x02, true, 1000, 1000},  // 1 off
	{1500,     		3, 0xFF, true, 1000, 1000},  // 3 on

	{2000,     		3, 0x1f, true, 1000, 1000},  // 3 dim
};
uint32_t sequence_length = 13;





// Config Servos
#define NUMSERVOS 4
#define IDOFF 0

const uint8_t SERVOADDRESSES[] = {0 + IDOFF,
								  1 + IDOFF,
								  2 + IDOFF,
								  3 + IDOFF};

// Variables
static uint16_t cachepos[NUMSERVOS];
static uint16_t cmdpos[NUMSERVOS];
static uint16_t _cmdpos[NUMSERVOS];
static uint8_t listen[NUMSERVOS];

static Command* channel_current_command[NUMSERVOS];
static uint32_t channel_state_time_ms[NUMSERVOS];
static bool channel_state[NUMSERVOS];

////////////////////////////////////////////////////////
///////////////////uC setup/////////////////////////////
////////////////////////////////////////////////////////

static void clock_setup(void)
{
	rcc_clock_setup_in_hse_8mhz_out_48mhz();
	//rcc_clock_setup_in_hsi_out_48mhz();
	
	// Set AHB prescaler and APB prescaler
	//	Set no division, to give the most flexibility
	//	in that the timer can have a prescaler
	rcc_set_hpre(RCC_CFGR_HPRE_NODIV);
	rcc_set_ppre(RCC_CFGR_PPRE_NODIV);

	// GPIO
	rcc_periph_clock_enable(RCC_GPIOA);
	
	// Timer2 for PWM 1, 2, 3
	rcc_periph_clock_enable(RCC_TIM2);
	// Timer3 for PWM 4
	rcc_periph_clock_enable(RCC_TIM3);
	// Timer14 for sequence updator
	rcc_periph_clock_enable(RCC_TIM14);
	
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
	gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_NONE, GPIO1 | GPIO2 | GPIO3 | GPIO6);
	gpio_set_output_options(GPIOA, GPIO_OTYPE_PP, GPIO_OSPEED_HIGH, GPIO1 | GPIO2 | GPIO3 | GPIO6);
	// Set alternate functions for TIM2 OC channels 2(PA1), 3(PA2), 4(PA3)
	gpio_set_af(GPIOA, GPIO_AF2, GPIO1 | GPIO2 | GPIO3);
	// Set alternate function for TIM3 OC Channel 1 (PA6)
	gpio_set_af(GPIOA, GPIO_AF1, GPIO6);
	
	// USART 1
	gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_NONE, GPIO10);
	// Set alternate function
	gpio_set_af(GPIOA, GPIO_AF1, GPIO10);

}

static void nvic_setup(void)
{
	nvic_enable_irq(NVIC_USART1_IRQ);
	nvic_enable_irq(NVIC_TIM14_IRQ);
}

static void timer_setup(void)
{

	// PWM channel config values
		// Set prescaler
	//	Must use a prescaler, as want to capture 3 ms in a uint16_t
	//	1/((3e-3)/(2^16)) = ~22 MHz max clock speed
	//	Therefore just pick a prescaler of 4
	// Set to 50 Hz
	//	48 MHz /4 = 12 MHz /50 Hz = 240,000 clock ticks
	//	Note: /4 due to the timer prescaler
	const uint8_t pwm_prescaler = 4;
	const uint16_t pwm_period = 255;

	// Configure TIM 2, with channels 1, 2, 3 for PWM 1, 2, 3
	//	This does the pulse widths for each channel
	timer_disable_counter(TIM2);
	timer_set_mode(TIM2, TIM_CR1_CKD_CK_INT, TIM_CR1_CMS_EDGE, TIM_CR1_DIR_UP);

	// ???????????
	timer_disable_preload(TIM2);
	// Set prescaler
	timer_set_prescaler(TIM2, pwm_prescaler);
	timer_set_period(TIM2, pwm_period);  // TODO: Determine why this doesn't quite work (set to 190k)
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
	

	// Setup TIM3 for PWM4 on CH1
 	timer_disable_counter(TIM3);
	timer_set_mode(TIM3, TIM_CR1_CKD_CK_INT, TIM_CR1_CMS_EDGE, TIM_CR1_DIR_UP);

	// ???????????
	timer_disable_preload(TIM3);
	timer_set_prescaler(TIM3, pwm_prescaler);
	timer_set_period(TIM3, pwm_period);
	// Enable continuous mode for repeat
	timer_continuous_mode(TIM3);

	// Configure the channels
	//	Put into PWM mode
	timer_set_oc_mode(TIM3, TIM_OC1, TIM_OCM_PWM1);
	// Enable auto-preload
	timer_enable_oc_preload(TIM3, TIM_OC1);
	//	Put fast mode to speed up transitions
	timer_set_oc_fast_mode(TIM3, TIM_OC1);
	// Set specific OC values for duration
	timer_set_oc_value(TIM3, TIM_OC1, _cmdpos[4]);
	// Set it to actually do it
	timer_enable_oc_output(TIM3, TIM_OC1);


	// Start Both PWM channels
	timer_generate_event(TIM2, TIM_EGR_UG);
	timer_generate_event(TIM3, TIM_EGR_UG);
	timer_enable_counter(TIM2);
	timer_enable_counter(TIM3);
	
	
	// Setup TIM14 as a general "update" timer
	timer_disable_counter(TIM14);
	timer_set_mode(TIM14, TIM_CR1_CKD_CK_INT, TIM_CR1_CMS_EDGE, TIM_CR1_DIR_UP);
	timer_set_prescaler(TIM14, ((rcc_apb1_frequency)/10000));

	// Count the full range, as the compare value is used to set the value
	timer_set_period(TIM14, 65535);
	
	timer_set_oc_value(TIM14, TIM_OC1, 10); //was 10000
	
	timer_enable_counter(TIM14);
	
	timer_enable_irq(TIM14, TIM_DIER_CC1IE);
	timer_enable_counter(TIM14);
	

}


////////////////////////////////////////////////////////
//////////////main//////////////////////////////////////
////////////////////////////////////////////////////////

int main(void)
{
	
	
	// initialise the PWM signal
	for (int i = 0; i < NUMSERVOS; i++)
	{
		cmdpos[i] = 0;//calcNumClocks(0);
		_cmdpos[i] = 0;
	}

	//other
	clock_setup();
	gpio_setup();
	timer_setup();
	usart_setup();

	// Enable interrupts
	nvic_setup();

	gpio_clear(GPIOA, GPIO1 | GPIO2 | GPIO3 | GPIO6);
	
	while (1)
	{
		// Update position to servos every x time
		
		for (int i=0; i<1000000/6; i++){
			__asm__("nop");
		}
		
		for( int i=0; i<NUMSERVOS;i++){
			_cmdpos[i] = cmdpos[i];
		}
		timer_set_oc_value(TIM2, TIM_OC2, _cmdpos[0]);
		timer_set_oc_value(TIM2, TIM_OC3, _cmdpos[1]);
		timer_set_oc_value(TIM2, TIM_OC4, _cmdpos[2]);
		timer_set_oc_value(TIM3, TIM_OC1, _cmdpos[3]);
	
	}

	return 0;
}


void usart1_isr(void)
{
	uint16_t rxData = 0xFF;
	uint16_t reply = 0xFF;
	
	if( usart_get_flag(USART1, USART_ISR_RXNE) )
	{
		// Receieve the data
		rxData = usart_recv(USART1);
	}
}

// This timer is used to update the sequence state
void tim14_isr(void) {

	static uint32_t sequence_idx = 0;
	static uint64_t time_ms = 0;

	static Command *command;
	static Command *nextCommand;
	if (time_ms == 0) {
		nextCommand = &sequence[sequence_idx+1];
	}

	if (timer_get_flag(TIM14, TIM_SR_CC1IF)) {
		timer_clear_flag(TIM14, TIM_SR_CC1IF);

		// Setup next compare time
		uint16_t compare_time = timer_get_counter(TIM14);
		timer_set_oc_value(TIM14, TIM_OC1, 10 + compare_time);

		time_ms++;

		while(( nextCommand->time_ms < time_ms ) && (sequence_idx < (sequence_length)) ){

			channel_current_command[nextCommand->channel] = nextCommand;
			channel_state_time_ms[nextCommand->channel] = 0;
			if( nextCommand->initial_on ){
				channel_state[nextCommand->channel] = true;
				cmdpos[nextCommand->channel] = nextCommand->brightness;
			} else {
				channel_state[nextCommand->channel] = false;
				cmdpos[nextCommand->channel] = 0;
			}

			// Move to next command
			if( sequence_idx < (sequence_length-1) ){
				sequence_idx++;
				nextCommand = &sequence[sequence_idx];
			} else {
				//nextCommand = &sequence[sequence_idx];
				//sequence_idx++; // tick it over so it doesn't run again & stays at the last command
				//reset to start
				sequence_idx = 0;
				time_ms = 0;
				nextCommand = &sequence[sequence_idx];
				break;
			}
		}

		for (int pwm_idx=0;pwm_idx<NUMSERVOS;pwm_idx++) {

			command = channel_current_command[pwm_idx];

			// Set the twinkle state
			channel_state_time_ms[pwm_idx]++;
			if( channel_state[pwm_idx] ){
				// We are in the on phase
				if( channel_state_time_ms[pwm_idx]>command->time_on_ms ){
					// Switch to off phase
					channel_state_time_ms[pwm_idx] = 0;
					channel_state[pwm_idx] = false;
					cmdpos[pwm_idx] = 0;
				}
			} else {
				// We are in the off phase
				if( channel_state_time_ms[pwm_idx]>command->time_off_ms ){
					// Switch to off phase
					channel_state_time_ms[pwm_idx] = 0;
					channel_state[pwm_idx] = true;
					cmdpos[pwm_idx] = command->brightness;
				}
			}
		}


	}

}

