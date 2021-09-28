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
			bis.b	#BIT0, &P1DIR	;set P1.0 as output
			bic.b	#BIT0, &P1OUT	;set LED1=OFF

			bic.b	#BIT5, &P5DIR	;set P5.5 as input(S2)
			bis.b	#BIT5, &P5REN	;enable PUPD resistor for P5.5
			bis.b	#BIT5, &P4OUT	;set it as pullup resistor

			bic.b	#LOCKLPM5, &PM5CTL0	;	enable digital IO


main:

poll_S2:
			bit.b	#BIT5, &P5IN	;test P5.5
			jnz		poll_S2			;stay in polling loop

toggle_LED1:
			xor.b	#BIT0, &P1OUT	;toggle LED1

;-----------------------------------------------
			mov.w	#0FFFFh, R4		;put a large number and countdown with for loop to add delay
delay:
			dec.w	R4
			jnz		delay

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
            
