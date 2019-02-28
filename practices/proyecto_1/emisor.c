/*******************************************************
This program was created by the CodeWizardAVR V3.34 
Automatic Program Generator
© Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 28/02/2019
Author  : 
Company : 
Comments: 


Chip type               : ATmega8535L
Program type            : Application
AVR Core Clock frequency: 1.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 128
*******************************************************/

#include <mega8535.h>
#include <delay.h>
#define b_arr PINB.0
#define b_abj PINB.1
#define b_izq PINB.2
#define b_der PINB.3
bit b_arr_p;
bit b_arr_a;
bit b_abj_p;
bit b_abj_a;
bit b_izq_p;
bit b_izq_a;
bit b_der_p;
bit b_der_a;

bit flag_arr;
bit flag_abj;
bit flag_izq;
bit flag_der;

bit flag_contador_arr = 0;
unsigned long contador_arr = 0;
bit flag_contador_abj = 0;
unsigned long contador_abj = 0;
bit flag_contador_izq = 0;
unsigned long contador_izq = 0;
bit flag_contador_der = 0;
unsigned long contador_der = 0;

void main(void)
{
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
TCNT0=0x00;
OCR0=0x00;

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

ASSR=0<<AS2;
TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2=0x00;

TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);

MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);

UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);

ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
SFIOR=(0<<ACME);

ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);

SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

while (1)
      {
        if (b_arr == 0){
            b_arr_a = 0;
        } else {
            b_arr_a = 1;
        } 
        
        if (b_abj == 0){
            b_abj_a = 0;
        } else {
            b_abj_a = 1;
        } 
        
        if (b_izq == 0){
            b_izq_a = 0;
        } else {
            b_izq_a = 1;
        } 
        
        if (b_der == 0){
            b_der_a = 0;
        } else {
            b_der_a = 1;
        }  
         
        //Cambio de flanco de 0 a 1   para el boton
        if ((b_arr_p==0)&&(b_arr_a==1)) { 
            flag_arr = 0;
            delay_ms(40); 
        }    
        //Cambio de flanco de 1 a 0 para el boton arriba
        if ((b_arr_p == 1)&&(b_arr_a == 0)){ 
            flag_arr = 1;
            delay_ms(40); 
        }   
        
        
        //Cambio de flanco de 0 a 1   para el boton
        if ((b_abj_p==0)&&(b_abj_a==1)) { 
            flag_abj = 0;
            delay_ms(40); 
        }    
        //Cambio de flanco de 1 a 0 para el boton arriba
        if ((b_abj_p == 1)&&(b_abj_a == 0)){ 
            flag_abj = 1;
            delay_ms(40); 
        }
        
        
        //Cambio de flanco de 0 a 1   para el boton
        if ((b_izq_p==0)&&(b_izq_a==1)) { 
            flag_izq = 0;
            delay_ms(40); 
        }    
        //Cambio de flanco de 1 a 0 para el boton arriba
        if ((b_izq_p == 1)&&(b_izq_a == 0)){ 
            flag_izq = 1;
            delay_ms(40); 
        }   
        
        
        //Cambio de flanco de 0 a 1   para el boton
        if ((b_der_p==0)&&(b_der_a==1)) { 

            flag_der = 0;
            delay_ms(40); 
        }    
        //Cambio de flanco de 1 a 0 para el boton arriba
        if ((b_der_p == 1)&&(b_der_a == 0)){ 
            flag_der = 1;
            delay_ms(40); 
        }
        
        if (flag_arr) {  
            if (flag_contador_arr == 0) {
                    if (contador_arr < 50) {
                        contador_arr++;
                        PORTA.0 = 1;
                    } else {
                        flag_contador_arr = 1;
                        contador_arr = 50;
                    }
                } else {
                   if (contador_arr > 0) {
                        contador_arr--;
                        PORTA.0 = 0;
                    } else {
                      flag_contador_arr = 0; 
                      contador_arr = 0;
                    }
                }
        } else if (flag_abj) {
            if (flag_contador_abj == 0) {
                    if (contador_abj < 25) {
                        contador_abj++;
                        PORTA.0 = 1;
                    } else {
                        flag_contador_abj = 1;
                        contador_abj = 25;
                    }
                } else {
                   if (contador_abj > 0) {
                        contador_abj--;
                        PORTA.0 = 0;
                    } else {
                      flag_contador_abj = 0; 
                      contador_abj = 0;
                    }
                }
        } else if (flag_izq) {
            if (flag_contador_izq == 0) {
                    if (contador_izq < 15) {
                        contador_izq++;
                        PORTA.0 = 1;
                    } else {
                        flag_contador_izq = 1;
                        contador_izq = 15;
                    }
                } else {
                   if (contador_izq > 0) {
                        contador_izq--;
                        PORTA.0 = 0;
                    } else {
                      flag_contador_izq = 0; 
                      contador_izq = 0;
                    }
                }
        } else if (flag_der) {
            if (flag_contador_der == 0) {
                    if (contador_der < 5) {
                        contador_der++;
                        PORTA.0 = 1;
                    } else {
                        flag_contador_der = 1;
                        contador_der = 5;
                    }
                } else {
                   if (contador_der > 0) {
                        contador_der--;
                        PORTA.0 = 0;
                    } else {
                      flag_contador_der = 0; 
                      contador_der = 0;
                    }
                }
        } else {
            PORTA.4 = 0;
        }
        
         b_arr_p=b_arr_a;
         b_abj_p=b_abj_a;
         b_izq_p=b_izq_a;
         b_der_p=b_der_a;
      }
}
