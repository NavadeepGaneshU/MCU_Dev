#include <msp430.h>

#define SW BIT3    //P1.3 for Pushbutton
#define LED BIT7   //P1.7 for LED

void main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

	P1DIR |= LED;   //set LED as output
	P1REN |= SW;    //enable pullup resistor
	P1DIR &= ~SW;   //set SW as input
	P1OUT &= ~SW;
/*
	while(1)
	{
	    if(!(P1IN & SW))    //if SW is pressed
	    {
	        while(!(P1IN & SW));    //wait till release
	        P1OUT ^= LED;   //turn ON LED
	    }
	}
*/
	while(1)
	    {
	        if(P1IN & SW)    //if SW is pressed
	        {
	            __delay_cycles(20000);  //debounce time of 20
	            while(P1IN & SW);    //wait till release
	            __delay_cycles(20000);
	            P1OUT ^= LED;   //turn ON LED
	        }
	    }
}
