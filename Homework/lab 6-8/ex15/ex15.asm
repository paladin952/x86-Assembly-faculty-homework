;15. A byte string S is given. Build the string D whose elements represent the sum 
;of each two consecutive bytes of S.
;S: 1, 2, 3, 4, 5, 6
;D: 3, 5, 7, 9, 11



assume CS:code, DS: data

data segment
	
	S		DB	1, 2, 3, 4, 5, 6
	len	EQU	$-S
	D		DB	len-1	dup(?)
	
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	mov SI, 0
	mov BP, 0
	
	while1:
		mov BL, S[SI]
		add BL, S[SI+1]
		mov D[BP], BL
		
		inc BP
		inc SI
		
		CMP SI, len-2
		JLE while1
	
	
	
	mov AX, 4c00h
	int 21h
code ends
end start