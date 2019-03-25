
;CodeVisionAVR C Compiler V3.34 Evaluation
;(C) Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega8535L
;Program type           : Application
;Clock frequency        : 3.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega8535L
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x025F
	.EQU __DSTACK_SIZE=0x0080
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x40:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x02
	.DW  __REG_BIT_VARS*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0xE0

	.CSEG
;#include <mega8535.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;
;void send_data(int);
;
;#define b_clr_and_save PINB.0
;bit b_clr_and_save_p;
;bit b_clr_and_save_a;
;
;#define b_start PINB.1
;bit b_start_p;
;bit b_start_a;
;
;#define b_stop PINB.2
;bit b_stop_p;
;bit b_stop_a;
;
;#define MEM_SIZE 10
;#define INST_ARR 1
;#define INST_ABJ 2
;#define INST_IZQ 3
;#define INST_DER 4
;eeprom char memory[MEM_SIZE];
;
;#define b_der PINB.3
;bit b_der_p;
;bit b_der_a;
;
;#define b_izq PINB.4
;bit b_izq_p;
;bit b_izq_a;
;
;#define b_arr PINB.5
;bit b_arr_p;
;bit b_arr_a;
;
;#define b_abj PINB.6
;bit b_abj_p;
;bit b_abj_a;
;
;void main(void)
; 0000 002A {

	.CSEG
_main:
; .FSTART _main
; 0000 002B     int i = 0;
; 0000 002C     bit completed = 0;
; 0000 002D DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
;	i -> R16,R17
;	completed -> R15.0
	CLR  R15
	RCALL SUBOPT_0x0
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 002E PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 002F 
; 0000 0030 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0031 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 0032 
; 0000 0033 DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 0034 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0035 
; 0000 0036 DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
	LDI  R30,LOW(255)
	OUT  0x11,R30
; 0000 0037 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0038 
; 0000 0039 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 003A TCNT0=0x00;
	OUT  0x32,R30
; 0000 003B OCR0=0x00;
	OUT  0x3C,R30
; 0000 003C 
; 0000 003D TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 003E TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 003F TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0040 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0041 ICR1H=0x00;
	OUT  0x27,R30
; 0000 0042 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0043 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0044 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0045 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0046 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0047 
; 0000 0048 ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0049 TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 004A TCNT2=0x00;
	OUT  0x24,R30
; 0000 004B OCR2=0x00;
	OUT  0x23,R30
; 0000 004C 
; 0000 004D TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 004E 
; 0000 004F MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 0050 MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 0051 
; 0000 0052 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 0053 
; 0000 0054 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0055 SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 0056 
; 0000 0057 ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 0058 
; 0000 0059 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 005A 
; 0000 005B TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 005C 
; 0000 005D     while (1)
_0x3:
; 0000 005E     {
; 0000 005F         // Se borran las instrucciones y se guardan una por una las nuevas
; 0000 0060          if(b_clr_and_save == 0) {
	SBIC 0x16,0
	RJMP _0x6
; 0000 0061              b_clr_and_save_a = 0;
	CLT
	RJMP _0x76
; 0000 0062          } else {
_0x6:
; 0000 0063              b_clr_and_save_a = 1;
	SET
_0x76:
	BLD  R2,1
; 0000 0064          }
; 0000 0065          if((b_clr_and_save_p == 1) && (b_clr_and_save_a == 0)) {// Cambio de flanco de 1 a 0
	SBRS R2,0
	RJMP _0x9
	SBRS R2,1
	RJMP _0xA
_0x9:
	RJMP _0x8
_0xA:
; 0000 0066             // Borrado
; 0000 0067 
; 0000 0068             for (i = 0; i < MEM_SIZE; i++) {
	RCALL SUBOPT_0x0
_0xC:
	__CPWRN 16,17,10
	BRGE _0xD
; 0000 0069                 memory[i] = 0;
	RCALL SUBOPT_0x1
	LDI  R30,LOW(0)
	RCALL __EEPROMWRB
; 0000 006A             }
	RCALL SUBOPT_0x2
	RJMP _0xC
_0xD:
; 0000 006B             // Nuevas Instrucciones
; 0000 006C             PORTC.0 = 1;
	SBI  0x15,0
; 0000 006D             completed = 0;
	CLT
	BLD  R15,0
; 0000 006E             i = 0;
	RCALL SUBOPT_0x0
; 0000 006F 
; 0000 0070             while (!completed) {
_0x10:
	SBRC R15,0
	RJMP _0x12
; 0000 0071                /* Boton arriba */
; 0000 0072                if(b_arr == 0) {
	SBIC 0x16,5
	RJMP _0x13
; 0000 0073                    b_arr_a = 0;
	CLT
	RJMP _0x77
; 0000 0074                } else {
_0x13:
; 0000 0075                    b_arr_a = 1;
	SET
_0x77:
	BLD  R3,3
; 0000 0076                }
; 0000 0077                if((b_arr_p == 1) && (b_arr_a == 0))// Cambio de flanco de 1 a 0
	SBRS R3,2
	RJMP _0x16
	SBRS R3,3
	RJMP _0x17
_0x16:
	RJMP _0x15
_0x17:
; 0000 0078                {
; 0000 0079                    // Guardamos un 1 para la izquierda
; 0000 007A                    memory[i] = INST_ARR;
	RCALL SUBOPT_0x1
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x3
; 0000 007B                    i++;
; 0000 007C                    delay_ms(40); //Se coloca retardo de 40 ms para eliminar rebotes
	RCALL SUBOPT_0x4
; 0000 007D                }
; 0000 007E                b_arr_p=b_arr_a;
_0x15:
	BST  R3,3
	BLD  R3,2
; 0000 007F 
; 0000 0080                /* Boton abajo */
; 0000 0081                if(b_abj == 0) {
	SBIC 0x16,6
	RJMP _0x18
; 0000 0082                    b_abj_a = 0;
	CLT
	RJMP _0x78
; 0000 0083                } else {
_0x18:
; 0000 0084                    b_abj_a = 1;
	SET
_0x78:
	BLD  R3,5
; 0000 0085                }
; 0000 0086                if((b_abj_p == 1) && (b_abj_a == 0))// Cambio de flanco de 1 a 0
	SBRS R3,4
	RJMP _0x1B
	SBRS R3,5
	RJMP _0x1C
_0x1B:
	RJMP _0x1A
_0x1C:
; 0000 0087                {
; 0000 0088                    // Guardamos un 1 para la izquierda
; 0000 0089                    memory[i] = INST_ABJ;
	RCALL SUBOPT_0x1
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x3
; 0000 008A                    i++;
; 0000 008B                    delay_ms(40); //Se coloca retardo de 40 ms para eliminar rebotes
	RCALL SUBOPT_0x4
; 0000 008C                }
; 0000 008D                b_abj_p=b_abj_a;
_0x1A:
	BST  R3,5
	BLD  R3,4
; 0000 008E 
; 0000 008F 
; 0000 0090                /* Boton izquierdo */
; 0000 0091                if(b_izq == 0) {
	SBIC 0x16,4
	RJMP _0x1D
; 0000 0092                    b_izq_a = 0;
	CLT
	RJMP _0x79
; 0000 0093                } else {
_0x1D:
; 0000 0094                    b_izq_a = 1;
	SET
_0x79:
	BLD  R3,1
; 0000 0095                }
; 0000 0096                if((b_izq_p == 1) && (b_izq_a == 0))// Cambio de flanco de 1 a 0
	SBRS R3,0
	RJMP _0x20
	SBRS R3,1
	RJMP _0x21
_0x20:
	RJMP _0x1F
_0x21:
; 0000 0097                {
; 0000 0098                    // Guardamos un 3 para la izquierda
; 0000 0099                    memory[i] = INST_IZQ;
	RCALL SUBOPT_0x1
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x3
; 0000 009A                    i++;
; 0000 009B                    delay_ms(40); //Se coloca retardo de 40 ms para eliminar rebotes
	RCALL SUBOPT_0x4
; 0000 009C                }
; 0000 009D                b_izq_p=b_izq_a;
_0x1F:
	BST  R3,1
	BLD  R3,0
; 0000 009E 
; 0000 009F 
; 0000 00A0                 /* Boton derecho */
; 0000 00A1                if(b_der == 0) {
	SBIC 0x16,3
	RJMP _0x22
; 0000 00A2                    b_der_a = 0;
	CLT
	RJMP _0x7A
; 0000 00A3                } else {
_0x22:
; 0000 00A4                    b_der_a = 1;
	SET
_0x7A:
	BLD  R2,7
; 0000 00A5                }
; 0000 00A6                if((b_der_p == 1) && (b_der_a == 0))// Cambio de flanco de 1 a 0
	SBRS R2,6
	RJMP _0x25
	SBRS R2,7
	RJMP _0x26
_0x25:
	RJMP _0x24
_0x26:
; 0000 00A7                {
; 0000 00A8                    // Guardamos un 1 para la izquierda
; 0000 00A9                    memory[i] = INST_DER;
	RCALL SUBOPT_0x1
	LDI  R30,LOW(4)
	RCALL SUBOPT_0x3
; 0000 00AA                    i++;
; 0000 00AB                    delay_ms(40); //Se coloca retardo de 40 ms para eliminar rebotes
	RCALL SUBOPT_0x4
; 0000 00AC                }
; 0000 00AD                b_der_p=b_der_a;
_0x24:
	BST  R2,7
	BLD  R2,6
; 0000 00AE 
; 0000 00AF                if (i == MEM_SIZE) {
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL SUBOPT_0x5
	BRNE _0x27
; 0000 00B0                    completed = 1;
	SET
	BLD  R15,0
; 0000 00B1                    PORTC.0 = 0;
	CBI  0x15,0
; 0000 00B2                }
; 0000 00B3             }
_0x27:
	RJMP _0x10
_0x12:
; 0000 00B4 
; 0000 00B5         }
; 0000 00B6         delay_ms(40);
_0x8:
	RCALL SUBOPT_0x4
; 0000 00B7         b_clr_and_save_p=b_clr_and_save_a;
	BST  R2,1
	BLD  R2,0
; 0000 00B8 
; 0000 00B9         /* Empezar */
; 0000 00BA         if(b_start == 0) {
	SBIC 0x16,1
	RJMP _0x2A
; 0000 00BB             b_start_a = 0;
	CLT
	RJMP _0x7B
; 0000 00BC          } else {
_0x2A:
; 0000 00BD             b_start_a = 1;
	SET
_0x7B:
	BLD  R2,3
; 0000 00BE          }
; 0000 00BF          if ((b_start_p==1)&&(b_start_a==0)) {
	SBRS R2,2
	RJMP _0x2D
	SBRS R2,3
	RJMP _0x2E
_0x2D:
	RJMP _0x2C
_0x2E:
; 0000 00C0             PORTC.1 = 1;
	SBI  0x15,1
; 0000 00C1             for (i = 0 ; i < MEM_SIZE; i++) {
	RCALL SUBOPT_0x0
_0x32:
	__CPWRN 16,17,10
	BRGE _0x33
; 0000 00C2                 send_data(memory[i]);
	RCALL SUBOPT_0x1
	RCALL __EEPROMRDB
	LDI  R31,0
	MOVW R26,R30
	RCALL _send_data
; 0000 00C3                 if(b_stop == 0) {
	SBIC 0x16,2
	RJMP _0x34
; 0000 00C4                     b_stop_a = 0;
	CLT
	RJMP _0x7C
; 0000 00C5                 } else {
_0x34:
; 0000 00C6                     b_stop_a = 1;
	SET
_0x7C:
	BLD  R2,5
; 0000 00C7                 }
; 0000 00C8                 if (((b_stop_p==1) && (b_stop_a==1)) || ((b_stop_p==0) && (b_stop_a==1)) ) {
	SBRS R2,4
	RJMP _0x37
	SBRC R2,5
	RJMP _0x39
_0x37:
	SBRC R2,4
	RJMP _0x3A
	SBRC R2,5
	RJMP _0x39
_0x3A:
	RJMP _0x36
_0x39:
; 0000 00C9                     break;
	RJMP _0x33
; 0000 00CA                 }
; 0000 00CB                 b_stop_p=b_stop_a;
_0x36:
	BST  R2,5
	BLD  R2,4
; 0000 00CC             }
	RCALL SUBOPT_0x2
	RJMP _0x32
_0x33:
; 0000 00CD             PORTA = 0;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 00CE             PORTC.1 = 0;
	CBI  0x15,1
; 0000 00CF             delay_ms(40);
	RCALL SUBOPT_0x4
; 0000 00D0         }
; 0000 00D1         b_start_p=b_start_a;
_0x2C:
	BST  R2,3
	BLD  R2,2
; 0000 00D2     }
	RJMP _0x3
; 0000 00D3 }
_0x3F:
	RJMP _0x3F
; .FEND
;
;
;void send_data(int instr) {
; 0000 00D6 void send_data(int instr) {
_send_data:
; .FSTART _send_data
	PUSH R15
; 0000 00D7     bit flag_contador_arr = 0;
; 0000 00D8     unsigned long contador_arr = 0;
; 0000 00D9     bit flag_contador_abj = 0;
; 0000 00DA     unsigned long contador_abj = 0;
; 0000 00DB     bit flag_contador_izq = 0;
; 0000 00DC     unsigned long contador_izq = 0;
; 0000 00DD     bit flag_contador_der = 0;
; 0000 00DE     unsigned long contador_der = 0;
; 0000 00DF     unsigned long contador = 0;
; 0000 00E0     while (contador < 10000) {
	SBIW R28,20
	LDI  R24,20
	__GETWRN 22,23,0
	LDI  R30,LOW(_0x40*2)
	LDI  R31,HIGH(_0x40*2)
	RCALL __INITLOCB
	RCALL __SAVELOCR2
	MOVW R16,R26
;	instr -> R16,R17
;	flag_contador_arr -> R15.0
;	contador_arr -> Y+18
;	flag_contador_abj -> R15.1
;	contador_abj -> Y+14
;	flag_contador_izq -> R15.2
;	contador_izq -> Y+10
;	flag_contador_der -> R15.3
;	contador_der -> Y+6
;	contador -> Y+2
	CLR  R15
_0x41:
	__GETD2S 2
	__CPD2N 0x2710
	BRLO PC+2
	RJMP _0x43
; 0000 00E1         if (instr == INST_ARR) {
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x5
	BRNE _0x44
; 0000 00E2             if (flag_contador_arr == 0) {
	SBRC R15,0
	RJMP _0x45
; 0000 00E3                 if (contador_arr < 150) {
	RCALL SUBOPT_0x6
	__CPD2N 0x96
	BRSH _0x46
; 0000 00E4                     contador_arr++;
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x9
; 0000 00E5                     PORTA.0 = 1;
	SBI  0x1B,0
; 0000 00E6                 } else {
	RJMP _0x49
_0x46:
; 0000 00E7                     flag_contador_arr = 1;
	SET
	BLD  R15,0
; 0000 00E8                     contador_arr = 150;
	__GETD1N 0x96
	RCALL SUBOPT_0x9
; 0000 00E9                 }
_0x49:
; 0000 00EA             } else {
	RJMP _0x4A
_0x45:
; 0000 00EB                 if (contador_arr > 0) {
	RCALL SUBOPT_0x6
	RCALL __CPD02
	BRSH _0x4B
; 0000 00EC                     contador_arr--;
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x9
; 0000 00ED                     PORTA.0 = 0;
	CBI  0x1B,0
; 0000 00EE                 } else {
	RJMP _0x4E
_0x4B:
; 0000 00EF                     flag_contador_arr = 0;
	CLT
	BLD  R15,0
; 0000 00F0                     contador_arr = 0;
	LDI  R30,LOW(0)
	__CLRD1S 18
; 0000 00F1                 }
_0x4E:
; 0000 00F2             }
_0x4A:
; 0000 00F3         } else if (instr == INST_ABJ) {
	RJMP _0x4F
_0x44:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x5
	BRNE _0x50
; 0000 00F4             if (flag_contador_abj == 0) {
	SBRC R15,1
	RJMP _0x51
; 0000 00F5                 if (contador_abj < 60) {
	RCALL SUBOPT_0xB
	__CPD2N 0x3C
	BRSH _0x52
; 0000 00F6                     contador_abj++;
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0xD
; 0000 00F7                     PORTA.0 = 1;
	SBI  0x1B,0
; 0000 00F8                 } else {
	RJMP _0x55
_0x52:
; 0000 00F9                     flag_contador_abj = 1;
	SET
	BLD  R15,1
; 0000 00FA                     contador_abj = 60;
	__GETD1N 0x3C
	RCALL SUBOPT_0xD
; 0000 00FB                 }
_0x55:
; 0000 00FC             } else {
	RJMP _0x56
_0x51:
; 0000 00FD                 if (contador_abj > 0) {
	RCALL SUBOPT_0xB
	RCALL __CPD02
	BRSH _0x57
; 0000 00FE                     contador_abj--;
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0xD
; 0000 00FF                     PORTA.0 = 0;
	CBI  0x1B,0
; 0000 0100                 } else {
	RJMP _0x5A
_0x57:
; 0000 0101                     flag_contador_abj = 0;
	CLT
	BLD  R15,1
; 0000 0102                     contador_abj = 0;
	LDI  R30,LOW(0)
	__CLRD1S 14
; 0000 0103                 }
_0x5A:
; 0000 0104             }
_0x56:
; 0000 0105         } else if (instr == INST_IZQ) {
	RJMP _0x5B
_0x50:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL SUBOPT_0x5
	BRNE _0x5C
; 0000 0106             if (flag_contador_izq == 0) {
	SBRC R15,2
	RJMP _0x5D
; 0000 0107                 if (contador_izq < 15) {
	RCALL SUBOPT_0xE
	__CPD2N 0xF
	BRSH _0x5E
; 0000 0108                     contador_izq++;
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x10
; 0000 0109                     PORTA.0 = 1;
	SBI  0x1B,0
; 0000 010A                 } else {
	RJMP _0x61
_0x5E:
; 0000 010B                     flag_contador_izq = 1;
	SET
	BLD  R15,2
; 0000 010C                     contador_izq = 15;
	__GETD1N 0xF
	RCALL SUBOPT_0x10
; 0000 010D                 }
_0x61:
; 0000 010E             } else {
	RJMP _0x62
_0x5D:
; 0000 010F                 if (contador_izq > 0) {
	RCALL SUBOPT_0xE
	RCALL __CPD02
	BRSH _0x63
; 0000 0110                     contador_izq--;
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x10
; 0000 0111                     PORTA.0 = 0;
	CBI  0x1B,0
; 0000 0112                 } else {
	RJMP _0x66
_0x63:
; 0000 0113                     flag_contador_izq = 0;
	CLT
	BLD  R15,2
; 0000 0114                     contador_izq = 0;
	LDI  R30,LOW(0)
	__CLRD1S 10
; 0000 0115                 }
_0x66:
; 0000 0116             }
_0x62:
; 0000 0117         } else if (instr == INST_DER) {
	RJMP _0x67
_0x5C:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RCALL SUBOPT_0x5
	BRNE _0x68
; 0000 0118             if (flag_contador_der == 0) {
	SBRC R15,3
	RJMP _0x69
; 0000 0119                 if (contador_der < 1) {
	RCALL SUBOPT_0x11
	__CPD2N 0x1
	BRSH _0x6A
; 0000 011A                     contador_der++;
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x13
; 0000 011B                     PORTA.0 = 1;
	SBI  0x1B,0
; 0000 011C                 } else {
	RJMP _0x6D
_0x6A:
; 0000 011D                     flag_contador_der = 1;
	SET
	BLD  R15,3
; 0000 011E                     contador_der = 1;
	__GETD1N 0x1
	RCALL SUBOPT_0x13
; 0000 011F                 }
_0x6D:
; 0000 0120             } else {
	RJMP _0x6E
_0x69:
; 0000 0121                 if (contador_der > 0) {
	RCALL SUBOPT_0x11
	RCALL __CPD02
	BRSH _0x6F
; 0000 0122                     contador_der--;
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x13
; 0000 0123                     PORTA.0 = 0;
	CBI  0x1B,0
; 0000 0124                 } else {
	RJMP _0x72
_0x6F:
; 0000 0125                     flag_contador_der = 0;
	CLT
	BLD  R15,3
; 0000 0126                     contador_der = 0;
	LDI  R30,LOW(0)
	__CLRD1S 6
; 0000 0127                 }
_0x72:
; 0000 0128             }
_0x6E:
; 0000 0129         } else {
	RJMP _0x73
_0x68:
; 0000 012A             PORTA.4 = 0;
	CBI  0x1B,4
; 0000 012B         }
_0x73:
_0x67:
_0x5B:
_0x4F:
; 0000 012C         contador++;
	__GETD1S 2
	RCALL SUBOPT_0x8
	__PUTD1S 2
; 0000 012D     }
	RJMP _0x41
_0x43:
; 0000 012E }
	RCALL __LOADLOCR2
	ADIW R28,22
	POP  R15
	RET
; .FEND

	.ESEG
_memory:
	.BYTE 0xA

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(_memory)
	LDI  R27,HIGH(_memory)
	ADD  R26,R16
	ADC  R27,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	__ADDWRN 16,17,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	RCALL __EEPROMWRB
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(40)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	CP   R30,R16
	CPC  R31,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	__GETD2S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	__GETD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x8:
	__SUBD1N -1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x9:
	__PUTD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xA:
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	__GETD2S 14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	__GETD1S 14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xD:
	__PUTD1S 14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	__GETD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x10:
	__PUTD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	__GETD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x13:
	__PUTD1S 6
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	PUSH R26
	PUSH R27
	MOVW R26,R22
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	POP  R27
	POP  R26
	RET

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x2EE
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
