;1. (a*a-b+7)/(2+a)
;a-byte; b-doubleword
;signed rep

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
	imul a ; AX = AL * a = a * a = 144
	
	add word PTR b, 7
	adc word PTR b + 2, 0	 ; b = b + 7
	
	CWD ; DX:AX = a * a, double word
	
	sub AX, word PTR b
	sbb DX, word PTR b + 2 ; DX:AX = a * a - b + 7
	mov BX, AX
	mov CX, DX
	
	mov AL, a
	add AL, 2
	CBW
	mov DX, AX
	CBW
	mov DX, AX
	mov AX, BX
	mov BX, DX
	mov DX, CX
	
	idiv BX ;	AX = DX:AX / BX integer part
	
	mov res, AX
	
	mov AX, 4c00h
	int 21h
code ends
end start
		
