;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
init:
			bis.b	#BIT0, &P1DIR			;set P1.0 to output
			bic.b	#BIT0, &P1OUT			;clear LED1 initially

			bic.b	#BIT5, &P5DIR			;set P5.5 to input
			bis.b	#BIT5, &P5REN			;enale pull up/down
			bis.b   #BIT5, &P5OUT			;make pullup
			bis.b	#BIT5, &P5IES           ;int edge select - sensitivity to high to low signal

          	bic.b	#LOCKLPM5, &PM5CTL0		;enable digital IO

          	bic.b	#BIT5, &P5IFG			;clear P5IFG
          	bis.b	#BIT5, &P5IE			;local enable for P5.5
          	eint							;enable global maskables

main:
			jmp 	main

;-------------------------------------------------------------------------------
; ISR
;-------------------------------------------------------------------------------
ISR_S1:
			xor.b	#BIT0,	&P1OUT			;toggle LED1
			bic.b	#BIT5,	&P5IFG			;clear P4IFG
			reti							;return from interrupt

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
            
			.sect	"int22"					;port 4 vector address
			.short	ISR_S1
