;7. A byte string S is given. Obtain the string D1 which contains the 
;elements found on the even positions of S and the string D2 which 
;contains the elements found on the odd positions of S.
;Exemple:
;S: 1, 5, 3, 8, 2, 9
;D1: 1, 3, 2
;D2: 5, 8, 9


assume CS:code, DS:data
data segment
	
	S		DB	1, 5, 3, 8, 2, 9
	len	EQU	$-S
	D1	DB	len dup(?)
	D2	DB	len	dup(?)
	two	DB	2
		
	
data ends

code  segment
start:
		mov AX, data
		mov DS, AX
		
		mov SI, 0
		mov BX, 0
		mov BP, 0
		mov CX, len
		
		again:
			mov AL, 0
			mov AH, 0
			mov AX, SI
			mov DL, S[SI]
			div two
			
			CMP AH, 1 ;if odd or even
			JZ evenPos
			JNZ oddPos
		

		evenPos:
			mov D2[BX], DL
			inc BX
			inc SI
			dec CX
			CMP CX, 0
			JG again
			
		JCXZ endProg
		oddPos:
			mov D1[BP], DL
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
	