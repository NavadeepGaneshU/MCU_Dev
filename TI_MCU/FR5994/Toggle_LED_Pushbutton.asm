;Program to implement LED pushbutton toggling with Assembly Code.
;Hardwrae used : MSP430FR5994 Launchpad DevKit.
;Software used : Code Composer Studio 9.3.0

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:
		bis.b	#BIT0,	&P1DIR	      ;Setup P1.0 as OUT(LED)
		bic.b	#BIT0,	&P1OUT	      ;Set initial value of LED1 = OFF

		bic.b	#BIT6,  &P5DIR        ;Set P5.6 as input(pushbutton)
		bis.b	#BIT6,   &P5REN       ;Enable PULL Resistor
		bis.b	#BIT6,   &P5OUT       ;Configure resistor as PULLUP

		bic.b	#LOCKLPM5, &PM5CTL0   ; Enable digital IO

main:

poll_s1:
			bit.b	#BIT6,	&P5IN       ;Test P5.6(For Pushbutton)
			jnz		poll_s1			        ;Stay in polling loop

toggle_LED1:
			xor.b	#BIT0,	P1OUT       ; Toggle LED1

;You may see signal bouncing with the implementatio of above code due to very small slew.
;So, adding a small delay for human finger response match.
;---------------------------------------------
			mov.w	#0FFFFh, R4          ;Some big numer in R4

delay:
			
      dec.w	R4                   ;Keeps on decrementing above big number by 1 until its 0.
			
      jnz		delay
      
;----------------------------------------------

			jmp main
			NOP
