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

init:		;bit clear 16 bit operation with .w
			bic.w	#0001h, &PM5CTL0		;Disable GPIO power on high Z state
			;bit set 8 bit operation with .b
			bis.b   #01h,	&P1DIR 			;Set P1.0 as output

main:
			xor.b	#01h,	&P1OUT			;Toggle P1.0

			mov.w	#0FFFFh, R4				;puts big number in R4

delay:
			;decrement register4
			dec.w	R4						;decrement R4
			jnz     delay					;repeat until R4=0

			;jump back to main
			jmp 	main					;repeat forever
			NOP


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
            
