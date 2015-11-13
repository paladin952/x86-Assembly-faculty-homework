;6. A byte string S is given. Obtain the string D1 which contains all the even numbers
 ;of S and the string S2 which contains all the odd numbers of S.
;Exemple:
;S: 1, 5, 3, 8, 2, 9
;D1: 8, 2
;D2: 1, 5, 3, 9

assume CS:code, DS:data
data segment

		S		DB	1, 5, 3, 8, 2, 9
		len	EQU	$-S
		D1	DB	len dup(?)
		D2	DB	len dup(?)
		two	DB	2
	
data ends

code  segment
start:
		mov AX, data
		mov DS, AX
		
		mov CX, len
		mov SI, 0
		mov BX, 0
		mov DI, 0
		
			
		again:
			
			mov AH, 0
			mov AL, 0
			add AL, S[Si] ; for parity flag to be set
			mov DL, S[Si] ;backup
			
			div two
			CMP AH, 1
			JZ evenNo
			JNZ oddNo
			
			
		
		evenNo:
			mov D1[BX], DL
			inc BX
			inc SI
			dec CX
			CMP CX, 0
			JG again
		
		JCXZ endprog
		oddNo:		
			mov D2[DI], DL
			inc DI
			inc SI
			dec CX
			CMP CX, 0
			JG again
			
		endprog:
			
		mov AX, 4c00h
		int 21h
code ends
end start
	