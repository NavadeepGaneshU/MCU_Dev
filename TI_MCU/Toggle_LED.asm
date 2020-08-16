;Simple program to implement LED toggling with Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:
		bis.b	#BIT0, &P1DIR  		          ; Set P1DIR to OUTPUT
		bic.b	#LOCKLPM5, &PM5CTL0         ;Turn on Digital_IO by removing low power state lock.

main:
		bis.b	#BIT0, &P1OUT               ; Turn LED ON
		bic.b	#BIT0, &P1OUT	              ;Turn LED OFF(P1.0)
                                            
		jmp main
		NOP
