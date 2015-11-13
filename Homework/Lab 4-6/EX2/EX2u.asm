
;2. 2/(a+b*c-9)+d
;a,b,c-byte; d-doubleword


assume CS:code, DS:data
data segment
	a	DB	15
	b	DB	15
	c	DB	6
	d	DD	85
	res	DD	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	;(a+b*c-9)
	mov AL, b
	mul c
	add AL, a
	adc AH, 0
	sub AX, 9
	
	;(a+b*c-9)+d
	mov DX, 0
	
	add AX, word PTR d
	adc DX, word PTR d + 2
	
	mov word PTR res, AX
	mov word PTR res +2 , DX
	
	

	mov AX, 4c00h
	int 21h
code ends
end start