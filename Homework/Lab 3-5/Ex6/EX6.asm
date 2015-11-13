;6. yy-(d+m)+(h+yy)

assume CS:code, DS:data
data segment
	yy	DW	20
	d	DB	2
	m	DD	10
	h	DD	150
	res	DD	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	;d + m
	mov AL, d
	mov AH, 0
	
	add word PTR m, AX ; m = 12
	adc word PTR m + 2, 0
	;yy - (d+m)
	mov AX, yy
	mov DL, 0
	mov DH, 0
	
	sub AX, word PTR m
	sbb DX, word PTR m + 2 ; DX:AX = 8
	
	;h + yy
	mov CX, yy
	mov word PTR res, CX ; res = yy = 20
	
	mov CX, word PTR h
	mov BX, word PTR h+2
	
	add word PTR res, CX
	adc word PTR res+2, BX
	
	; first + second
	add AX, word PTR res
	adc DX, word PTR res + 2
	
	mov word PTR res, AX
	mov word PTR res+2, DX
	
	mov AX, 4c00h
	int 21h
code ends
end start