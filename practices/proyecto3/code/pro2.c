/*******************************************************
This program was created by the
CodeWizardAVR V3.20 Evaluation
Automatic Program Generator
� Copyright 1998-2015 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/29/2016
Author  : 
Company : 
Comments: 


Chip type               : ATmega8535
Program type            : Application
AVR Core Clock frequency: 1.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 128
*******************************************************/

#include <io.h>
#include <delay.h>

#define PSWITCH PINB.4

int tabla7seg [10]={~0x3f,~0x06,~0x5b,~0x4f,~0x66,~0x6d,~0x7c,~0x07,~0x7f,~0x6f};

void validar_derecha_jugador1(void);
void validar_izquierda_jugador1(void);
void validar_derecha_jugador2(void);
void validar_izquierda_jugador2(void);
void cambiar_columna(void);
void valida(void);
void fila_cambio(void);
void mostrar_puntaje(void);

int puntaje_p1 =0;
int puntaje_p2=0;
int fila = 2;
int col = 2;
int bf = 0;
int bc = 0;
int j1c1 = 1;
int j1c2 = 2;
int j2c1 = 16;
int j2c2 = 8;
int filj1 = 1;
int filj2 = 64;
int contador = 0;
int bdaj1;
int bdpj1;
int biaj1;
int bipj1;
int bdaj2;
int bdpj2;
int biaj2;
int bipj2;



void main(void)
{
    DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
    PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
    DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
    PORTB=(1<<PORTB7) | (1<<PORTB6) | (1<<PORTB5) | (1<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);
    DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
    PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
    DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
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
        mostrar_puntaje();
        validar_derecha_jugador1();
        validar_izquierda_jugador1();
        validar_derecha_jugador2();
        validar_izquierda_jugador2();
        PORTD=~fila;
        PORTC=col;
        delay_ms (5);
        PORTC = j1c1;
        PORTD = ~filj1;
        delay_ms(5);
        PORTC = j1c2;
        PORTD = ~filj1;
        delay_ms(5);
        PORTC = j2c1;
        PORTD = ~filj2;
        delay_ms(5);
        PORTC = j2c2;
        PORTD = ~filj2;
        delay_ms(5);       
        contador++;
        if(contador==20)
        {
          fila_cambio();
          cambiar_columna();
          contador = 0;
          valida();  
        }    
      }
}


void fila_cambio()
{
    if(bf==0)
    {
        if(fila<32)
            fila = fila*2;
        else
        {
            bf=1;
        }
    }
    
    if(bf==1)
    {
        if(fila>2)
            fila=fila/2;
        else
        {
            bf=0;
            fila*=2;
        }
    }
}

void cambiar_columna()
{
   
    if(bc==0)
    {
        if(col<16)
            col = col*2;
        else
        {
            bc=1;
            col/=2;
        }
    }
    
    if(bf==1)
    {
        if(col>1)
            col=col/2;
        else
        {
            bc=0;
            col*=2;
        }
    }

}

void validar_derecha_jugador1()
{
    
        
        if (PINB.0==0)
            bdaj1=0;
        else
            bdaj1=1;
        if ((bdaj1==0)&&(bdpj1==1)) //hubo cambio de flanco de 1 a 0
            {
                if(j1c1<8)
                {
                    j1c1*=2;
                    j1c2=j1c1*2;
                }
            }
       bdpj1 = bdaj1;
        
        
}

void validar_izquierda_jugador1()
{
    
     if (PINB.1==0)
            biaj1=0;
        else
            biaj1=1;
        if ((biaj1==0)&&(bipj1==1)) //hubo cambio de flanco de 1 a 0
            {
                if(j1c1>1)
                {
                    j1c1/=2;
                    j1c2=j1c1*2;
                    
                }
            }
       bipj1 = biaj1;
}

void validar_izquierda_jugador2()
{
    
    if (PINB.2==0)
            biaj2=0;
        else
            biaj2=1;
        if ((biaj2==0)&&(bipj2==1)) //hubo cambio de flanco de 1 a 0
            {
                if(j2c1>1)
                {
                    j2c1/=2;
                    j2c2=j2c1*2;
                }
            }
       bipj2 = biaj2;
        
}

void validar_derecha_jugador2()
{
    
     if (PINB.3==0)
            bdaj2=0;
        else
            bdaj2=1;
        if ((bdaj2==0)&&(bdpj2==1)) //hubo cambio de flanco de 1 a 0
            {
                if(j2c1<8)
                {
                    j2c1*=2;
                    j2c2=j2c1*2;
                }
            }
       bdpj2 = bdaj2;
}

void valida()
{
    if (fila==32) 
    {
        if((j2c1!=col)&&(j2c2!=col))
        {
            delay_ms(100);
            puntaje_p1++;
            if(puntaje_p1==5)
            {     
                PORTA = tabla7seg[puntaje_p1];
                PORTC.5 = 1;
                PORTC.6 = 0;
                delay_ms(200);
                PORTA = tabla7seg[puntaje_p2];
                PORTC.5 = 0;
                PORTC.6 = 1;
                delay_ms(200);
                puntaje_p1=0;
                puntaje_p2=0; 
            }
        }
        
    }
    if (fila==2)
    {
        if((j1c1!=col)&&(j1c2!=col))
        {
            delay_ms(100);
            puntaje_p2++;
            if(puntaje_p2==5)
            {
                PORTA = tabla7seg[puntaje_p1];
                PORTC.5 = 1;
                PORTC.6 = 0;
                delay_ms(200);
                PORTA = tabla7seg[puntaje_p2];
                PORTC.5 = 0;
                PORTC.6 = 1;
                delay_ms(200);
                puntaje_p1=0;
                puntaje_p2=0; 
            }
        }
        
    }    
}

void mostrar_puntaje()
{
    if (PSWITCH ==1 ) {
      PORTA = tabla7seg[puntaje_p1];
      PORTC.5 = 1;
      PORTC.6 = 0;
    } else {
       PORTA = tabla7seg[puntaje_p2];
        PORTC.5 = 0;
        PORTC.6 = 1;
    }
    delay_ms(5);
}
