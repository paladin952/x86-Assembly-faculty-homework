;2. 2/(a+b*c-9)+d
;a,b,c-byte; d-doubleword

assume CS:code, DS:data

data segment
	a	DB	12
	b	DB	21
	c	DB	10
	d	DD	231
	res	DD	?
data ends
code segment
start:
		mov AX, data
		mov DS, AX
		
		;(a+b*c-9)
		mov AL, b
		imul c
		add AL, a
		adc AH, 0
		sub AX, 9
		
		CWD
		
		add AX, word PTR d
		adc	DX, word PTR d+2
		
		mov word PTR res, AX
		mov word PTR res+2, DX
		
	
		mov AX, 4c00h
		int 21h
code ends
end start

