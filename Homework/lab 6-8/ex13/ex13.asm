;13. A character string S is given. Obtain the string D which contains all the digit characters of S.
;Exemple:
;;S: '+', '4', '2', 'a', '8', '4', 'X', '5'
;D: '4', '2', '8', '4', '5', '9'


;coparing the asccii code
;must be between 48-57
assume CS:code, DS: data

data segment
	
	S		DB	'+', '4', '2', 'a', '8', '4', 'X', '5', '9'
	len	EQU	$-S
	D		DB	len dup(?)
	
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	mov SI, 0
	mov BP, 0
	mov BL, 48
	mov BH, 57
	
	checkLow: ; check if number is greatter of equal with 48
		CMP S[SI], BL
		JGE checkHigh
		;if not
		;check size
		CMP SI, len-1
		JZ endProg
		;else
		inc SI
		JMP checkLow
	checkHigh: ;check if it is less or equal with 58
		CMP BH, S[SI]
		JGE setNumber
		;if not
		inc SI
		JMP checkLow
		
	setNumber:
		mov DL, S[SI]
		mov D[BP], DL
		CMP SI, len-1
		JZ endProg
		;if not
		inc BP
		inc SI
		JMP checkLow
		
	endProg:
		 
	
	
	mov AX, 4c00h
	int 21h
code ends
end start