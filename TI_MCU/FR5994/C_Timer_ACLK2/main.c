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
	PM5CTL0 &= ~LOCKLPM5;

	//setup timer
	TB0CTL |= TBCLR;        //reset timer
	TB0CTL |= TBSSEL__ACLK; //make ACLK as source
	TB0CTL |= MC__CONTINUOUS; //timer in cont mode
	TB0CTL |= CNTL_1;       //12-bit length

	//setup timer IRQ
	TB0CTL |= TBIE;         //local enable for overflow
	__enable_interrupt();   //global enable GIE
	TB0CTL &= ~TBIFG;        //clears flag

	//main loop
	while(1){}

	return 0;
}

//ISRs
#pragma vector = TIMER0_B1_VECTOR
__interrupt void ISR_TB0_Overflow(void)
{
    P1OUT ^= BIT0;
    TB0CTL &= ~TBIFG;        //clears flag
}
