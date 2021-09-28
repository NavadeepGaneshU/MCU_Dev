;Simple program for Timer implementation with Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:
;setup LED
   		bis.b	#BIT0, &P1DIR			;set P1.0 as output
   		bic.b	#BIT0,	&P1OUT			;LED1 off initially
   		bic.b	#LOCKLPM5,	&PM5CTL0	;turn on digital IO

;setup timer
		bis.w	#TBCLR,	&TB0CTL			;clear timer
		bis.w	#TBSSEL__ACLK, &TB0CTL	;choose ACLK as source
		bis.w	#MC__UP, &TB0CTL			;put timer into UP mode
;setup compare
		mov.w	#16384,	&TB0CCR0		;setup compare VALUE
		bis.w	#CCIE,	&TB0CCTL0		;local enable for CCR0 in TB0
		eint							;global enable
		bic.w	#CCIFG,	&TB0CCTL0		;clear CCIFG flag

main:
		jmp 	main

;ISRs

ISR_TB0_CCR0:
		xor.b	#BIT0, &P1OUT			;toggled LED1
		bic.w	#CCIFG,	&TB0CCTL0		;clear CCIFG flag
		reti

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
            .sect	".int43"				;TB0 CCR0 vector
            .short	ISR_TB0_CCR0
