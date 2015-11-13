
;a*a-b+7)/(2+a)
;a-byte; b-doubleword

assume CS:code, DS:data
data segment
	a	DB	12
	b	DD	10
	res	DW	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	mov AL, a
	mul a ; AX = a * a
	
	
	mov DL, 0 ;DX:AX = a*a
	mov DH, 0
	
	sub AX, word PTR b
	sbb DX, word PTR b+2 ; a*a - b
	
	add AX, 7 ; + 7
	adc DX, 0
	
	mov BL, a
	add BL, 2
	mov BH, 0 ; BX = 2 + a
	
	div BX ; DX:AX / BX -> AX cat 
	
	mov res, AX
	
	
	
	mov AX,4c00h
	int 21h

code ends
end start