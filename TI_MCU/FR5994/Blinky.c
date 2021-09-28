/*
;Simple program to Blink LED using C.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0
*/

#include <msp430.h> 

int main(void)

{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	P1DIR |= BIT0;
	P1OUT &= -BIT0;
	PM5CTL0 &= ~LOCKLPM5;

	int i=0;

	while(1)
	{
	    P1OUT ^= BIT0;          //Toggle LED1
	    for (i=0; i<0xFFFF; i++)
	   
             {
	                            //keep cycling a delay
	     }
		
	}
	   return 0;
}
