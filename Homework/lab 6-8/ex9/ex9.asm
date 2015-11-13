;9. A byte string S is given. Obtain the string D1 which contains all
; the positive numbers of S and the string D2 which contains all the negative numbers of S.
;Exemple:
;S: 1, 3, -2, -5, 3, -8, 5, 0
;D1: 1, 3, 3, 5, 0
;D2: -2, -5, -8






assume CS:code, DS:data
data segment
	
	S		DB	1, 3, -2, -5, 3, -8, 5, 0
	len	EQU	$-S
	D1	DB	len dup(?)
	D2	DB	len dup(?)
	
	
data ends

code  segment
start:
		mov AX, data
		mov DS, AX
		
		mov SI, 0
		mov CX, len
		mov BX, 0
		mov BP, 0
		
		again:
			CMP S[Si], 0
			JS negNo
			JNS	posNo
			
		posNo:
			mov AL, S[Si]
			mov D1[BX], AL
			inc BX
			inc SI
			dec CX
			CMP CX, 0
			JG again
			
		JCXZ endProg
		negNo:
			mov AL, S[SI]
			mov D2[BP], AL
			inc BP
			inc SI
			dec CX
			CMP CX, 0
			JG again
			
		endProg:
		
		
			
		mov AX, 4c00h
		int 21h
code ends
end start
	