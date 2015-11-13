;12. A byte string S is given. Obtain the maximum of the elements found on the even
; positions and the minimum of the elements found on the odd positions of S.
;Exemple:
;S: 1, 4, 2, 3, 8, 4, 9, 5
;max_even_pos: 9
;min_odd_pos:3



assume CS:code, DS: data
data segment
	
	S		DB	1, 4, 2, 3, 8, 4, 9, 5
	len	EQU	$-S
	max	DB	-127
	min	DB	127
	two	DB	2
	aux	DB	?
	
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	mov SI, 0
	again:
		mov AX, SI
		div	two
		
		CMP AH, 1 ; we check if it ithe position is odd or even
		JZ oddPos
		JNZ evenPos
		
	oddPos:
		
		mov BL, min
		CMP BL, S[SI]
		JG setMin
		CMP SI, len-1
		JZ endProg
		inc SI
		JMP again
	setMin:
		mov DL, S[SI]
		mov min, DL
		
		CMP SI, len-1
		JZ endProg
		
		inc SI
		JMP again
		
	evenPos:
		mov BL, max
		CMP BL, S[SI]
		JL setMax
		
		CMP SI, len-1
		JZ endProg
		
		inc SI
		JMP again
	setMax:
		mov DL, S[SI]
		mov max, DL
		
		CMP SI, len-1
		JZ endProg
		inc SI
		
		JMP again
		
		
	endProg:
	
	
	mov AX, 4c00h
	int 21h
code ends
end start
