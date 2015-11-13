;4. (a*2+b/2+e)/(c-d)
;a-word; b,c,d-byte; e-doubleword



assume CS:code, DS:Data
data segment
	a	DW	112
	b	DB	12
	c	DB	140
	d	DB	123
	e	DD	110
	res	DW	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	;a*2
	mov AX, a
	mov BX, 2
	mul BX ; DX:AX = a * 2
	mov CX, DX
	mov BX, AX ;CX:BX = a * 2
	
	;b/2
	mov AL, b
	mov AH, 0
	mov DL, 2
	div DL ; AL = b/2
	
	;a*2+b/2
	mov AH, 0
	mov DX, 0
	add BX, AX
	adc CX, DX ; CX:BX = a*2+b/2
	
	;a*2+b/2 + e
	add BX, word PTR e
	adc CX, word PTR e+2 ; CX:BX = a*2+b/2 + e
	
	;c-d
	mov AL, c
	sub AL, d ; AX = c -d
	
	;(a*2+b/2+e)/(c-d)
	mov DL, AL ; DL = c -d
	mov AX, BX
	mov BL, DL
	mov DX, CX ; DX:AX = a*2+b/2 + e
	
	mov BH, 0
	div BX
	
	mov res, AX
	
	mov AX, 4c00h
	int 21h
code ends
end start
	