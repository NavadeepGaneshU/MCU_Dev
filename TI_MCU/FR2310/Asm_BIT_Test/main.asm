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
;Instructions to Test Bit, Compare Bit and Test
main:
			mov.b	#00010000b, R4			;consider a value in R4
			bit.b	#10000000b, R4			;Test if Bit7 is 1 from Z flag in SR
											;If Bit7 = 1, Zero flag, Z=0 and else 1

			bit.b	#00010000b, R4			;Test if Bit4 is 1 from Z flag in SR
											;If Bit4 = 1, Z=0

			mov.b	#99, R5					;consider a value in R5 to comppare
			cmp.b	#99, R5					;Z=1 if 99 = 99
			cmp.b	#77, R5					;Z=0 if 99 != 77

			mov.b   #-99, R6				;consider a vaiue in R6
			tst.b	R6						;subtracts 0 from R6
											;check N and Z in SR to know type of value in R6

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
            
