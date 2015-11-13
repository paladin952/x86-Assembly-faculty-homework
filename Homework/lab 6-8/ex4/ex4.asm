;4. A byte string S of length l is given. Obtain the string D of length
; l-1 so that the elements of D represent the difference between every
; two consecutive elements of S.
;Exemple:
;S: 1, 2, 4, 6, 10, 20, 25
;D: 1, 2, 2, 4, 10, 5

assume CS:code, DS:data
data segment

	S		DB	1,2,3,4,6,10,20,25
	len	EQU	$-S -1
	D		DB	len dup(?)
	
data ends

code  segment
start:
		mov AX, data
		mov DS, AX
		
		mov CX, len 
		mov SI,0
		again:
			mov AL, S[SI+1]
			sub AL, S[Si]
			mov D[BX], AL
			
			inc SI
			inc BX
			LOOP again
			
		mov AX, 4c00h
		int 21h
code ends
end start
	