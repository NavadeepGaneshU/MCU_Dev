/*
;Simple program for 1 MHz SMCLK Timer implementation with C Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0
*/

#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	  // stop watchdog timer
	
	P1DIR |= BIT0;              //set P1.0 as OUT
	P1OUT &= ~BIT0;             //clear P1.0 state
	PM5CTL0 &= ~LOCKLPM5;       //turn on pin

	TB0CTL |= TBCLR;            //  reset TB0
	TB0CTL |= TBSSEL__SMCLK;    //SMCLK as source
	TB0CTL |= MC__CONTINUOUS;   //mode is continuous

	TB0CTL |= TBIE;             //local enable for overflow on TB0

	__enable_interrupt();       //global enable for maskable IRQs
	TB0CTL &= ~TBIFG;           //clear flag

	while(1)
	{
	                            //run over
	}

	return 0;
}

#pragma vector = TIMER0_B1_VECTOR
__interrupt void ISR_TB0_Overflow(void)

{
    P1OUT ^= BIT0;              //toggle LED1
    TB0CTL &= ~TBIFG;           //clear flag
}
