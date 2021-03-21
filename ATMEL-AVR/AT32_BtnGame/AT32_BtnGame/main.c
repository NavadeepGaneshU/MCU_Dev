/*
 * AT32_BtnGame.c
 * Created: 13-03-2021 21:48:16
 * Author : HP1
 */

#include <avr/io.h>
#include <util/delay.h>

void ProcessPressedButton(int ButtonPressed);	//prototypes for code blocks for calling
void ProcessReleasedButton(int ButtonReleased);

int pressed_confidence_level[2];	//for debouncing
int released_confidence_level[2];
int pressed[2];	//ack if pressed or not
int LEDnumber[2];	//which LED should be lit

int main(void)
{
	//initialization area for setting ports, DDRs
	DDRB = 0b01111111;	//7 LED pins on a port
	DDRD = 0b01111111;
	PORTB = 0b10000000;	//initially all LEDs off(|= << PIN7)
	PORTD = 0b10000000;
	
    while (1) 
    {
		if (bit_is_clear(PINB, 7))
		{
			ProcessPressedButton(0);
		}
		else
		{
			ProcessReleasedButton(0);
		}
		if (bit_is_clear(PIND, 7))
		{
			ProcessPressedButton(1);
		}
		else
		{
			ProcessReleasedButton (1);
		}
    }
}
 
void ProcessPressedButton(int ButtonPressed)
{
	pressed_confidence_level[ButtonPressed] ++;
	if (pressed_confidence_level[ButtonPressed] > 500)
	{
		if (pressed[ButtonPressed] == 0)
		{
			pressed[ButtonPressed] = 1;
			if(ButtonPressed == 0) PORTB |= 1 << LEDnumber[ButtonPressed];
			if(ButtonPressed == 1) PORTD |= 1 << LEDnumber[ButtonPressed];
			LEDnumber[ButtonPressed] ++;
			if(LEDnumber[ButtonPressed] > 6)
			{
				//winner and blink all
				for(int i=0; i<10; i++)
				{
					if (ButtonPressed == 0) PORTB = 0b11111111;
					if (ButtonPressed == 1) PORTD = 0b11111111;
					_delay_ms(10);
					
					if (ButtonPressed == 0) PORTB = 0b10000000;
					if (ButtonPressed == 1) PORTD = 0b10000000;
					_delay_ms(10);
				}
				LEDnumber[0] = 0;
				LEDnumber[1] = 0;
				
				PORTB = 0b10000000;	//reset all LEDs
				PORTD = 0b10000000;
			}
		}
		pressed_confidence_level[ButtonPressed] = 0;
	}
}

void ProcessReleasedButton(int ButtonReleased)
{
	released_confidence_level[ButtonReleased] ++;
	if (released_confidence_level[ButtonReleased] > 500)
	{
		pressed[ButtonReleased] = 0;
		released_confidence_level[ButtonReleased] = 0;
	}
}