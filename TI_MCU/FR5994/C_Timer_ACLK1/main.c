#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//setup ports
	P1DIR |= BIT0;          //set P1.0 to output
	P1OUT &= ~BIT0;         //clear LED1 initially
	PM5CTL0 &= ~LOCKLPM5;    //turn on GPIO

	//setup timer
	TB0CTL |= TBCLR;        //reset timer
	TB0CTL |= TBSSEL__ACLK; //clock = ACLK
	TB0CTL |= MC__CONTINUOUS; //mode = continuous

	//setup the timer TBO overflow IRQ
	TB0CTL |= TBIE;         //local enable for TB0 overflow
	__enable_interrupt();   //enable maskable IRQ
	TB0CTL &= ~TBIFG;        //clear IRQ flag

	//main loop
	while(1){}

	return 0;
}

//ISR
#pragma vector = TIMER0_B1_VECTOR
__interrupt void ISR_TBO_Overflow(void)
{
  P1OUT ^= BIT0;        //toggle LED1
  TB0CTL &= ~TBIFG;     //clear IRQ flag
}
