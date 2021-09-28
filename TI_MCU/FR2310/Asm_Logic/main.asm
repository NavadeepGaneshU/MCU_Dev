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
main:

            ;Inverting operation
			mov.b	#10101010b, R4			;# puts a value in register
			inv.b	R4						;invert be binary at R4

			;Bit masking with AND - ANDing anything with 1 has no effect
			mov.b	#11110000, R5
			and.b	#00111111b, R5			;clear bits 6, 7

			;Bit test
			mov.b	#00010000b, R6			;is bit7 a 1 or 0?
			and.b	#10000000b, R6          ;test bit "1" for position 7

			mov.b	#00010000b, R7			;is bit4 a 1 or 0?
			and.b	#00010000b, R7			;test bit "1" for position 4

			;Set operation with OR - ORing anything with 1 will give 1(set)
			mov.b	#11000001b, R8
			or.b	#00011111b, R8			;set bits 4:0

			;Toggling operation with XOR - XORing anything with 1 will invert(toggle state)
			;							 - XORing anything with 0 will have no effect
			mov.b	#01010101b, R9
			;xor.b	#11110000b, R9			;toggle
			xor.b	#00001111b, R9			;toggle

			jmp main
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
            
