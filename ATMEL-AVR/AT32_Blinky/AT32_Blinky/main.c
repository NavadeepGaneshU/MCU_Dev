/*
 * main.c
 *
 * Created: 3/12/2021 9:39:47 AM
 *  Author: HP1
 */ 

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	DDRB |= (1<< PINB0);
	PORTB &= ~(1 << PINB);
	
    while(1)
    {
			_delay_ms(1000);
			PORTB ^= (1 << PINB0);
    }
}