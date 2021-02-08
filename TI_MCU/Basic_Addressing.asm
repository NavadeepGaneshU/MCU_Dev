;Simple program showing different addressing methodologies with Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

			;1] ABLOSUTE MODE ADDRESSING
;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:
		mov.w   &2000h, R4              ;Copy contents from 2000h to 2004h
		mov.w   R4, &2004h

		mov.w   &2002h, R5              ;Copy contents from 2002h to 2006h
		mov.w   R5, &2006h

		jmp		main
		NOP

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------

		.data							        ;Go to data memory
		.retain			

Const1:	.short		1234h				;Setup constant 1234h
Const2: .short		0CAFEh			;Setup constant 0CAFEh

Var1:	.space		2					    ;Reserve 2 bytes
var2:	.space		2					    ;Reserve 2 bytes


			;2] REGISTER MODE ADDRESSING
;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:
		mov.w	PC, R4						;copy PC to R4
		mov.w   R4,	R5
		mov.w   R5, R6

		mov.b	PC, R7						;copy LB of PC into R7
		mov.b   R7, R8
		mov.b  	R8, R9

		jmp main							;repeat main loop
		NOP
		

			;3] IMMEDIATE MODE ADDRESSING
;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:
			mov.w	#1234h, R4				;put 1234h to R4
			mov.w	#0FACEh, R5				;put FACE text into R5

			mov.b	#99h, R6				;put 99h num to R6
			mov.b	#0EEh, R7				;put EEh text into R7

			mov.b	#87, R8				    ;put decimal to R8
			mov.b	#10101010b, R9			;put decimal to R9
			mov.b	#"B", R10				;put B ASCII to R10

			jmp		main
			NOP
                                            

			
			
			;4] SYMBOLIC MODE ADDRESSING
;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:
		mov.w 	Const1, R4
		mov.w	R4, Var1
    
		mov.w	Const2, R5
		mov.w	R5,  Var2

		jmp		main
		NOP

;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------
		.data
		.retain

Const1:		.short	1234h
Const2:		.short	0CAFEh

Var1:		.space	2
Var2:		.space	2
