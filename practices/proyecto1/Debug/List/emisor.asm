
;CodeVisionAVR C Compiler V3.34 Evaluation
;(C) Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega8535L
;Program type           : Application
;Clock frequency        : 1.000000 MHz
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

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _contador=R4
	.DEF _contador_msb=R5

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

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0


__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x02
	.DW  0x04
	.DW  __REG_VARS*2

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
;/*******************************************************
;This program was created by the CodeWizardAVR V3.34
;Automatic Program Generator
;� Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 26/02/2019
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega8535L
;Program type            : Application
;AVR Core Clock frequency: 1.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 128
;*******************************************************/
;
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
;#define boton PINB.0
;bit botonp;
;bit botona;
;unsigned int contador = 0;
;unsigned long contador_reset = 0;
;bit down_flag;
;
;unsigned long contador_0 = 0;
;bit flag_contador_0 = 0;
;
;unsigned long contador_1 = 0;
;bit flag_contador_1 = 0;
;
;unsigned long contador_2 = 0;
;bit flag_contador_2 = 0;
;
;unsigned long contador_3 = 0;
;bit flag_contador_3 = 0;
;
;
;// Declare your global variables here
;
;void main(void)
; 0000 0030 {

	.CSEG
_main:
; .FSTART _main
; 0000 0031 // Declare your local variables here
; 0000 0032 
; 0000 0033 // Input/Output Ports initialization
; 0000 0034 // Port A initialization
; 0000 0035 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0036 DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 0037 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0038 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0039 
; 0000 003A // Port B initialization
; 0000 003B // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 003C DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 003D // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 003E PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 003F 
; 0000 0040 // Port C initialization
; 0000 0041 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0042 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 0043 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0044 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 0045 
; 0000 0046 // Port D initialization
; 0000 0047 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0048 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 0049 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 004A PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 004B 
; 0000 004C // Timer/Counter 0 initialization
; 0000 004D // Clock source: System Clock
; 0000 004E // Clock value: Timer 0 Stopped
; 0000 004F // Mode: Normal top=0xFF
; 0000 0050 // OC0 output: Disconnected
; 0000 0051 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0052 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0053 OCR0=0x00;
	OUT  0x3C,R30
; 0000 0054 
; 0000 0055 // Timer/Counter 1 initialization
; 0000 0056 // Clock source: System Clock
; 0000 0057 // Clock value: Timer1 Stopped
; 0000 0058 // Mode: Normal top=0xFFFF
; 0000 0059 // OC1A output: Disconnected
; 0000 005A // OC1B output: Disconnected
; 0000 005B // Noise Canceler: Off
; 0000 005C // Input Capture on Falling Edge
; 0000 005D // Timer1 Overflow Interrupt: Off
; 0000 005E // Input Capture Interrupt: Off
; 0000 005F // Compare A Match Interrupt: Off
; 0000 0060 // Compare B Match Interrupt: Off
; 0000 0061 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0062 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0063 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0064 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0065 ICR1H=0x00;
	OUT  0x27,R30
; 0000 0066 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0067 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0068 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0069 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 006A OCR1BL=0x00;
	OUT  0x28,R30
; 0000 006B 
; 0000 006C // Timer/Counter 2 initialization
; 0000 006D // Clock source: System Clock
; 0000 006E // Clock value: Timer2 Stopped
; 0000 006F // Mode: Normal top=0xFF
; 0000 0070 // OC2 output: Disconnected
; 0000 0071 ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0072 TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 0073 TCNT2=0x00;
	OUT  0x24,R30
; 0000 0074 OCR2=0x00;
	OUT  0x23,R30
; 0000 0075 
; 0000 0076 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0077 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 0078 
; 0000 0079 // External Interrupt(s) initialization
; 0000 007A // INT0: Off
; 0000 007B // INT1: Off
; 0000 007C // INT2: Off
; 0000 007D MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 007E MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 007F 
; 0000 0080 // USART initialization
; 0000 0081 // USART disabled
; 0000 0082 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 0083 
; 0000 0084 // Analog Comparator initialization
; 0000 0085 // Analog Comparator: Off
; 0000 0086 // The Analog Comparator's positive input is
; 0000 0087 // connected to the AIN0 pin
; 0000 0088 // The Analog Comparator's negative input is
; 0000 0089 // connected to the AIN1 pin
; 0000 008A ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 008B SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 008C 
; 0000 008D // ADC initialization
; 0000 008E // ADC disabled
; 0000 008F ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 0090 
; 0000 0091 // SPI initialization
; 0000 0092 // SPI disabled
; 0000 0093 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 0094 
; 0000 0095 // TWI initialization
; 0000 0096 // TWI disabled
; 0000 0097 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 0098 
; 0000 0099 while (1)
_0x3:
; 0000 009A       {
; 0000 009B          if (boton == 0){
	SBIC 0x16,0
	RJMP _0x6
; 0000 009C             botona = 0;
	CLT
	RJMP _0x65
; 0000 009D          } else {
_0x6:
; 0000 009E             botona = 1;
	SET
_0x65:
	BLD  R2,1
; 0000 009F          }
; 0000 00A0           //Cambio de flanco de 1 a 0 para el boton
; 0000 00A1           if ((botonp==1)&&(botona==0)){
	SBRS R2,0
	RJMP _0x9
	SBRS R2,1
	RJMP _0xA
_0x9:
	RJMP _0x8
_0xA:
; 0000 00A2              down_flag = 0;
	CLT
	BLD  R2,2
; 0000 00A3              contador_reset = 0;
	RCALL SUBOPT_0x0
; 0000 00A4              contador++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 00A5              delay_ms(40);
	LDI  R26,LOW(40)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00A6           }
; 0000 00A7           //Cambio de flanco de 0 a 1   para el boton
; 0000 00A8           if ((botonp==0)&&(botona==1)) {
_0x8:
	SBRC R2,0
	RJMP _0xC
	SBRC R2,1
	RJMP _0xD
_0xC:
	RJMP _0xB
_0xD:
; 0000 00A9             down_flag = 1;
	SET
	BLD  R2,2
; 0000 00AA             delay_ms(40);
	LDI  R26,LOW(40)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00AB            }
; 0000 00AC 
; 0000 00AD 
; 0000 00AE             if (down_flag == 1) {
_0xB:
	SBRS R2,2
	RJMP _0xE
; 0000 00AF                 if (contador_reset < 15000){
	LDS  R26,_contador_reset
	LDS  R27,_contador_reset+1
	LDS  R24,_contador_reset+2
	LDS  R25,_contador_reset+3
	RCALL SUBOPT_0x1
	BRSH _0xF
; 0000 00B0                     contador_reset++;
	LDI  R26,LOW(_contador_reset)
	LDI  R27,HIGH(_contador_reset)
	RCALL SUBOPT_0x2
; 0000 00B1                 } else {
	RJMP _0x10
_0xF:
; 0000 00B2                     contador_reset = 0;
	RCALL SUBOPT_0x0
; 0000 00B3                     contador = 0;
	CLR  R4
	CLR  R5
; 0000 00B4                     down_flag = 0;
	CLT
	BLD  R2,2
; 0000 00B5 
; 0000 00B6                     // Contadores
; 0000 00B7                     flag_contador_0 = 0;
	RCALL SUBOPT_0x3
; 0000 00B8                     contador_0 = 0;
; 0000 00B9                 }
_0x10:
; 0000 00BA             }
; 0000 00BB 
; 0000 00BC             if (contador == 0) {
_0xE:
	MOV  R0,R4
	OR   R0,R5
	BRNE _0x11
; 0000 00BD                 PORTA.0 = 0;
	CBI  0x1B,0
; 0000 00BE                 PORTA.1 = 0;
	CBI  0x1B,1
; 0000 00BF                 PORTA.2 = 0;
	CBI  0x1B,2
; 0000 00C0                 PORTA.3 = 0;
	CBI  0x1B,3
; 0000 00C1                 PORTA.4 = 0;
	CBI  0x1B,4
; 0000 00C2             } else if (contador == 1) {
	RJMP _0x1C
_0x11:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x1D
; 0000 00C3                 PORTA.0 = 1;
	SBI  0x1B,0
; 0000 00C4                 PORTA.1 = 0;
	CBI  0x1B,1
; 0000 00C5                 PORTA.2 = 0;
	CBI  0x1B,2
; 0000 00C6 
; 0000 00C7                 if (flag_contador_0 == 0) {
	SBRC R2,3
	RJMP _0x24
; 0000 00C8                     if (contador_0 < 15000) {
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x1
	BRSH _0x25
; 0000 00C9                         contador_0++;
	LDI  R26,LOW(_contador_0)
	LDI  R27,HIGH(_contador_0)
	RCALL SUBOPT_0x2
; 0000 00CA                         PORTA.4 = 1;
	SBI  0x1B,4
; 0000 00CB                     } else {
	RJMP _0x28
_0x25:
; 0000 00CC                         flag_contador_0 = 1;
	SET
	BLD  R2,3
; 0000 00CD                         contador_0 = 15000;
	__GETD1N 0x3A98
	STS  _contador_0,R30
	STS  _contador_0+1,R31
	STS  _contador_0+2,R22
	STS  _contador_0+3,R23
; 0000 00CE                     }
_0x28:
; 0000 00CF                 } else {
	RJMP _0x29
_0x24:
; 0000 00D0                    if (contador_0 > 0) {
	RCALL SUBOPT_0x4
	RCALL __CPD02
	BRSH _0x2A
; 0000 00D1                         contador_0--;
	LDI  R26,LOW(_contador_0)
	LDI  R27,HIGH(_contador_0)
	RCALL SUBOPT_0x5
; 0000 00D2                         PORTA.4 = 0;
; 0000 00D3                     } else {
	RJMP _0x2D
_0x2A:
; 0000 00D4                       flag_contador_0 = 0;
	RCALL SUBOPT_0x3
; 0000 00D5                       contador_0 = 0;
; 0000 00D6                     }
_0x2D:
; 0000 00D7                 }
_0x29:
; 0000 00D8 
; 0000 00D9 
; 0000 00DA             } else if (contador == 2) {
	RJMP _0x2E
_0x1D:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x2F
; 0000 00DB                 PORTA.0 = 0;
	CBI  0x1B,0
; 0000 00DC                 PORTA.1 = 1;
	SBI  0x1B,1
; 0000 00DD                 PORTA.2 = 0;
	CBI  0x1B,2
; 0000 00DE 
; 0000 00DF                 if (flag_contador_1 == 0) {
	SBRC R2,4
	RJMP _0x36
; 0000 00E0                     if (contador_1 < 7000) {
	RCALL SUBOPT_0x6
	__CPD2N 0x1B58
	BRSH _0x37
; 0000 00E1                         contador_1++;
	LDI  R26,LOW(_contador_1)
	LDI  R27,HIGH(_contador_1)
	RCALL SUBOPT_0x2
; 0000 00E2                         PORTA.4 = 1;
	SBI  0x1B,4
; 0000 00E3                     } else {
	RJMP _0x3A
_0x37:
; 0000 00E4                         flag_contador_1 = 1;
	SET
	BLD  R2,4
; 0000 00E5                         contador_1 = 7000;
	__GETD1N 0x1B58
	STS  _contador_1,R30
	STS  _contador_1+1,R31
	STS  _contador_1+2,R22
	STS  _contador_1+3,R23
; 0000 00E6                     }
_0x3A:
; 0000 00E7                 } else {
	RJMP _0x3B
_0x36:
; 0000 00E8                    if (contador_1 > 0) {
	RCALL SUBOPT_0x6
	RCALL __CPD02
	BRSH _0x3C
; 0000 00E9                         contador_1--;
	LDI  R26,LOW(_contador_1)
	LDI  R27,HIGH(_contador_1)
	RCALL SUBOPT_0x5
; 0000 00EA                         PORTA.4 = 0;
; 0000 00EB                     } else {
	RJMP _0x3F
_0x3C:
; 0000 00EC                       flag_contador_1 = 0;
	CLT
	BLD  R2,4
; 0000 00ED                       contador_1 = 0;
	LDI  R30,LOW(0)
	STS  _contador_1,R30
	STS  _contador_1+1,R30
	STS  _contador_1+2,R30
	STS  _contador_1+3,R30
; 0000 00EE                     }
_0x3F:
; 0000 00EF                 }
_0x3B:
; 0000 00F0             } else if (contador == 3) {
	RJMP _0x40
_0x2F:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x41
; 0000 00F1                 PORTA.0 = 1;
	SBI  0x1B,0
; 0000 00F2                 PORTA.1 = 1;
	SBI  0x1B,1
; 0000 00F3                 PORTA.2 = 0;
	CBI  0x1B,2
; 0000 00F4 
; 0000 00F5                 if (flag_contador_2 == 0) {
	SBRC R2,5
	RJMP _0x48
; 0000 00F6                     if (contador_2 < 4000) {
	RCALL SUBOPT_0x7
	__CPD2N 0xFA0
	BRSH _0x49
; 0000 00F7                         contador_2++;
	LDI  R26,LOW(_contador_2)
	LDI  R27,HIGH(_contador_2)
	RCALL SUBOPT_0x2
; 0000 00F8                         PORTA.4 = 1;
	SBI  0x1B,4
; 0000 00F9                     } else {
	RJMP _0x4C
_0x49:
; 0000 00FA                         flag_contador_2 = 1;
	SET
	BLD  R2,5
; 0000 00FB                         contador_2 = 4000;
	__GETD1N 0xFA0
	STS  _contador_2,R30
	STS  _contador_2+1,R31
	STS  _contador_2+2,R22
	STS  _contador_2+3,R23
; 0000 00FC                     }
_0x4C:
; 0000 00FD                 } else {
	RJMP _0x4D
_0x48:
; 0000 00FE                    if (contador_2 > 0) {
	RCALL SUBOPT_0x7
	RCALL __CPD02
	BRSH _0x4E
; 0000 00FF                         contador_2--;
	LDI  R26,LOW(_contador_2)
	LDI  R27,HIGH(_contador_2)
	RCALL SUBOPT_0x5
; 0000 0100                         PORTA.4 = 0;
; 0000 0101                     } else {
	RJMP _0x51
_0x4E:
; 0000 0102                       flag_contador_2 = 0;
	CLT
	BLD  R2,5
; 0000 0103                       contador_2 = 0;
	LDI  R30,LOW(0)
	STS  _contador_2,R30
	STS  _contador_2+1,R30
	STS  _contador_2+2,R30
	STS  _contador_2+3,R30
; 0000 0104                     }
_0x51:
; 0000 0105                 }
_0x4D:
; 0000 0106             } else if (contador >= 4) {
	RJMP _0x52
_0x41:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R4,R30
	CPC  R5,R31
	BRLO _0x53
; 0000 0107                 PORTA.0 = 0;
	CBI  0x1B,0
; 0000 0108                 PORTA.1 = 0;
	CBI  0x1B,1
; 0000 0109                 PORTA.2 = 1;
	SBI  0x1B,2
; 0000 010A 
; 0000 010B                 if (flag_contador_3 == 0) {
	SBRC R2,6
	RJMP _0x5A
; 0000 010C                     if (contador_3 < 500) {
	RCALL SUBOPT_0x8
	__CPD2N 0x1F4
	BRSH _0x5B
; 0000 010D                         contador_3++;
	LDI  R26,LOW(_contador_3)
	LDI  R27,HIGH(_contador_3)
	RCALL SUBOPT_0x2
; 0000 010E                         PORTA.4 = 1;
	SBI  0x1B,4
; 0000 010F                     } else {
	RJMP _0x5E
_0x5B:
; 0000 0110                         flag_contador_3 = 1;
	SET
	BLD  R2,6
; 0000 0111                         contador_3 = 500;
	__GETD1N 0x1F4
	STS  _contador_3,R30
	STS  _contador_3+1,R31
	STS  _contador_3+2,R22
	STS  _contador_3+3,R23
; 0000 0112                     }
_0x5E:
; 0000 0113                 } else {
	RJMP _0x5F
_0x5A:
; 0000 0114                    if (contador_3 > 0) {
	RCALL SUBOPT_0x8
	RCALL __CPD02
	BRSH _0x60
; 0000 0115                         contador_3--;
	LDI  R26,LOW(_contador_3)
	LDI  R27,HIGH(_contador_3)
	RCALL SUBOPT_0x5
; 0000 0116                         PORTA.4 = 0;
; 0000 0117                     } else {
	RJMP _0x63
_0x60:
; 0000 0118                       flag_contador_3 = 0;
	CLT
	BLD  R2,6
; 0000 0119                       contador_3 = 0;
	LDI  R30,LOW(0)
	STS  _contador_3,R30
	STS  _contador_3+1,R30
	STS  _contador_3+2,R30
	STS  _contador_3+3,R30
; 0000 011A                     }
_0x63:
; 0000 011B                 }
_0x5F:
; 0000 011C             }
; 0000 011D 
; 0000 011E              botonp=botona;
_0x53:
_0x52:
_0x40:
_0x2E:
_0x1C:
	BST  R2,1
	BLD  R2,0
; 0000 011F       }
	RJMP _0x3
; 0000 0120 }
_0x64:
	RJMP _0x64
; .FEND

	.DSEG
_contador_reset:
	.BYTE 0x4
_contador_0:
	.BYTE 0x4
_contador_1:
	.BYTE 0x4
_contador_2:
	.BYTE 0x4
_contador_3:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	STS  _contador_reset,R30
	STS  _contador_reset+1,R30
	STS  _contador_reset+2,R30
	STS  _contador_reset+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1:
	__CPD2N 0x3A98
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x2:
	RCALL __GETD1P_INC
	__SUBD1N -1
	RCALL __PUTDP1_DEC
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x3:
	CLT
	BLD  R2,3
	LDI  R30,LOW(0)
	STS  _contador_0,R30
	STS  _contador_0+1,R30
	STS  _contador_0+2,R30
	STS  _contador_0+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDS  R26,_contador_0
	LDS  R27,_contador_0+1
	LDS  R24,_contador_0+2
	LDS  R25,_contador_0+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x5:
	RCALL __GETD1P_INC
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	RCALL __PUTDP1_DEC
	CBI  0x1B,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	LDS  R26,_contador_1
	LDS  R27,_contador_1+1
	LDS  R24,_contador_1+2
	LDS  R25,_contador_1+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7:
	LDS  R26,_contador_2
	LDS  R27,_contador_2+1
	LDS  R24,_contador_2+2
	LDS  R25,_contador_2+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x8:
	LDS  R26,_contador_3
	LDS  R27,_contador_3+1
	LDS  R24,_contador_3+2
	LDS  R25,_contador_3+3
	RET

;RUNTIME LIBRARY

	.CSEG
__GETD1P_INC:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	RET

__PUTDP1_DEC:
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
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
	__DELAY_USW 0xFA
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE: