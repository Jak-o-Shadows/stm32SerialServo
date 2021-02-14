#ifndef serialServoCommon
#define serialServoCommon

#include <stdint.h>

static double countToDegreesValue = 0.17578125;//180.0 / 1024.0;
static double degreesToCountValue = 5.68888888888889;//1024.0 / 180.0;


double serialServoCountToDegrees(uint16_t count);
uint16_t serialServoDegreesToCount(double degrees);





#endif