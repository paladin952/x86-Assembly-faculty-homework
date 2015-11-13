
;3. (8-a*b*100+c)/d
;a,b,d-byte; c-doubleword

assume CS:code, DS:data
data segment
	a	DB	1
	b	DB	0
	d	DB	250
	c	DD	2
	res DW	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	;a*b*100+c
	mov AL, a
	mul b ; AX = a * b
	mov BX, 100
	mul BX ; DX:AX = a *b *100
	
	add AX, word PTR c
	adc DX, word PTR c+2
	
	;8-a*b*100+c
	mov BX, 8
	mov CX, 0 ; CX:BX = 8
	
	sub BX, AX;	
	sbb CX, DX;	
	
	;(8-a*b*100+c)/d
	mov AX, BX
	mov DX, CX
	
	mov BL, d
	mov BH, 0
	div BX ; DX:AX / d
	
	mov res, AX
	
	
	mov AX, 4c00h
	int 21h


code ends
end start