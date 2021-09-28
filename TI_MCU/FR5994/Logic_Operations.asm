;Simple program defining basic Logic implementation with Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:
		mov.b   #10101010b, R4		;Input Binary to R4
		inv.b	R4					;Inverter

		mov.b	#11110000b, R5
		and.b	#00111111b, R5		;Clear bits 6&7(bit masking)


		jmp			main
		NOP
