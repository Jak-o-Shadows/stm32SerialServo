#include "serialServo/serialServoCommon.h"


double serialServoCountToDegrees(uint16_t count){
    return countToDegreesValue * count;
}

uint16_t serialServoDegreesToCount(double degrees){
    return (uint16_t) ( degreesToCountValue * degrees );
}