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
;Bit Set(BIS) and Bit Clear(BIC) Operations
main:
			mov.b	#00000000b, R4			;R4=0

			bis.b	#10000001b, R4			;sets to 10000001
			bis.b	#01000010b, R4			;sets to 11000011
			bis.b	#00100100b, R4			;sets to 11100111
			bis.b	#00011000b, R4			;sets to 11111111

			bic.b	#00011000b, R4			;clears to 11100111
			bic.b	#00100100b, R4			;clears to 11000011
			bic.b	#10000001b, R4			;clears to 10000001

			jmp		main
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
            
