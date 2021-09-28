#include <msp430.h> 
/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//setup ports
	P1DIR |= BIT0;              //set P1.0 to output
	P1OUT &= ~BIT0;             //clear LED1

	P5DIR &= ~BIT5;             //set P5.5 to input
	P5REN |= BIT5;              //enable resistor
	P5OUT |= BIT5;              //sets pullup resistor

	PM5CTL0 &= ~LOCKLPM5;

	int SW1;

	while(1)
	{
	    SW1 = P5IN;             //read Port5
	    SW1 &= BIT5;            //clear all bits except SW1

	    if (SW1 == 0)
	    {
	        P1OUT |= BIT0;      //turn on LED1
	    }
	    else
	    {
	        P1OUT &= ~BIT0;     //turn off LED1
	    }
	}

	return 0;
}
