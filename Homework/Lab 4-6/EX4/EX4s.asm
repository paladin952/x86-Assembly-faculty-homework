;4. (a*2+b/2+e)/(c-d)
;a-word; b,c,d-byte; e-doubleword



assume CS:code, DS:Data
data segment
	a	DW	123
	b	DB	12
	c	DB	12
	d	DB	13
	e	DD	110
	res	DW	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	;a * 2
	mov AX, a
	mov BL, 2
	imul BL ; DX:AX = a * 2
	
	mov CX, DX
	mov BX, AX ; CX:BX = a*2
	;b/2
	mov AL, b
	CBW
	mov CL, 2
	idiv CL ; AL = b/2
	CBW ;AX = b/2
	;a*2+b/2
	add BX, AX
	adc CX, 0 ;CX:BX = a*2+b/2
	
	;a*2+b/2+e
	add BX, word PTR e
	adc CX, word PTR e+2 ;CX:BX = a*2+b/2+e
	
	;c-d
	mov AL, c
	mov DL, d
	sub AL, DL ;AL = c-d = - 1
	CBW ; AX = AL = c-d = FFC0
	
	;(a*2+b/2+e)/(c-d)
	mov DX, CX
	mov CX, AX
	mov	AX, BX
	
	idiv CX ; AX = DX:AX / CX = (a*2+b/2+e)/(c-d)
	
	mov res, AX
		
	mov AX, 4c00h
	int 21h
code ends
end start
	