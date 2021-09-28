#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//setup ports
	P1DIR |= BIT0;              //set P1.0 to output
	P1OUT &= ~BIT0;             //clear LED1
	PM5CTL0 &= ~LOCKLPM5;       //turn on IO

	//setup timer TB0
	TB0CTL |= TBCLR;            //reset TB0
	TB0CTL |= TBSSEL__SMCLK;    //SMCLK is source
	TB0CTL |= MC__CONTINUOUS;   // set cont mode

	//setup IRQ (interrupt requests)
	TB0CTL |= TBIE;             //local enable for overflow TB0
	__enable_interrupt();       //global enable for maskable IRQ
	TB0CTL &= ~TBIFG;           //clear flag

	//main loop
	while(1){}

	return 0;
}

//ISR
#pragma vector = TIMER0_B1_VECTOR
__interrupt void ISR_TB0_Overflow(void)
{
    P1OUT ^= BIT0;              //toggle LED1
    TB0CTL &= ~TBIFG;           //clear flag
}
