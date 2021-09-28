#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//setup ports
	P1DIR |= BIT0;              //set as output
	P1OUT |= BIT0;              //set as default low
	PM5CTL0 &= ~LOCKLPM5;

	//setup timer
	TB0CTL |= TBCLR;            //reset TB0
	TB0CTL |= MC__UP;           //UP mode rolls timer back
	TB0CTL |= TBSSEL__ACLK;     //set ACLK (32kHz)
	TB0CCR0 = 32768;            //set PWM period
	TB0CCR1 = 1638;             //set PWM duty cycle

	//setup IRQs
	TB0CCTL0 |= CCIE;           //local enable for CCR0
	TB0CCTL1 |= CCIE;           //for CCR1
	__enable_interrupt();       //enable maskable interrupts
	TB0CCTL0 &= ~CCIFG;         //clear flag for CCR0
	TB0CCTL1 &= ~CCIFG;         //for CCR1

	//main loop
	while(1){}

	return 0;
}

//ISRs
#pragma vector = TIMER0_B0_VECTOR   //ISR for period
__interrupt void ISR_TB0_CCR0(void)
{
    P1OUT |= BIT0;                  //LED1 ON
    TB0CCTL0 &= ~CCIFG;             //clear flag for CCR0
}

#pragma vector = TIMER0_B1_VECTOR   //ISR for duty cycle
__interrupt void ISR_TB0_CCR1(void)
{
    P1OUT &= ~BIT0;                 //LED1 OFF
    TB0CCTL1 &= ~CCIFG;             //clear flag for CCR1
}
