;Simple program to implement Pulse Width Modulation(PWM) functionaity with Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:
;setup LED
	bis.b	#BIT0, &P1DIR 		;set P1.0 as output
	bis.b	#BIT0, &P1OUT		;set LED1  initially
	bic.b	#LOCKLPM5, &PMSCTL0 ; turn on digital IO

;setup timer
	bis.w	#TBCLR,	&TB0CTL		;clears timer
	bis.w	#TBSSEL__ACLK, &TB0CTL	;choose ACLK as source
	bis.w	#MC__UP, &TB0CTL		;put it UP mode

;setup compares
	mov.w	#32768, &TB0CCR0		;CCR0=32, 768
	mov.w	#1638,	&TB0CCR1		;CCR1=1, 638
;setup IRQ's
	bis.w	#CCIE,	&TB0CCTL0		;clear CCR1 flag
	bic.w	#CCIFG,	&TB0CCTL1		;clear CCR1 flag

	eint

main:
		jmp main

;ISR
ISR_TB0_CCR0:
		bis.b	#BIT0, &P1OUT	;LED1=1
		bic.w	#CCIFG,	&TB0CCTL0 ;clear CCRO Flag


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
            
            .sect	".init43"				;CCR0 Vector
            .short	ISR_TB0_CCR0

            .sect	".init42"				;CCR1 Vector
            .short	ISR_TB0_CCR1

