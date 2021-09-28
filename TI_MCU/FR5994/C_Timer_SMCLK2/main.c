#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

	//setup ports
	P1DIR |= BIT0;              //set port1.0 to output LED
	P1OUT &= ~BIT0;             //set P1.0 to low
	PM5CTL0 &= ~LOCKLPM5;        //turn on IO

	//setup timer
	TB0CTL |= TBCLR;
	TB0CTL |= MC__CONTINUOUS;   //cont mode
	TB0CTL |= TBSSEL__SMCLK;    //choose SMCLK(1MHz)
	TB0CTL |= ID__4;            //divide clock by 4, 250KHz

	//setup IRQ
	TB0CTL |= TBIE;
	__enable_interrupt();       //enable maskables
	TB0CTL &= ~TBIFG;           //clear flag

	//main loop
	while(1){}

	return 0;
}

//ISR
#pragma vector = TIMER0_B1_VECTOR
__interrupt void ISR_TB0_Overflow(void)
{
    P1OUT ^= BIT0;
    TB0CTL &= ~TBIFG;           //clear flag
}
