;5. Two byte string S1 and S2 are given, having the same length. 
;Obtain the string D by intercalating the elements of the two strings. 
;Exemple: 
;S1: 1, 3, 5, 7
;S2: 2, 6, 9, 4
;D: 1, 2, 3, 6, 5, 9, 7, 4

assume CS:code, DS:data
data segment

	S1	DB	1,3,5,7
	S2	DB	2,6,9,4
	len	EQU	$-S1
	D		DB	len	dup(?)

data ends

code  segment
start:
		mov AX, data
		mov DS, AX
		
		mov SI, 0
		mov BX, 0
		mov CX, len/2
		again:
			mov AL, S1[SI]
			mov D[BX], AL
			inc BX
			
			
			mov AL, S2[SI]
			mov D[BX], AL
			inc BX
			inc SI
			LOOP again
			
		mov AX, 4c00h
		int 21h
code ends
end start
	