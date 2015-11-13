;1. Two byte strings S1 and S2 are given. Obtain the string D by concatenating the elements of S1 from the left hand side to the right hand side and the elements of S2 from the right hand side to the left hand side.
;Exemple:
;S1: 1, 2, 3, 4
;S2: 5, 6, 7
;D: 1, 2, 3, 4, 7, 6, 5

assume CS:code, DS:Data
data segment
	S1	DB	'1', '2', '3', '4'
	L1	EQU	$ - S1
	S2	DB	'5', '6', '7'
	L2	EQU	$ - S2
	L3	EQU	L1+L2
	D	DB	L3 dup(?)
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	
	mov SI, 0 ;index register
	mov BX, 0
	mov CX, L1
	
	Repeat1:
		mov AL, S1[SI]
		mov byte PTR D[SI], AL
		inc SI
		LOOP Repeat1
	mov CX, L2
	add SI, L2-1
	Repeat2:
		mov AL, S2[BX]
		mov byte PTR D[SI], AL
		INC BX
		DEC SI
		LOOP Repeat2
	
	mov AX, 4c00h
	int 21h
code ends
end start
	