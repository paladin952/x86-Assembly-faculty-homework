;10. A byte string S is given. Obtain in the string D the set of the elements of S.
;Exemple:
;S: 1, 4, 2, 4, 8, 2, 1, 1
;D: 1, 4, 2, 8

assume CS:code, DS: data

data segment
	
	S		DB	1, 4, 2, 4, 8, 2, 1, 1
	len	EQU	$-S
	D		DB	len dup(?)
	

data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	mov SI, 0
	mov BP, 0
	
	again:
		mov AL, S[SI]
		JMP verifyDuplicate
	
	
	verifyDuplicate:
		mov BX, len
		again2:
			CMP AL, D[BX-1]
			JZ exist
			
			dec BX
			
			CMP BX, 0
			JG again2
		
		mov D[BP], AL
		inc BP
		inc SI
		JMP again
		
	exist:
		inc Si
		CMP SI, len-1
		JZ endProg
		JMP again
		
	endProg:
	
	
	mov AX, 4c00h
	int 21h
code ends
end start