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
;Absolute mode addressing
main:
			mov.w	&2000h, R4				;copy contents from 2000 to 2004h
			mov.w	R4, &2004h

			mov.w	&2002h, R5
			mov.w	R5, &2006h

			jmp		main
			NOP

;-------------------------------------------------------------------------------
; Memory allocation
;-------------------------------------------------------------------------------
			.data							;go to data memory
			.retain							;retain this from assembler

Const1:			.short	1234h				;setup constant 1234h
Const2:			.short	0CAFEh				;setup constant 0CAFEh
Const3:			.short  0FACEh

Var1:			.space	2					;reserve 2 bytes at 2004h
Var2:			.space	2					;reserve 2 bytes at 2026h
Var3:			.space  2

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
            
