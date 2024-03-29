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
;Symbolic Mode Addressing (without declaring the memory location)
main:
			mov.w	Const1, R4				;copy contents of Const1 to R4
			mov.w	R4, Var1

			;mov.w	Const1, Var1			;directly moves from one location to other
											;without accessing CPU register

			mov.w	Const2, R5				;copy contents of Const2 to R5
			mov.w	R5, Var2

			;mov.w  Const2, Var2

			jmp main
			NOP

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------
			.data							;go to data memory
			.retain							;retain the code from assembler

Const1:		.short 1234h
Const2:		.short 0CAFEh

Var1:		.space 2
Var2:       .space 2

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
            
