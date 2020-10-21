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
L MCU_ST_STM32F0:STM32F042F6Px U1
U 1 1 5E9A8AF7
P 5900 3450
F 0 "U1" H 5900 2561 50  0000 C CNN
F 1 "STM32F042F6Px" H 5900 2470 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 5400 2750 50  0001 R CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/DM00105814.pdf" H 5900 3450 50  0001 C CNN
	1    5900 3450
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Male J3
U 1 1 5E9A9CBE
P 2750 3000
F 0 "J3" H 2858 3281 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2858 3190 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 2750 3000 50  0001 C CNN
F 3 "~" H 2750 3000 50  0001 C CNN
	1    2750 3000
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Male J4
U 1 1 5E9AB154
P 2750 3600
F 0 "J4" H 2858 3881 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2858 3790 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 2750 3600 50  0001 C CNN
F 3 "~" H 2750 3600 50  0001 C CNN
	1    2750 3600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Male J5
U 1 1 5E9AB91C
P 2750 4100
F 0 "J5" H 2858 4381 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2858 4290 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 2750 4100 50  0001 C CNN
F 3 "~" H 2750 4100 50  0001 C CNN
	1    2750 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 2900 3400 2900
Wire Wire Line
	3400 2900 3400 3500
Wire Wire Line
	3400 3500 2950 3500
Wire Wire Line
	2950 4000 3400 4000
Wire Wire Line
	3400 4000 3400 3500
Connection ~ 3400 3500
Wire Wire Line
	2950 3000 3500 3000
Wire Wire Line
	3500 3000 3500 3600
Wire Wire Line
	3500 3600 2950 3600
Wire Wire Line
	3500 3600 3500 4100
Wire Wire Line
	3500 4100 2950 4100
Connection ~ 3500 3600
$Comp
L Connector:Conn_01x04_Male J1
U 1 1 5E9B008F
P 2750 1800
F 0 "J1" H 2858 2081 50  0000 C CNN
F 1 "Conn_01x04_Male" H 2858 1990 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 2750 1800 50  0001 C CNN
F 3 "~" H 2750 1800 50  0001 C CNN
	1    2750 1800
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male J2
U 1 1 5E9B0D51
P 2750 2350
F 0 "J2" H 2858 2631 50  0000 C CNN
F 1 "Conn_01x04_Male" H 2858 2540 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 2750 2350 50  0001 C CNN
F 3 "~" H 2750 2350 50  0001 C CNN
	1    2750 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 1700 3400 1700
Wire Wire Line
	3400 1700 3400 2250
Connection ~ 3400 2900
Wire Wire Line
	2950 2250 3400 2250
Connection ~ 3400 2250
Wire Wire Line
	3400 2250 3400 2900
Wire Wire Line
	2950 1800 3500 1800
Wire Wire Line
	3500 1800 3500 2350
Connection ~ 3500 3000
Wire Wire Line
	2950 2350 3500 2350
Connection ~ 3500 2350
Wire Wire Line
	3500 2350 3500 3000
Wire Wire Line
	2950 1900 3600 1900
Wire Wire Line
	3600 1900 3600 2450
Wire Wire Line
	3600 2450 2950 2450
Wire Wire Line
	2950 2000 3700 2000
Wire Wire Line
	3700 2000 3700 2550
Wire Wire Line
	3700 2550 2950 2550
Wire Wire Line
	3000 1400 3400 1400
Wire Wire Line
	3400 1400 3400 1700
Connection ~ 3400 1700
Connection ~ 3500 1800
Text Label 3000 1400 0    50   ~ 0
P-
Text Label 3500 1400 0    50   ~ 0
P+
Wire Wire Line
	4250 1300 4350 1300
Wire Wire Line
	4350 1300 4350 1500
Wire Wire Line
	3600 1900 3850 1900
Wire Wire Line
	3850 1900 3850 1300
Connection ~ 3600 1900
Wire Wire Line
	3700 2000 3950 2000
Wire Wire Line
	3950 2000 3950 1500
Wire Wire Line
	3950 1500 4350 1500
Connection ~ 3700 2000
Text Label 3850 1400 0    50   ~ 0
Comms1
Text Label 3950 1500 0    50   ~ 0
Comms2
$Comp
L Connector:Conn_01x04_Male J6
U 1 1 5E9BFB26
P 7750 2450
F 0 "J6" H 7722 2332 50  0000 R CNN
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
Wire Wire Line
	4350 4300 5300 4300
Connection ~ 4350 3850
Connection ~ 5700 4300
$Comp
L Regulator_Linear:AP131-33 U2
U 1 1 5E9CDF7E
P 6250 1500
F 0 "U2" H 6250 1842 50  0000 C CNN
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
	3500 1050 3500 1800
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
	5800 2550 7550 2550
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
	7750 2550 8150 2550
Wire Wire Line
	8150 2550 8150 1400
Wire Wire Line
	7200 1400 7650 1400
Connection ~ 7650 1400
Wire Wire Line
	7650 1400 8150 1400
Text Label 8150 1400 0    50   ~ 0
3v3
Text Label 6700 3950 0    50   ~ 0
DIO
Text Label 6900 4050 0    50   ~ 0
DCLK
Text Label 6750 2550 0    50   ~ 0
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
Connection ~ 3700 2550
Wire Wire Line
	3600 2450 3600 5050
Connection ~ 3600 2450
Wire Wire Line
	5850 4750 5850 4300
Connection ~ 5850 4300
Wire Wire Line
	5850 4300 5700 4300
Wire Wire Line
	5850 5550 8150 5550
Wire Wire Line
	8150 5550 8150 2550
Connection ~ 8150 2550
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
	4150 4200 2950 4200
Wire Wire Line
	6450 3150 6500 3150
Wire Wire Line
	6650 3150 6650 2300
Wire Wire Line
	6650 2300 4100 2300
Wire Wire Line
	4100 2300 4100 3700
Wire Wire Line
	4100 3700 2950 3700
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
Wire Wire Line
	4050 3100 2950 3100
Text Label 3800 3100 0    50   ~ 0
pwm1
Text Label 3850 3700 0    50   ~ 0
pwm2
Text Label 3850 4200 0    50   ~ 0
pwm3
NoConn ~ 6350 4950
NoConn ~ 6350 5050
$Comp
L Interface_CAN_LIN:TCAN330 U3
U 1 1 5EA077ED
P 5850 5150
F 0 "U3" H 5850 4569 50  0000 C CNN
F 1 "TCAN330" H 5850 4660 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-8_Handsoldering" H 5850 4650 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/tcan337.pdf" H 5850 5150 50  0001 C CNN
	1    5850 5150
	-1   0    0    1   
$EndComp
Wire Wire Line
	5350 5250 5200 5250
Wire Wire Line
	3700 2550 3700 5250
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
	5300 4050 5300 4300
Connection ~ 5300 4300
Wire Wire Line
	5300 4300 5700 4300
$EndSCHEMATC
