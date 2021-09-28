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



;2] SYMBOLIC MODE ADDRESSING
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
