;6. Dandu-se un sir de cuvinte sa se obtina sirul (de octeti) cifrelor in baza zece ale fiecarui cuvant din acest sir. 
;Ex.: daca avem sirul: sir DW 12345, 20778, 4596 
;obtinem rezultatul 1, 2, 3, 4, 5, 2, 0, 7, 7, 8, 4, 5, 9, 6.

assume CS:code, DS:data


data segment
	A			DW	12345, 20778, 4596
	len		EQU	($-A)/2
	nr			EQU	len*5
	ten		DW	10
	counter	DW	0	
	B			DB	5 dup(?)
	C			DB	nr	dup(?)

data ends
code segment
start:
	mov AX, data
	mov DS, AX
	mov SI, 0
	mov DI, 0
	
	while1:
		mov AX, A[SI]
		mov DX, 0
		mov BP, 0
		mov counter, DX ; counter = 0
		CMP SI, len*2-1
		JG endProg
		add SI, 2
		while2:
			div ten
			mov B[BP], DL
			mov DX, 0
			inc BP
			inc counter
			CMP AX, 0
			JZ saveInVector
			JMP while2
		saveInVector:
			mov BP, counter
			dec BP
			while3:
				mov BL, B[BP]
				mov C[DI], BL
				inc DI
				CMP BP, 0
				JZ while1
				dec BP
				JMP while3
		endProg:
	
	mov AX, 4c00h
	int 21h

code ends
end start