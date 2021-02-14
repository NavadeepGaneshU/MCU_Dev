;Simple program defining basic Logic implementation with Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:

            ;Inverting operation
			mov.b	#10101010b, R4			;# puts a value in register
			inv.b	R4				;invert be binary at R4

	    ;Bit masking with AND - ANDing anything with 1 has no effect
			mov.b	#11110000, R5
			and.b	#00111111b, R5			;clear bits 6, 7

	   
	   ;Bit test
			mov.b	#00010000b, R6			;is bit7 a 1 or 0?
			and.b	#10000000b, R6                  ;test bit "1" for position 7

			mov.b	#00010000b, R7			;is bit4 a 1 or 0?
			and.b	#00010000b, R7			;test bit "1" for position 4

	   
	   ;Set operation with OR - ORing anything with 1 will give 1(set)
			mov.b	#11000001b, R8
			or.b	#00011111b, R8			;set bits 4:0

	    
	    ;Toggling operation with XOR - XORing anything with 1 will invert(toggle state)
	    ;				 - XORing anything with 0 will have no effect
			mov.b	#01010101b, R9
			;xor.b	#11110000b, R9			;toggle
			xor.b	#00001111b, R9			;toggle

jmp main
NOP
