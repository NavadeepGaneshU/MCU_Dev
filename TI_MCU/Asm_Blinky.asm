;Simple program to Blink LED using Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:					     ;Address lable-initialisation
       bic.w	#0001h, &PM5CTL0             ;disables GPIO power on HIGH Z
       bis.b    #01h,   &P1DIR               ; setting PIN1.0 as output(for LED)

main:
		   xor.b    #01h,   &P1OUT             ; Toggle PIN1.0
		   mov.w    #0FFFFh, R4                ;puts big number in R4

delay:
       dec.w	R4                         ;decrement R4
       jnz      delay                      ;conditional branch instruction
                                           ;repeat until R4=0

		   jmp      main           ;repeat forever
		   NOP

;-------------------------------------------------------------------------------
