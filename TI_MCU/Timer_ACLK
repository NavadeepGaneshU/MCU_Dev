/*
;Simple program for ACLK Timer implementation with C Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0
*/

#include <msp430.h> 
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	  // stop watchdog timer
	
	P1DIR |= BIT0;              //set P1.0 as OUT
	P1OUT &= ~BIT0;             //clear LED1 state
	PM5CTL0 &= ~LOCKLPM5;       //turn on GPIO

	TB0CTL |= TBCLR;            //reset timer
	TB0CTL |= TBSSEL__ACLK;     //ACLK clock
	TB0CTL |= MC__CONTINUOUS;   //mode is continuous

	TB0CTL |= TBIE;             //local enable for TB0 overflow
	__enable_interrupt();       //enable maskable IRQs

	TB0CTL &= ~TBIFG;           //clear IRQ Flag

	while(1)
	{
	                            //Run over
	}

	return 0;
}

#pragma vector = TIMER0_B1_VECTOR         //  ISR

__interrupt void ISR_TB0_Overflow(void)
{
    P1OUT ^= BIT0;             //toggle LED1
    TB0CTL &= ~TBIFG;          //clear IRQ Flag
}
