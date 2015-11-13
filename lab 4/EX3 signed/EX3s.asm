
;3. (8-a*b*100+c)/d
;a,b,d-byte; c-doubleword

assume CS:code, DS:data
data segment
	a	DB	1
	b	DB	10
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
	imul b	; AX = a * b
	mov BX, 100
	imul BX ;DX:AX = AX * BX = a *b * 100
	
	mov BX, AX ; CX:DX = a *b * 100
	mov CX, DX
	
	add BX, word PTR c ; CX:BX = a*b*100+c
	adc CX, word PTR c+2 
	
	;(8-a*b*100+c)
	mov AL, 8
	CBW	; AX = 8
	CWD	; DX:AX = 8
	
	sub AX, BX 
	sbb DX, CX ; DX:AX =DX:AX - CX:BX = (8-a*b*100+c)
	
	;(8-a*b*100+c)/d
	mov BX, AX
	mov CX, DX ; CX:BX = DX:AX = (8-a*b*100+c)
	
	mov AL, d 
	CBW ; AX = d
	mov SI, AX ; SI = d
	
	mov AX, BX	
	mov DX, CX ; DX:AX = CX:BX = (8-a*b*100+c)
	
	idiv SI  ;DX:AX / d
	
	mov res, AX
	
	
	
	
	
	
	mov AX, 4c00h
	int 21h


code ends
end start