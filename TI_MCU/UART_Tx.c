/*
;Simple program for UART-Tx implementation with C Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0
*/

#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;    // stop watchdog timer
	
	UCA1CTLW0 |= UCSWRST;        //put UART A1 into SW reset

	UCA1CTLW0 |= UCSSEL__SMCLK;  //choose SMCLK for UART A1
	UCA1BRW = 8;                 //set prescaler to 8
	UCA1MCTLW |= 0xD600;         //configure modulation settings and low freq

	P4SEL1 &= ~BIT3;
	P4SEL0 |= BIT3;              // puts UART A1 on P4.3

	PM5CTL0 &= ~LOCKLPM5;        // turn on IO
	UCA1CTLW0 &= ~UCSWRST;       //  put UART A1 into SW reset

	int i;
	while(1)
	    {
	       UCA1TXBUF = 0x4B;    //send x40 out over UART A1
	       for(i=0; i<10000; i=i+1)
	       {
	                           //run over
	       }
	    }

	return 0;
}
