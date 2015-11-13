
;1. Being given two alphabetical ordered strings of characters, s1 and s2,
; build using merge sort the ordered string of bytes that contain all characters from s1 and s2.



assume CS:code, DS:data
data segment
	
	S1	DB	"abcdeefghj"
	len1 	EQU	$-S1
	S2	DB	"cdefgh"
	len2	EQU	$-S2
	D		DB	len1+len2 dup(?)
	;abcceeeffgghhj

data ends
code segment
start:
		push data
		pop	DS
		
		mov SI, 0
		mov BP, 0
		mov DI, 0
		
		while1:
			mov AL, S1[SI]
			mov AH, S2[BP]
			
			CMP DI, len1+len2
			JZ print
			
			CMP SI, len1
			JZ S1finish
			
			CMP BP, len2
			JZ S2finish
			
			CMP	AL, AH
			JS S1greater
			JMP S2greater
		
		S1greater:		
			mov D[DI], AL
			inc DI
			inc SI
			JMP while1
		
		S2greater:
			mov D[DI], AH
			inc DI
			inc BP
			JMP while1
			
		S1finish:
			mov D[DI], AH
			inc DI
			inc BP
			JMP while1
			
		S2finish:
			mov D[DI], AL
			inc Di
			inc SI
			JMP while1
			
		print:
			mov SI, 0
			while2:
				mov AH, 02h
				mov DL, D[SI]
				int 21h
				inc SI
				CMP SI, DI
				JZ endProg
				JMP while2
		
		endProg:
			mov AX, 4c00h
			int 21h

code ends
end start

