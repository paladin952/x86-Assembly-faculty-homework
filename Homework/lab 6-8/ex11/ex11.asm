;11. Two character strings S1 and S2 are given. Obtain the string D which contains all 
;the elements of S1 that do not appear in S2.
;Exemple:
;S1: '+', '4', '2', 'a', '8', '4', 'X', '5'
;S2: 'a', '4', '5'
;D: '+', '2', '8', 'X'

assume CS:code, DS: data

data segment
	
	S1	DB	'+', '4', '2', 'a', '8', '4', 'X', '5'
	len1	EQU	$-S1
	S2	DB	'a', '4', '5'
	len2	EQU	$-S2
	D		DB	len1 dup(?)
	
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	mov BP, 0 ; index of D
	mov SI, 0; index of S1
	mov CX, len1
	
	again:
		mov AL, S1[SI]
		JMP checkExist
		
	
	
	checkExist:
		mov BX, len2-1 ; index of S2
		again2:
			CMP AL, S2[BX]
			JZ exist
			dec BX
			CMP BX, 0
			JGE again2
			
		mov D[BP], AL
		inc BP
		inc SI
		CMP SI, len1-1
		JZ endProg ; end of program if is the end or array
		JMP again
	
	exist:
		inc SI
		CMP SI, len1-1
		JZ endProg ; end of program if is the end or array
		JMP again
		
	endProg:
		
	
	mov AX, 4c00h
	int 21h
code ends
end start