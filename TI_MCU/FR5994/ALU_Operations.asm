;Simple program to implement arithmetic operations with Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:

		mov.w	     #371, R4		     ;put 371 to R4
		mov.w	     #465, R5
		add.w	     R4,	R5			     ;R5 = R4+R5

		mov.w	     #0FFFEh, R6      ;Put FFFFEh to R6
		add.w	     #0001h,  R6      ;R6=1+R6

		mov.w	     #0FFFFH, R7
		add.w	     #1h,  R7         ;R7=R7+1

		jmp	    main
    NOP
