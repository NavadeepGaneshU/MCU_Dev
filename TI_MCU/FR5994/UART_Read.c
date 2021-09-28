/*
;Simple program for Serial data transmission visualisation via Terminal with C Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0
*/

#include <msp430.h> 
int main(void)
{
	    WDTCTL = WDTPW | WDTHOLD;	      // stop watchdog timer
	
	    UCA1CTLW0 |= UCSWRST;           //put UART A1 into SW reset
	    UCA1CTLW0 |= UCSSEL__SMCLK;     //choose SMCLK for UART A1
	    UCA1BRW = 8;                    //set prescaler to 8
	    UCA1MCTLW = 0XD600;             //OS16=low freq. setup modulation

	        P6SEL1 &= ~BIT0;            //P6.0 to use UART A1 Tx
	        P6SEL0 |= BIT0;          

	        PM5CTL0 &= ~LOCKLPM5;       // turn on IO

	        UCA1CTLW0 &= ~UCSWRST;      //  put UART A1 into SW reset

	        int i;
	        while(1)
	            {
	              UCA1TXBUF = 'A';      //send ASCII over UART A1
	              for(i=0; i<10000; i=i++)
	                {
	                                    //run over
	                }
	            }

	return 0;
}
