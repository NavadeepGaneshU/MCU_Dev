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
;Indirect Register Mode Addressing(like pointer in C)
main:
			mov.w   #2000h, R4				;put 2000h into R4 to act as pointer
			mov.w	@R4, R5					;put contets of R4 to R5
			mov.w	#Const2, R5				;put address of const2 to R5
			mov.w	Const2, R5				;put contents from const2 to R5

			jmp		main
            NOP
                                            
;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------

			.data							;go to program memory 2000h
			.retain

Const1:		.short	0DEADh					;put DEAD into 2000h
Const2:		.short	0BEEFh					;put BEEF into 2002h

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
            
