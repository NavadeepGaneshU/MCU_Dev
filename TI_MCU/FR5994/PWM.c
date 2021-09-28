/*
;Simple program to implement PWM generation using C.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0
*/

#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
P1DIR |= BIT0;                  //set P1.0 as OUT
P1OUT |= BIT0;                  //set LED1
PM5CTL0 &= ~LOCKLPM5;            //turn ON IOs

TB0CTL |= TBCLR;
TB0CTL |= MC__UP;
TB0CTL |= TBSSEL__ACLK;         //choose ACLK
TB0CCR1 = 32768;                //PWM period
TB0CCR1 = 1638;                 //PWM duty cycle

TB0CCTL0 |= CCIE;
TB0CCTL1 |= CCIE;

__enable_interrupt();

TB0CCTL0 &= ~CCIFG;
TB0CCTL1 &= ~CCIFG;

while(1)
{

}
	return 0;
}

#pragma vector = TIMER0_B0_VECTOR   //ISR for duty cycle
__interrupt void ISR_TB0_CCR0(void)
{
    P1OUT |= BIT0;                 //turn LED1 ON
    TB0CCTL0 &= ~CCIFG;             //clear flag for CCR0
}

#pragma vector = TIMER0_B1_VECTOR   //ISR for duty cycle
__interrupt void ISR_TB0_CCR1(void)
{
    P1OUT &= ~BIT0;                 //turn LED1 OFF
    TB0CCTL1 &= ~CCIFG;             //clear flag for CCR1
}
