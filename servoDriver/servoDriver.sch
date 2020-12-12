EESchema Schematic File Version 4
LIBS:servoDriver-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_ST_STM32F0:STM32F042F6Px U2
U 1 1 5E9A8AF7
P 5900 3450
F 0 "U2" H 5900 2561 50  0000 C CNN
F 1 "STM32F042F6Px" H 5900 2470 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 5400 2750 50  0001 R CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/DM00105814.pdf" H 5900 3450 50  0001 C CNN
	1    5900 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 2900 3400 3500
Wire Wire Line
	3400 4000 3400 3500
Connection ~ 3400 3500
Wire Wire Line
	3500 3000 3500 3600
Wire Wire Line
	3500 3600 3500 4100
Connection ~ 3500 3600
Connection ~ 3400 2900
Connection ~ 3500 3000
Wire Wire Line
	3000 1400 3400 1400
Text Label 3000 1400 0    50   ~ 0
P-
Text Label 3500 1400 0    50   ~ 0
P+
Wire Wire Line
	4250 1300 4350 1300
Wire Wire Line
	4350 1300 4350 1500
Wire Wire Line
	3600 1800 3850 1800
Wire Wire Line
	3850 1800 3850 1300
Wire Wire Line
	3700 1900 3950 1900
Wire Wire Line
	3950 1900 3950 1500
Wire Wire Line
	3950 1500 4350 1500
Text Label 3850 1400 0    50   ~ 0
Comms1
Text Label 3950 1500 0    50   ~ 0
Comms2
$Comp
L Connector:Conn_01x04_Male J3
U 1 1 5E9BFB26
P 7750 2450
F 0 "J3" H 7722 2332 50  0000 R CNN
F 1 "SWD" H 7722 2423 50  0000 R CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_1x04_P1.27mm_Vertical" H 7750 2450 50  0001 C CNN
F 3 "~" H 7750 2450 50  0001 C CNN
	1    7750 2450
	-1   0    0    1   
$EndComp
Wire Wire Line
	5700 2750 5800 2750
Wire Wire Line
	5800 2550 5800 2750
Connection ~ 5800 2750
Wire Wire Line
	8000 2250 8000 4300
Wire Wire Line
	8000 4300 5850 4300
Wire Wire Line
	5700 4300 5700 4250
Wire Wire Line
	7550 2450 7450 2450
Wire Wire Line
	7450 2450 7450 3950
Wire Wire Line
	7450 3950 6500 3950
Wire Wire Line
	6500 4050 7350 4050
Wire Wire Line
	7350 4050 7350 2350
Wire Wire Line
	7350 2350 7550 2350
$Comp
L Device:Crystal Y1
U 1 1 5E9C5753
P 4850 3700
F 0 "Y1" V 4804 3831 50  0000 L CNN
F 1 "8MHz" V 4895 3831 50  0000 L CNN
F 2 "Crystal:Crystal_SMD_5032-2Pin_5.0x3.2mm_HandSoldering" H 4850 3700 50  0001 C CNN
F 3 "~" H 4850 3700 50  0001 C CNN
	1    4850 3700
	0    1    1    0   
$EndComp
Wire Wire Line
	5300 3650 5300 3550
Wire Wire Line
	5300 3550 4850 3550
Wire Wire Line
	5300 3750 5300 3850
Wire Wire Line
	5300 3850 4850 3850
$Comp
L Device:C C1
U 1 1 5E9C8C76
P 4500 3550
F 0 "C1" V 4248 3550 50  0000 C CNN
F 1 "20pF" V 4339 3550 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4538 3400 50  0001 C CNN
F 3 "~" H 4500 3550 50  0001 C CNN
	1    4500 3550
	0    1    1    0   
$EndComp
$Comp
L Device:C C2
U 1 1 5E9CA48C
P 4500 3850
F 0 "C2" V 4248 3850 50  0000 C CNN
F 1 "20pF" V 4339 3850 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4538 3700 50  0001 C CNN
F 3 "~" H 4500 3850 50  0001 C CNN
	1    4500 3850
	0    1    1    0   
$EndComp
Wire Wire Line
	4850 3550 4650 3550
Connection ~ 4850 3550
Wire Wire Line
	4850 3850 4650 3850
Connection ~ 4850 3850
Wire Wire Line
	4350 3550 4350 3850
Wire Wire Line
	4350 3850 4350 4300
Connection ~ 4350 3850
Connection ~ 5700 4300
$Comp
L Regulator_Linear:AP131-33 U3
U 1 1 5E9CDF7E
P 6250 1500
F 0 "U3" H 6250 1842 50  0000 C CNN
F 1 "AP131-33" H 6250 1751 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 6250 1825 50  0001 C CNN
F 3 "http://www.diodes.com/_files/datasheets/AP131.pdf" H 6250 1500 50  0001 C CNN
	1    6250 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 1400 5700 1400
Wire Wire Line
	5700 1400 5700 1500
Wire Wire Line
	5700 1500 5950 1500
Wire Wire Line
	5700 1400 5550 1400
Wire Wire Line
	5000 1400 5000 1050
Wire Wire Line
	5000 1050 3500 1050
Connection ~ 5700 1400
Wire Wire Line
	6250 1800 5550 1800
Wire Wire Line
	4900 1800 4900 950 
Wire Wire Line
	4900 950  3000 950 
Wire Wire Line
	3000 950  3000 1400
Wire Wire Line
	6250 1800 6650 1800
Connection ~ 6250 1800
$Comp
L Device:C C5
U 1 1 5E9DB1D8
P 6650 1650
F 0 "C5" H 6535 1604 50  0000 R CNN
F 1 "100nF" H 6535 1695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6688 1500 50  0001 C CNN
F 3 "~" H 6650 1650 50  0001 C CNN
	1    6650 1650
	-1   0    0    1   
$EndComp
Connection ~ 6650 1800
$Comp
L Device:C C6
U 1 1 5E9DE461
P 7200 1650
F 0 "C6" H 7085 1604 50  0000 R CNN
F 1 "10nF" H 7085 1695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 7238 1500 50  0001 C CNN
F 3 "~" H 7200 1650 50  0001 C CNN
	1    7200 1650
	-1   0    0    1   
$EndComp
$Comp
L Device:C C7
U 1 1 5E9DF73D
P 7650 1650
F 0 "C7" H 7535 1604 50  0000 R CNN
F 1 "100nF" H 7535 1695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 7688 1500 50  0001 C CNN
F 3 "~" H 7650 1650 50  0001 C CNN
	1    7650 1650
	-1   0    0    1   
$EndComp
Wire Wire Line
	6550 1500 6650 1500
Wire Wire Line
	6650 1800 7200 1800
Wire Wire Line
	7650 1800 7200 1800
Connection ~ 7200 1800
Wire Wire Line
	7650 1500 7650 1400
Wire Wire Line
	6550 1400 7200 1400
Wire Wire Line
	7200 1500 7200 1400
Connection ~ 7200 1400
Wire Wire Line
	7200 1800 7200 2250
Wire Wire Line
	7200 2250 7550 2250
Connection ~ 7550 2250
Wire Wire Line
	7550 2250 8000 2250
$Comp
L Device:C C4
U 1 1 5E9EF5BF
P 5550 1650
F 0 "C4" H 5435 1604 50  0000 R CNN
F 1 "10nF" H 5435 1695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 5588 1500 50  0001 C CNN
F 3 "~" H 5550 1650 50  0001 C CNN
	1    5550 1650
	-1   0    0    1   
$EndComp
Connection ~ 5550 1800
Wire Wire Line
	5550 1800 5100 1800
$Comp
L Device:C C3
U 1 1 5E9EFB59
P 5100 1650
F 0 "C3" H 4985 1604 50  0000 R CNN
F 1 "100nF" H 4985 1695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 5138 1500 50  0001 C CNN
F 3 "~" H 5100 1650 50  0001 C CNN
	1    5100 1650
	-1   0    0    1   
$EndComp
Connection ~ 5100 1800
Wire Wire Line
	5100 1800 4900 1800
Wire Wire Line
	5550 1500 5550 1400
Connection ~ 5550 1400
Wire Wire Line
	5550 1400 5100 1400
Wire Wire Line
	5100 1500 5100 1400
Connection ~ 5100 1400
Wire Wire Line
	5100 1400 5000 1400
Wire Wire Line
	7750 2550 8800 2550
Wire Wire Line
	8800 2550 8800 1800
Wire Wire Line
	7200 1400 7650 1400
Connection ~ 7650 1400
Text Label 8800 1400 0    50   ~ 0
3v3
Text Label 6700 3950 0    50   ~ 0
DIO
Text Label 6900 4050 0    50   ~ 0
DCLK
Text Label 6850 2550 0    50   ~ 0
3v3
Wire Wire Line
	6350 5250 6450 5250
Wire Wire Line
	7050 5250 7050 3750
Wire Wire Line
	7050 3750 6500 3750
Wire Wire Line
	6350 5350 6550 5350
Wire Wire Line
	6950 5350 6950 3850
Wire Wire Line
	6950 3850 6500 3850
Wire Wire Line
	5850 4750 5850 4300
Connection ~ 5850 4300
Wire Wire Line
	5850 4300 5700 4300
Wire Wire Line
	5850 5550 8800 5550
Wire Wire Line
	8800 5550 8800 2550
Connection ~ 8800 2550
Text Label 6550 5250 0    50   ~ 0
rx
Text Label 6700 5350 0    50   ~ 0
tx
Wire Wire Line
	6500 3050 6600 3050
Wire Wire Line
	6600 3050 6600 2350
Wire Wire Line
	6600 2350 4150 2350
Wire Wire Line
	4150 2350 4150 4200
Wire Wire Line
	6450 3150 6500 3150
Wire Wire Line
	6650 3150 6650 2300
Wire Wire Line
	6650 2300 4100 2300
Wire Wire Line
	4100 2300 4100 3700
Connection ~ 6500 3150
Wire Wire Line
	6500 3150 6650 3150
Wire Wire Line
	6500 3250 6700 3250
Wire Wire Line
	6700 3250 6700 2250
Wire Wire Line
	6700 2250 4050 2250
Wire Wire Line
	4050 2250 4050 3100
Text Label 3800 3100 0    50   ~ 0
pwm1
Text Label 3850 3700 0    50   ~ 0
pwm2
Text Label 3850 4200 0    50   ~ 0
pwm3
NoConn ~ 6350 4950
NoConn ~ 6350 5050
$Comp
L Interface_CAN_LIN:TCAN330 U1
U 1 1 5EA077ED
P 5850 5150
F 0 "U1" H 5850 4569 50  0000 C CNN
F 1 "TCAN330" H 5850 4660 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-8_Handsoldering" H 5850 4650 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/tcan337.pdf" H 5850 5150 50  0001 C CNN
	1    5850 5150
	-1   0    0    1   
$EndComp
Wire Wire Line
	5350 5250 5200 5250
Wire Wire Line
	5350 5050 5300 5050
$Comp
L Jumper:SolderJumper_2_Open JP1
U 1 1 5EA52E19
P 5850 5850
F 0 "JP1" H 5850 6055 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 5850 5964 50  0000 C CNN
F 2 "servoDriver:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 5850 5850 50  0001 C CNN
F 3 "~" H 5850 5850 50  0001 C CNN
	1    5850 5850
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP2
U 1 1 5EA53FF8
P 5850 6150
F 0 "JP2" H 5850 6355 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 5850 6264 50  0000 C CNN
F 2 "servoDriver:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 5850 6150 50  0001 C CNN
F 3 "~" H 5850 6150 50  0001 C CNN
	1    5850 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 5850 6450 5850
Wire Wire Line
	6450 5850 6450 5250
Connection ~ 6450 5250
Wire Wire Line
	6450 5250 7050 5250
Wire Wire Line
	5700 5850 5300 5850
Wire Wire Line
	5300 5850 5300 5050
Connection ~ 5300 5050
Wire Wire Line
	5300 5050 3600 5050
Wire Wire Line
	5200 5250 5200 6150
Wire Wire Line
	5200 6150 5700 6150
Connection ~ 5200 5250
Wire Wire Line
	5200 5250 3700 5250
Wire Wire Line
	6000 6150 6550 6150
Wire Wire Line
	6550 6150 6550 5350
Connection ~ 6550 5350
Wire Wire Line
	6550 5350 6950 5350
Wire Wire Line
	2400 2900 2400 3100
Wire Wire Line
	2400 2900 3400 2900
Wire Wire Line
	2450 3200 2450 3000
Wire Wire Line
	2450 3000 3500 3000
Wire Wire Line
	2500 3300 2500 3100
Wire Wire Line
	2500 3100 4050 3100
Wire Wire Line
	2500 3400 2500 3500
Wire Wire Line
	2500 3500 3400 3500
Wire Wire Line
	2450 3600 2450 3500
Wire Wire Line
	2450 3600 3500 3600
Wire Wire Line
	2400 3600 2400 3700
Wire Wire Line
	2400 3700 4100 3700
Wire Wire Line
	2350 4000 2350 3700
Wire Wire Line
	2350 4000 3400 4000
Wire Wire Line
	2300 3800 2300 4100
Wire Wire Line
	2300 4100 3500 4100
Wire Wire Line
	2250 4200 2250 3900
Wire Wire Line
	2250 4200 4150 4200
$Comp
L Connector_Generic:Conn_02x04_Odd_Even J2
U 1 1 5FCB30D7
P 2400 2200
F 0 "J2" V 2496 1912 50  0000 R CNN
F 1 "Conn_02x04_Odd_Even" V 2405 1912 50  0000 R CNN
F 2 "" H 2400 2200 50  0001 C CNN
F 3 "~" H 2400 2200 50  0001 C CNN
	1    2400 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3600 1800 3600 2550
Wire Wire Line
	3700 1900 3700 2450
Wire Wire Line
	3400 1400 3400 1650
Wire Wire Line
	3500 1050 3500 1750
Wire Wire Line
	2300 1900 2300 1650
Wire Wire Line
	2300 1650 3400 1650
Connection ~ 3400 1650
Wire Wire Line
	3400 1650 3400 2750
Wire Wire Line
	2300 2400 2300 2750
Wire Wire Line
	2300 2750 3400 2750
Connection ~ 3400 2750
Wire Wire Line
	3400 2750 3400 2900
Wire Wire Line
	2400 2400 2400 2650
Wire Wire Line
	2400 2650 3500 2650
Connection ~ 3500 2650
Wire Wire Line
	3500 2650 3500 3000
Wire Wire Line
	2400 1900 2400 1750
Wire Wire Line
	2400 1750 3500 1750
Connection ~ 3500 1750
Wire Wire Line
	3500 1750 3500 2650
Wire Wire Line
	2500 1900 2500 1800
Wire Wire Line
	2500 1800 3600 1800
Connection ~ 3600 1800
Wire Wire Line
	2500 2400 2500 2550
Wire Wire Line
	2500 2550 3600 2550
Connection ~ 3600 2550
Wire Wire Line
	3600 2550 3600 5050
Wire Wire Line
	2600 2400 2600 2450
Wire Wire Line
	2600 2450 3700 2450
Connection ~ 3700 2450
Wire Wire Line
	3700 2450 3700 5250
Wire Wire Line
	2600 1900 3700 1900
Connection ~ 3700 1900
$Comp
L Device:LED D1
U 1 1 5FD5B8C2
P 8600 1800
F 0 "D1" H 8593 1545 50  0000 C CNN
F 1 "LED" H 8593 1636 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 8600 1800 50  0001 C CNN
F 3 "~" H 8600 1800 50  0001 C CNN
	1    8600 1800
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small R1
U 1 1 5FD84616
P 8250 1800
F 0 "R1" V 8054 1800 50  0000 C CNN
F 1 "R_Small" V 8145 1800 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 8250 1800 50  0001 C CNN
F 3 "~" H 8250 1800 50  0001 C CNN
	1    8250 1800
	0    1    1    0   
$EndComp
Wire Wire Line
	7650 1400 8800 1400
Wire Wire Line
	8800 1800 8750 1800
Connection ~ 8800 1800
Wire Wire Line
	8800 1800 8800 1400
Wire Wire Line
	8450 1800 8350 1800
Wire Wire Line
	8150 1800 7650 1800
Connection ~ 7650 1800
$Comp
L Connector_Generic:Conn_01x12 J1
U 1 1 5FDA81AB
P 1600 3600
F 0 "J1" H 1518 4317 50  0000 C CNN
F 1 "Conn_01x12" H 1518 4226 50  0000 C CNN
F 2 "servoDriver:PinHeader_3x04_P2.54mm_Vertical" H 1600 3600 50  0001 C CNN
F 3 "~" H 1600 3600 50  0001 C CNN
	1    1600 3600
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1800 3100 2400 3100
Wire Wire Line
	1800 3200 2450 3200
Wire Wire Line
	1800 3300 2500 3300
Wire Wire Line
	1800 3400 2500 3400
Wire Wire Line
	1800 3500 2450 3500
Wire Wire Line
	1800 3600 2400 3600
Wire Wire Line
	1800 3700 2350 3700
Wire Wire Line
	1800 3800 2300 3800
Wire Wire Line
	1800 3900 2250 3900
Wire Wire Line
	3400 4000 3400 4500
Wire Wire Line
	3400 4500 2050 4500
Wire Wire Line
	2050 4500 2050 4000
Wire Wire Line
	2050 4000 1800 4000
Connection ~ 3400 4000
Wire Wire Line
	3500 4100 3500 4600
Wire Wire Line
	3500 4600 1950 4600
Wire Wire Line
	1950 4600 1950 4100
Wire Wire Line
	1950 4100 1800 4100
Connection ~ 3500 4100
Wire Wire Line
	4350 4300 5300 4300
Wire Wire Line
	6500 3550 6750 3550
Wire Wire Line
	6750 3550 6750 2550
Wire Wire Line
	6750 2200 4200 2200
Wire Wire Line
	4200 2200 4200 4700
Wire Wire Line
	4200 4700 1850 4700
Wire Wire Line
	1850 4700 1850 4200
Wire Wire Line
	1850 4200 1800 4200
Wire Wire Line
	6750 2550 6750 2200
Wire Wire Line
	5800 2550 7550 2550
Text Label 3850 4700 0    50   ~ 0
pwm4
Wire Wire Line
	5300 4050 5300 4300
Connection ~ 5300 4300
Wire Wire Line
	5300 4300 5700 4300
$EndSCHEMATC
