;8. Two byte strings S1 and S2 are given, having the same length. Obtain the string D
; so that each element of D represents the maximum of the corresponding elements from S1 and S2.
;Exemple:
;S1: 1, 3, 6, 2, 3, 7
;S2: 6, 3, 8, 1, 2, 5
;D: 6, 3, 8, 2, 3, 7





assume CS:code, DS:data
data segment
	
	S1	DB	1, 3, 6, 2, 3, 7
	S2	DB	6, 3, 8, 1, 2, 5
	len	EQU	$-S2
	D		DB	len dup(?)
	
data ends

code  segment
start:
		mov AX, data
		mov DS, AX
		mov CX, len
		
		mov SI, 0
		again:
			mov AL, 0
			mov AL, S1[SI]
			CMP AL, S2[SI]
			JNS firstBigger
			JS secondBigger
			
		firstBigger:
			mov D[SI], AL
			inc SI
			dec CX
			CMP CX, 0
			JG again
			
		JCXZ endProg
		secondBigger:
			mov BL, S2[SI]
			mov D[SI], BL
			inc SI
			dec CX
			CMP CX, 0
			JG again
		endProg:
		
			
		mov AX, 4c00h
		int 21h
code ends
end start
	