
;1. A string of bytes is given in the data segment. Print on the standard output (screen) the elements of this string in base 2.

assume CS:code, DS:data

data segment
		
	S		DB	1,2,5
	len	EQU	$-S
	B		DB	 8 dup(?)
	two	DB	 2
	
data ends

code segment
start:

	mov AX, data
	mov DS, AX
	
	mov SI, 0
	
	while1:
		mov AH, 02h
		mov DL, 32
		int 21h
		
		mov BP, 0
		mov BX, 0
		CMP SI, len
		JZ endProg
		inc SI
		JMP convert
	
	convert:
		mov AL, S[SI-1]
		again:
			mov AH, 0
			div	two
			mov B[BP], AH
			inc BP
			CMP AL, 0
			JZ show
			JMP again
		
	show:
		while2:
			mov AL, B[BP]
			CMP AL, 0
			JZ isZero
			JMP isOne
	
	isZero:
		mov AH, 02h
		mov DL, 48
		int 21h
		dec BP
		CMP BP, 0
		JZ while1
		JMP show
	isOne:
		mov AH, 02h
		mov DL, 49
		int 21h
		dec BP
		CMP BP, 0
		JZ while1
		JMP show
		
			
	
	
	endProg:
		mov AX, 4c00h
		int 21h
code ends
end start


