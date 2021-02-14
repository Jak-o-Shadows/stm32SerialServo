#ifndef serialServoMaster
#define serialServoMaster

#include <stdint.h>

static const uint8_t serialServo_ALLSERVOS = 256;

// Command values
static const uint8_t serialServo_COMMANDlisten =        0;
static const uint8_t serialServo_COMMANDignore =        1;
static const uint8_t serialServo_COMMANDlistenOnce =    2;
static const uint8_t serialServo_COMMANDsetFlags =      3;
static const uint8_t serialServo_COMMANDsetPosition =   4;
static const uint8_t serialServo_COMMANDcachePos =      5;
static const uint8_t serialServo_COMMANDgetCurrent =    6;
static const uint8_t serialServo_COMMANDgetPosition =   7;
static const uint8_t serialServo_COMMANDgetModel =      8;

// Flags
static const uint8_t serialServo_FLAGexecPos =          0;
static const uint8_t serialServo_FLAGpowerUp =          1;
static const uint8_t serialServo_FLAGpowerDown =        2;
static const uint8_t serialServo_FLAGpreset =           3;



void serialServo_setup(uint32_t usart);
void serialServo_setServoPos(uint32_t usart, uint8_t servo, uint16_t pos);

void serialServo_setServoCachePos(uint32_t usart, uint8_t servo, uint16_t pos);
void serialServo_executeCachePos(uint32_t usart, uint8_t servo);



#endif