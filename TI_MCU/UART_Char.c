/*
;Simple program for UART character transmission with C Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0
*/

#include<msp430.h>

void UARTInit(void);
void TXData(unsigned char c);

void main(void){
     WDTCTL = WDTPW + WDTHOLD;// watchdog timer kapali
     
     CSCTL0_H = CSKEY >> 8;                                 // Unlock CS registers
     CSCTL1 = DCOFSEL_3 | DCORSEL;                          //Set DCO to 8MHz
     CSCTL2 = SELA__VLOCLK | SELS__DCOCLK | SELM__DCOCLK;   // Set ACLK = VLOCLK; MCLK = SMCLK = DCO
     CSCTL3 = DIVA__1 | DIVS__1 | DIVM__1;                  // Set all dividers to 1

     CSCTL0_H = 0;                                          // Lock CS registers

     PM5CTL0 &= ~LOCKLPM5;

      P1OUT &= ~BIT0;                         // Clear P1.0 output latch
      P1DIR |= BIT0;                          // For LED

      P5DIR &= ~BIT5;                         //P5.5 input
      P5OUT |=  BIT5;
      P5REN |=  BIT5;                         // Enables pullup resistor on button
      P5IE |= BIT5;                           //  interrupt enabled
      P5IES |= BIT5;                          //  Hi/lo edge
      P5IFG &= ~BIT5;                         // IFG cleared

    UARTInit();

    __bis_SR_register(GIE);

}

void UARTInit(void){
    P6SEL1 &= ~(BIT0 | BIT1);
    P6SEL0 |= (BIT0 | BIT1);                    // USCI_A3 UART operation

    UCA3CTLW0 = UCSWRST;                       // Put eUSCI in reset
    UCA3CTLW0 |= UCSSEL__SMCLK;                // CLK = SMCLK
    UCA3BRW = 52;                                      
    UCA3MCTLW |= UCOS16 | UCBRF_1 | 0x0400;
    UCA3CTLW0 &= ~UCSWRST;                     // Initialize eUSCI

    UCA3IE |= UCRXIE;
}

void TXData(unsigned char c){
    while(!(UCA3IFG & UCTXIFG));
    UCA3TXBUF = c;
}

   #pragma vector=PORT5_VECTOR
   __interrupt void Port_5(void)
   {
       P1OUT ^= BIT0;
       TXData('A');
       __delay_cycles(400000);                //prevent multiple bounces

      P5IFG &= ~BIT5;
   }
