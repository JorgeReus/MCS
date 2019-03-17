/*******************************************************
This program was created by the CodeWizardAVR V3.34 
Automatic Program Generator
© Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 16/03/2019
Author  : 
Company : 
Comments: 


Chip type               : ATmega8535L
Program type            : Application
AVR Core Clock frequency: 3.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 128
*******************************************************/

#include <mega8535.h>
#include <delay.h>
#define b_clr_and_save PINB.0
bit b_clr_and_save_p;
bit b_clr_and_save_a;

#define b_start PINB.1
bit b_start_p;
bit b_start_a;

#define b_stop PINB.2
#define MEM_SIZE 10
#define INST_ARR 1
#define INST_ABJ 2
#define INST_IZQ 3
#define INST_DER 4
eeprom char memory[MEM_SIZE];

#define b_der PINB.3
bit b_der_p;
bit b_der_a;

#define b_izq PINB.4
bit b_izq_p;
bit b_izq_a;

#define b_arr PINB.5
bit b_arr_p;
bit b_arr_a;

#define b_abj PINB.6
bit b_abj_p;
bit b_abj_a;

void main(void)
{
int i = 0;
bit completed = 0;
// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0<<AS2;
TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);

// USART initialization
// USART disabled
UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
SFIOR=(0<<ACME);

// ADC initialization
// ADC disabled
ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);

// SPI initialization
// SPI disabled
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

// TWI initialization
// TWI disabled
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

    while (1)
    {
        // Se borran las instrucciones y se guardan una por una las nuevas  
         if(b_clr_and_save == 0) { 
             b_clr_and_save_a = 0;
         } else {      
             b_clr_and_save_a = 1;
         }
         if((b_clr_and_save_p == 1) && (b_clr_and_save_a == 0)) {// Cambio de flanco de 1 a 0                                            
            // Borrado  
            
            for (i = 0; i < MEM_SIZE; i++) {
                memory[i] = 0;
            }  
            // Nuevas Instrucciones 
            PORTC.0 = 1; 
            completed = 0; 
            i = 0; 
            
            while (!completed) {  
               /* Boton arriba */
               if(b_arr == 0) {
                   b_arr_a = 0;
               } else {
                   b_arr_a = 1;
               }
               if((b_arr_p == 1) && (b_arr_a == 0))// Cambio de flanco de 1 a 0
               {
                   // Guardamos un 1 para la izquierda 
                   memory[i] = INST_ARR;                                                         
                   i++;
                   delay_ms(40); //Se coloca retardo de 40 ms para eliminar rebotes 
               }
               b_arr_p=b_arr_a;
               
               /* Boton abajo */
               if(b_abj == 0) {
                   b_abj_a = 0;
               } else {
                   b_abj_a = 1;
               }
               if((b_abj_p == 1) && (b_abj_a == 0))// Cambio de flanco de 1 a 0
               {
                   // Guardamos un 1 para la izquierda 
                   memory[i] = INST_ABJ;                                                         
                   i++;
                   delay_ms(40); //Se coloca retardo de 40 ms para eliminar rebotes 
               }
               b_abj_p=b_abj_a;  
            
             
               /* Boton izquierdo */
               if(b_izq == 0) {
                   b_izq_a = 0;
               } else {
                   b_izq_a = 1;
               }
               if((b_izq_p == 1) && (b_izq_a == 0))// Cambio de flanco de 1 a 0
               {
                   // Guardamos un 3 para la izquierda 
                   memory[i] = INST_IZQ;                                                         
                   i++;
                   delay_ms(40); //Se coloca retardo de 40 ms para eliminar rebotes 
               }
               b_izq_p=b_izq_a;
               
               
                /* Boton derecho */
               if(b_der == 0) {
                   b_der_a = 0;
               } else {
                   b_der_a = 1;
               }
               if((b_der_p == 1) && (b_der_a == 0))// Cambio de flanco de 1 a 0
               {
                   // Guardamos un 1 para la izquierda 
                   memory[i] = INST_DER;                                                         
                   i++;
                   delay_ms(40); //Se coloca retardo de 40 ms para eliminar rebotes 
               }
               b_der_p=b_der_a; 
               
               if (i == MEM_SIZE) {
                   completed = 1;
                   PORTC.0 = 0;
               } 
            } 
            
        }
        b_clr_and_save_p=b_clr_and_save_a;
         
        /* Empezar */ 
        if(b_start == 0) { 
            b_start_a = 0;
         } else {      
            b_start_a = 1;
         }
         if ((b_start_p==1)&&(b_start_a==0)) {
            PORTC.1 = 1;
            for (i = 0 ; i < MEM_SIZE; i++) {
                PORTA = memory[i]; 
                delay_ms(500);
            }  
            PORTA = 0;
            PORTC.1 = 0;
        } 
        b_start_p=b_start_a;
    }
}
