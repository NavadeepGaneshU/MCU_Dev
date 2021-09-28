#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//setup ports
	P1DIR |= BIT0;
	P1OUT &= ~BIT0;
	PM5CTL0 &= ~LOCKLPM5;       //enable GPIO

	int i =0;

	while(1)
	{
	    P1OUT ^= BIT0;

	    for(i=0; i<0xFFFF; i++)
	    {

	    }
	}

	return 0;
}
