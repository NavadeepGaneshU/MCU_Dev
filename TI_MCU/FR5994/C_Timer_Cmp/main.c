#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//setup ports
	P1DIR |= BIT0;
	P1OUT &= ~BIT0;
	PM5CTL0 &= ~LOCKLPM5;

	//setup timer
	TB0CTL |= TBCLR;            //reset TB0
	TB0CTL |= MC__UP;           //put in UP mode
	TB0CTL |= TBSSEL__ACLK;     //choose ACLK(32KHz)
	TB0CCR0 = 16384;            //set CCR0 = 16384

	//setup timer compare IRQ
	TB0CCTL0 |= CCIE;           //local enable for CCR0
	__enable_interrupt();
	TB0CCTL0 &= ~CCIFG;         //clear flag

	//main loop
	while(1){}

	return 0;
}

//ISRs
#pragma vector = TIMER0_B0_VECTOR
__interrupt void ISR_TB0_CCR0(void)
{
    P1OUT ^= BIT0;              //toggle LED1
    TB0CCTL0 &= ~CCIFG;         //clear flag
}
