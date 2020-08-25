  
;Program to implement LED pushbutton toggling with C.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	P1DIR |= BIT1;              //Set P1.1 to output LED2
	P1OUT &= ~BIT1;             //Clear LED1

	P5DIR &= ~BIT5;             //Set P1.0 as input
	P5REN |= BIT5;              // Enables resistor
	P5OUT |= BIT5;              //Sets resistor to PU

	PM5CTL0 &= ~LOCKLPM5;

	int SW1;

	while(1)
	{
	    SW1 = P5IN;             //Reads Port4
	    SW1 &= BIT5;            //Clear all bits except BIT1

	    if (SW1 == 0)
	    {
	        P1OUT |= BIT1;      //Turns LED ON
	    }
	    else
	    {
	         P1OUT &= ~BIT1;      //Turns LED OFF
	    }
	}
	return 0;
}
