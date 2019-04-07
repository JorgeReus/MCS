
;CodeVisionAVR C Compiler V3.34 Evaluation
;(C) Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega8535
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

	#pragma AVRPART ADMIN PART_NAME ATmega8535
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
	.DEF _puntaje_p1=R4
	.DEF _puntaje_p1_msb=R5
	.DEF _puntaje_p2=R6
	.DEF _puntaje_p2_msb=R7
	.DEF _fila=R8
	.DEF _fila_msb=R9
	.DEF _col=R10
	.DEF _col_msb=R11
	.DEF _bf=R12
	.DEF _bf_msb=R13

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

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x2,0x0,0x2,0x0
	.DB  0x0,0x0

_0x3:
	.DB  0xC0,0xFF,0xF9,0xFF,0xA4,0xFF,0xB0,0xFF
	.DB  0x99,0xFF,0x92,0xFF,0x83,0xFF,0xF8,0xFF
	.DB  0x80,0xFF,0x90,0xFF
_0x4:
	.DB  0x1
_0x5:
	.DB  0x2
_0x6:
	.DB  0x10
_0x7:
	.DB  0x8
_0x8:
	.DB  0x1
_0x9:
	.DB  0x40

__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x14
	.DW  _tabla7seg
	.DW  _0x3*2

	.DW  0x01
	.DW  _j1c1
	.DW  _0x4*2

	.DW  0x01
	.DW  _j1c2
	.DW  _0x5*2

	.DW  0x01
	.DW  _j2c1
	.DW  _0x6*2

	.DW  0x01
	.DW  _j2c2
	.DW  _0x7*2

	.DW  0x01
	.DW  _filj1
	.DW  _0x8*2

	.DW  0x01
	.DW  _filj2
	.DW  _0x9*2

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
;This program was created by the
;CodeWizardAVR V3.20 Evaluation
;Automatic Program Generator
;© Copyright 1998-2015 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 5/29/2016
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega8535
;Program type            : Application
;AVR Core Clock frequency: 1.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 128
;*******************************************************/
;
;#include <io.h>
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
;#define PSWITCH PINB.4
;
;int tabla7seg [10]={~0x3f,~0x06,~0x5b,~0x4f,~0x66,~0x6d,~0x7c,~0x07,~0x7f,~0x6f};

	.DSEG
;
;void validar_derecha_jugador1(void);
;void validar_izquierda_jugador1(void);
;void validar_derecha_jugador2(void);
;void validar_izquierda_jugador2(void);
;void cambiar_columna(void);
;void valida(void);
;void fila_cambio(void);
;void mostrar_puntaje(void);
;
;int puntaje_p1 =0;
;int puntaje_p2=0;
;int fila = 2;
;int col = 2;
;int bf = 0;
;int bc = 0;
;int j1c1 = 1;
;int j1c2 = 2;
;int j2c1 = 16;
;int j2c2 = 8;
;int filj1 = 1;
;int filj2 = 64;
;int contador = 0;
;int bdaj1;
;int bdpj1;
;int biaj1;
;int bipj1;
;int bdaj2;
;int bdpj2;
;int biaj2;
;int bipj2;
;
;
;
;void main(void)
; 0000 0041 {

	.CSEG
_main:
; .FSTART _main
; 0000 0042     DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 0043     PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0044     DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0045     PORTB=(1<<PORTB7) | (1<<PORTB6) | (1<<PORTB5) | (1<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);
	LDI  R30,LOW(255)
	OUT  0x18,R30
; 0000 0046     DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	OUT  0x14,R30
; 0000 0047     PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0048     DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
	LDI  R30,LOW(255)
	OUT  0x11,R30
; 0000 0049     PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 004A     TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 004B     TCNT0=0x00;
	OUT  0x32,R30
; 0000 004C     OCR0=0x00;
	OUT  0x3C,R30
; 0000 004D     TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 004E     TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 004F     TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0050     TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0051     ICR1H=0x00;
	OUT  0x27,R30
; 0000 0052     ICR1L=0x00;
	OUT  0x26,R30
; 0000 0053     OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0054     OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0055     OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0056     OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0057     ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0058     TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 0059     TCNT2=0x00;
	OUT  0x24,R30
; 0000 005A     OCR2=0x00;
	OUT  0x23,R30
; 0000 005B     TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 005C     MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 005D     MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 005E     UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 005F     ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0060     SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 0061     ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 0062     SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 0063     TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 0064 
; 0000 0065     while (1)
_0xA:
; 0000 0066     {
; 0000 0067         mostrar_puntaje();
	RCALL _mostrar_puntaje
; 0000 0068         validar_derecha_jugador1();
	RCALL _validar_derecha_jugador1
; 0000 0069         validar_izquierda_jugador1();
	RCALL _validar_izquierda_jugador1
; 0000 006A         validar_derecha_jugador2();
	RCALL _validar_derecha_jugador2
; 0000 006B         validar_izquierda_jugador2();
	RCALL _validar_izquierda_jugador2
; 0000 006C         PORTD=~fila;
	MOV  R30,R8
	RCALL SUBOPT_0x0
; 0000 006D         PORTC=col;
	OUT  0x15,R10
; 0000 006E         delay_ms (5);
	RCALL SUBOPT_0x1
; 0000 006F         PORTC = j1c1;
	LDS  R30,_j1c1
	RCALL SUBOPT_0x2
; 0000 0070         PORTD = ~filj1;
; 0000 0071         delay_ms(5);
	RCALL SUBOPT_0x1
; 0000 0072         PORTC = j1c2;
	LDS  R30,_j1c2
	RCALL SUBOPT_0x2
; 0000 0073         PORTD = ~filj1;
; 0000 0074         delay_ms(5);
	RCALL SUBOPT_0x1
; 0000 0075         PORTC = j2c1;
	LDS  R30,_j2c1
	RCALL SUBOPT_0x3
; 0000 0076         PORTD = ~filj2;
; 0000 0077         delay_ms(5);
	RCALL SUBOPT_0x1
; 0000 0078         PORTC = j2c2;
	LDS  R30,_j2c2
	RCALL SUBOPT_0x3
; 0000 0079         PORTD = ~filj2;
; 0000 007A         delay_ms(5);
	RCALL SUBOPT_0x1
; 0000 007B         contador++;
	LDI  R26,LOW(_contador)
	LDI  R27,HIGH(_contador)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 007C         if(contador==20)
	LDS  R26,_contador
	LDS  R27,_contador+1
	SBIW R26,20
	BRNE _0xD
; 0000 007D         {
; 0000 007E           fila_cambio();
	RCALL _fila_cambio
; 0000 007F           cambiar_columna();
	RCALL _cambiar_columna
; 0000 0080           contador = 0;
	LDI  R30,LOW(0)
	STS  _contador,R30
	STS  _contador+1,R30
; 0000 0081           valida();
	RCALL _valida
; 0000 0082         }
; 0000 0083       }
_0xD:
	RJMP _0xA
; 0000 0084 }
_0xE:
	RJMP _0xE
; .FEND
;
;
;void fila_cambio()
; 0000 0088 {
_fila_cambio:
; .FSTART _fila_cambio
; 0000 0089     if(bf==0)
	MOV  R0,R12
	OR   R0,R13
	BRNE _0xF
; 0000 008A     {
; 0000 008B         if(fila<32)
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x10
; 0000 008C             fila = fila*2;
	LSL  R8
	ROL  R9
; 0000 008D         else
	RJMP _0x11
_0x10:
; 0000 008E         {
; 0000 008F             bf=1;
	RCALL SUBOPT_0x4
	MOVW R12,R30
; 0000 0090         }
_0x11:
; 0000 0091     }
; 0000 0092 
; 0000 0093     if(bf==1)
_0xF:
	RCALL SUBOPT_0x4
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x12
; 0000 0094     {
; 0000 0095         if(fila>2)
	RCALL SUBOPT_0x5
	CP   R30,R8
	CPC  R31,R9
	BRGE _0x13
; 0000 0096             fila=fila/2;
	MOVW R26,R8
	RCALL SUBOPT_0x6
	MOVW R8,R30
; 0000 0097         else
	RJMP _0x14
_0x13:
; 0000 0098         {
; 0000 0099             bf=0;
	CLR  R12
	CLR  R13
; 0000 009A             fila*=2;
	LSL  R8
	ROL  R9
; 0000 009B         }
_0x14:
; 0000 009C     }
; 0000 009D }
_0x12:
	RET
; .FEND
;
;void cambiar_columna()
; 0000 00A0 {
_cambiar_columna:
; .FSTART _cambiar_columna
; 0000 00A1 
; 0000 00A2     if(bc==0)
	LDS  R30,_bc
	LDS  R31,_bc+1
	SBIW R30,0
	BRNE _0x15
; 0000 00A3     {
; 0000 00A4         if(col<16)
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CP   R10,R30
	CPC  R11,R31
	BRGE _0x16
; 0000 00A5             col = col*2;
	LSL  R10
	ROL  R11
; 0000 00A6         else
	RJMP _0x17
_0x16:
; 0000 00A7         {
; 0000 00A8             bc=1;
	RCALL SUBOPT_0x4
	STS  _bc,R30
	STS  _bc+1,R31
; 0000 00A9             col/=2;
	MOVW R26,R10
	RCALL SUBOPT_0x6
	MOVW R10,R30
; 0000 00AA         }
_0x17:
; 0000 00AB     }
; 0000 00AC 
; 0000 00AD     if(bf==1)
_0x15:
	RCALL SUBOPT_0x4
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x18
; 0000 00AE     {
; 0000 00AF         if(col>1)
	RCALL SUBOPT_0x4
	CP   R30,R10
	CPC  R31,R11
	BRGE _0x19
; 0000 00B0             col=col/2;
	MOVW R26,R10
	RCALL SUBOPT_0x6
	MOVW R10,R30
; 0000 00B1         else
	RJMP _0x1A
_0x19:
; 0000 00B2         {
; 0000 00B3             bc=0;
	LDI  R30,LOW(0)
	STS  _bc,R30
	STS  _bc+1,R30
; 0000 00B4             col*=2;
	LSL  R10
	ROL  R11
; 0000 00B5         }
_0x1A:
; 0000 00B6     }
; 0000 00B7 
; 0000 00B8 }
_0x18:
	RET
; .FEND
;
;void validar_derecha_jugador1()
; 0000 00BB {
_validar_derecha_jugador1:
; .FSTART _validar_derecha_jugador1
; 0000 00BC 
; 0000 00BD 
; 0000 00BE         if (PINB.0==0)
	SBIC 0x16,0
	RJMP _0x1B
; 0000 00BF             bdaj1=0;
	LDI  R30,LOW(0)
	STS  _bdaj1,R30
	STS  _bdaj1+1,R30
; 0000 00C0         else
	RJMP _0x1C
_0x1B:
; 0000 00C1             bdaj1=1;
	RCALL SUBOPT_0x4
	STS  _bdaj1,R30
	STS  _bdaj1+1,R31
; 0000 00C2         if ((bdaj1==0)&&(bdpj1==1)) //hubo cambio de flanco de 1 a 0
_0x1C:
	LDS  R26,_bdaj1
	LDS  R27,_bdaj1+1
	SBIW R26,0
	BRNE _0x1E
	LDS  R26,_bdpj1
	LDS  R27,_bdpj1+1
	SBIW R26,1
	BREQ _0x1F
_0x1E:
	RJMP _0x1D
_0x1F:
; 0000 00C3             {
; 0000 00C4                 if(j1c1<8)
	RCALL SUBOPT_0x7
	SBIW R26,8
	BRGE _0x20
; 0000 00C5                 {
; 0000 00C6                     j1c1*=2;
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x9
; 0000 00C7                     j1c2=j1c1*2;
	RCALL SUBOPT_0xA
; 0000 00C8                 }
; 0000 00C9             }
_0x20:
; 0000 00CA        bdpj1 = bdaj1;
_0x1D:
	LDS  R30,_bdaj1
	LDS  R31,_bdaj1+1
	STS  _bdpj1,R30
	STS  _bdpj1+1,R31
; 0000 00CB 
; 0000 00CC 
; 0000 00CD }
	RET
; .FEND
;
;void validar_izquierda_jugador1()
; 0000 00D0 {
_validar_izquierda_jugador1:
; .FSTART _validar_izquierda_jugador1
; 0000 00D1 
; 0000 00D2      if (PINB.1==0)
	SBIC 0x16,1
	RJMP _0x21
; 0000 00D3             biaj1=0;
	LDI  R30,LOW(0)
	STS  _biaj1,R30
	STS  _biaj1+1,R30
; 0000 00D4         else
	RJMP _0x22
_0x21:
; 0000 00D5             biaj1=1;
	RCALL SUBOPT_0x4
	STS  _biaj1,R30
	STS  _biaj1+1,R31
; 0000 00D6         if ((biaj1==0)&&(bipj1==1)) //hubo cambio de flanco de 1 a 0
_0x22:
	LDS  R26,_biaj1
	LDS  R27,_biaj1+1
	SBIW R26,0
	BRNE _0x24
	LDS  R26,_bipj1
	LDS  R27,_bipj1+1
	SBIW R26,1
	BREQ _0x25
_0x24:
	RJMP _0x23
_0x25:
; 0000 00D7             {
; 0000 00D8                 if(j1c1>1)
	RCALL SUBOPT_0x7
	SBIW R26,2
	BRLT _0x26
; 0000 00D9                 {
; 0000 00DA                     j1c1/=2;
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x9
; 0000 00DB                     j1c2=j1c1*2;
	RCALL SUBOPT_0xA
; 0000 00DC 
; 0000 00DD                 }
; 0000 00DE             }
_0x26:
; 0000 00DF        bipj1 = biaj1;
_0x23:
	LDS  R30,_biaj1
	LDS  R31,_biaj1+1
	STS  _bipj1,R30
	STS  _bipj1+1,R31
; 0000 00E0 }
	RET
; .FEND
;
;void validar_izquierda_jugador2()
; 0000 00E3 {
_validar_izquierda_jugador2:
; .FSTART _validar_izquierda_jugador2
; 0000 00E4 
; 0000 00E5     if (PINB.2==0)
	SBIC 0x16,2
	RJMP _0x27
; 0000 00E6             biaj2=0;
	LDI  R30,LOW(0)
	STS  _biaj2,R30
	STS  _biaj2+1,R30
; 0000 00E7         else
	RJMP _0x28
_0x27:
; 0000 00E8             biaj2=1;
	RCALL SUBOPT_0x4
	STS  _biaj2,R30
	STS  _biaj2+1,R31
; 0000 00E9         if ((biaj2==0)&&(bipj2==1)) //hubo cambio de flanco de 1 a 0
_0x28:
	LDS  R26,_biaj2
	LDS  R27,_biaj2+1
	SBIW R26,0
	BRNE _0x2A
	LDS  R26,_bipj2
	LDS  R27,_bipj2+1
	SBIW R26,1
	BREQ _0x2B
_0x2A:
	RJMP _0x29
_0x2B:
; 0000 00EA             {
; 0000 00EB                 if(j2c1>1)
	RCALL SUBOPT_0xB
	SBIW R26,2
	BRLT _0x2C
; 0000 00EC                 {
; 0000 00ED                     j2c1/=2;
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0xC
; 0000 00EE                     j2c2=j2c1*2;
; 0000 00EF                 }
; 0000 00F0             }
_0x2C:
; 0000 00F1        bipj2 = biaj2;
_0x29:
	LDS  R30,_biaj2
	LDS  R31,_biaj2+1
	STS  _bipj2,R30
	STS  _bipj2+1,R31
; 0000 00F2 
; 0000 00F3 }
	RET
; .FEND
;
;void validar_derecha_jugador2()
; 0000 00F6 {
_validar_derecha_jugador2:
; .FSTART _validar_derecha_jugador2
; 0000 00F7 
; 0000 00F8      if (PINB.3==0)
	SBIC 0x16,3
	RJMP _0x2D
; 0000 00F9             bdaj2=0;
	LDI  R30,LOW(0)
	STS  _bdaj2,R30
	STS  _bdaj2+1,R30
; 0000 00FA         else
	RJMP _0x2E
_0x2D:
; 0000 00FB             bdaj2=1;
	RCALL SUBOPT_0x4
	STS  _bdaj2,R30
	STS  _bdaj2+1,R31
; 0000 00FC         if ((bdaj2==0)&&(bdpj2==1)) //hubo cambio de flanco de 1 a 0
_0x2E:
	LDS  R26,_bdaj2
	LDS  R27,_bdaj2+1
	SBIW R26,0
	BRNE _0x30
	LDS  R26,_bdpj2
	LDS  R27,_bdpj2+1
	SBIW R26,1
	BREQ _0x31
_0x30:
	RJMP _0x2F
_0x31:
; 0000 00FD             {
; 0000 00FE                 if(j2c1<8)
	RCALL SUBOPT_0xB
	SBIW R26,8
	BRGE _0x32
; 0000 00FF                 {
; 0000 0100                     j2c1*=2;
	LDS  R30,_j2c1
	LDS  R31,_j2c1+1
	RCALL SUBOPT_0xD
	RCALL SUBOPT_0xC
; 0000 0101                     j2c2=j2c1*2;
; 0000 0102                 }
; 0000 0103             }
_0x32:
; 0000 0104        bdpj2 = bdaj2;
_0x2F:
	LDS  R30,_bdaj2
	LDS  R31,_bdaj2+1
	STS  _bdpj2,R30
	STS  _bdpj2+1,R31
; 0000 0105 }
	RET
; .FEND
;
;void valida()
; 0000 0108 {
_valida:
; .FSTART _valida
; 0000 0109     if (fila==32)
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	CP   R30,R8
	CPC  R31,R9
	BRNE _0x33
; 0000 010A     {
; 0000 010B         if((j2c1!=col)&&(j2c2!=col))
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xE
	BREQ _0x35
	LDS  R26,_j2c2
	LDS  R27,_j2c2+1
	RCALL SUBOPT_0xE
	BRNE _0x36
_0x35:
	RJMP _0x34
_0x36:
; 0000 010C         {
; 0000 010D             delay_ms(100);
	LDI  R26,LOW(100)
	RCALL SUBOPT_0xF
; 0000 010E             puntaje_p1++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 010F             if(puntaje_p1==5)
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x37
; 0000 0110             {
; 0000 0111                 PORTA = tabla7seg[puntaje_p1];
	RCALL SUBOPT_0x10
; 0000 0112                 PORTC.5 = 1;
; 0000 0113                 PORTC.6 = 0;
; 0000 0114                 delay_ms(200);
; 0000 0115                 PORTA = tabla7seg[puntaje_p2];
	RCALL SUBOPT_0x11
; 0000 0116                 PORTC.5 = 0;
; 0000 0117                 PORTC.6 = 1;
; 0000 0118                 delay_ms(200);
; 0000 0119                 puntaje_p1=0;
	RCALL SUBOPT_0x12
; 0000 011A                 puntaje_p2=0;
; 0000 011B             }
; 0000 011C         }
_0x37:
; 0000 011D 
; 0000 011E     }
_0x34:
; 0000 011F     if (fila==2)
_0x33:
	RCALL SUBOPT_0x5
	CP   R30,R8
	CPC  R31,R9
	BRNE _0x40
; 0000 0120     {
; 0000 0121         if((j1c1!=col)&&(j1c2!=col))
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0xE
	BREQ _0x42
	LDS  R26,_j1c2
	LDS  R27,_j1c2+1
	RCALL SUBOPT_0xE
	BRNE _0x43
_0x42:
	RJMP _0x41
_0x43:
; 0000 0122         {
; 0000 0123             delay_ms(100);
	LDI  R26,LOW(100)
	RCALL SUBOPT_0xF
; 0000 0124             puntaje_p2++;
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
; 0000 0125             if(puntaje_p2==5)
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R6
	CPC  R31,R7
	BRNE _0x44
; 0000 0126             {
; 0000 0127                 PORTA = tabla7seg[puntaje_p1];
	RCALL SUBOPT_0x10
; 0000 0128                 PORTC.5 = 1;
; 0000 0129                 PORTC.6 = 0;
; 0000 012A                 delay_ms(200);
; 0000 012B                 PORTA = tabla7seg[puntaje_p2];
	RCALL SUBOPT_0x11
; 0000 012C                 PORTC.5 = 0;
; 0000 012D                 PORTC.6 = 1;
; 0000 012E                 delay_ms(200);
; 0000 012F                 puntaje_p1=0;
	RCALL SUBOPT_0x12
; 0000 0130                 puntaje_p2=0;
; 0000 0131             }
; 0000 0132         }
_0x44:
; 0000 0133 
; 0000 0134     }
_0x41:
; 0000 0135 }
_0x40:
	RET
; .FEND
;
;void mostrar_puntaje()
; 0000 0138 {
_mostrar_puntaje:
; .FSTART _mostrar_puntaje
; 0000 0139     if (PSWITCH ==1 ) {
	SBIS 0x16,4
	RJMP _0x4D
; 0000 013A       PORTA = tabla7seg[puntaje_p1];
	MOVW R30,R4
	RCALL SUBOPT_0x13
; 0000 013B       PORTC.5 = 1;
	SBI  0x15,5
; 0000 013C       PORTC.6 = 0;
	CBI  0x15,6
; 0000 013D     } else {
	RJMP _0x52
_0x4D:
; 0000 013E        PORTA = tabla7seg[puntaje_p2];
	MOVW R30,R6
	RCALL SUBOPT_0x13
; 0000 013F         PORTC.5 = 0;
	CBI  0x15,5
; 0000 0140         PORTC.6 = 1;
	SBI  0x15,6
; 0000 0141     }
_0x52:
; 0000 0142     delay_ms(5);
	RCALL SUBOPT_0x1
; 0000 0143 }
	RET
; .FEND

	.DSEG
_tabla7seg:
	.BYTE 0x14
_bc:
	.BYTE 0x2
_j1c1:
	.BYTE 0x2
_j1c2:
	.BYTE 0x2
_j2c1:
	.BYTE 0x2
_j2c2:
	.BYTE 0x2
_filj1:
	.BYTE 0x2
_filj2:
	.BYTE 0x2
_contador:
	.BYTE 0x2
_bdaj1:
	.BYTE 0x2
_bdpj1:
	.BYTE 0x2
_biaj1:
	.BYTE 0x2
_bipj1:
	.BYTE 0x2
_bdaj2:
	.BYTE 0x2
_bdpj2:
	.BYTE 0x2
_biaj2:
	.BYTE 0x2
_bipj2:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x0:
	COM  R30
	OUT  0x12,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(5)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	OUT  0x15,R30
	LDS  R30,_filj1
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	OUT  0x15,R30
	LDS  R30,_filj2
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	RCALL SUBOPT_0x5
	RCALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x7:
	LDS  R26,_j1c1
	LDS  R27,_j1c1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x8:
	LDS  R30,_j1c1
	LDS  R31,_j1c1+1
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	STS  _j1c1,R30
	STS  _j1c1+1,R31
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	STS  _j1c2,R30
	STS  _j1c2+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xB:
	LDS  R26,_j2c1
	LDS  R27,_j2c1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xC:
	STS  _j2c1,R30
	STS  _j2c1+1,R31
	LSL  R30
	ROL  R31
	STS  _j2c2,R30
	STS  _j2c2+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xD:
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	CP   R10,R26
	CPC  R11,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x10:
	MOVW R30,R4
	LDI  R26,LOW(_tabla7seg)
	LDI  R27,HIGH(_tabla7seg)
	RCALL SUBOPT_0xD
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x1B,R30
	SBI  0x15,5
	CBI  0x15,6
	LDI  R26,LOW(200)
	RJMP SUBOPT_0xF

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x11:
	MOVW R30,R6
	LDI  R26,LOW(_tabla7seg)
	LDI  R27,HIGH(_tabla7seg)
	RCALL SUBOPT_0xD
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x1B,R30
	CBI  0x15,5
	SBI  0x15,6
	LDI  R26,LOW(200)
	RJMP SUBOPT_0xF

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	CLR  R4
	CLR  R5
	CLR  R6
	CLR  R7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x13:
	LDI  R26,LOW(_tabla7seg)
	LDI  R27,HIGH(_tabla7seg)
	RCALL SUBOPT_0xD
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x1B,R30
	RET

;RUNTIME LIBRARY

	.CSEG
__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	NEG  R27
	NEG  R26
	SBCI R27,0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
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
