;14. Two character strings S1 and S2 are given. Obtain the string D by concatenating 
;the elements found on the positions multiple of 3 from S1 and the elements of S2 in reverse order.
;Exemple:
;S1: '+', '4', '2', 'a', '8', '4', 'X', '5'
;S2: 'a', '4', '5'
;D: '+', 'a', 'X', '5', '4', 'a'





;coparing the asccii code
;must be between 48-57
assume CS:code, DS: data

data segment
	
	S1	DB	'+', '4', '2', 'a', '8', '4', 'X', '5'
	len	EQU	$-S1
	S2	DB	'a', '4', '5'
	len2	EQU	$-S2
	D		DB	len	dup(?)
	three	DB	3
	
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	mov SI, 0
	mov BP, 0
	
	while1:
		mov AX, SI
		div three
		CMP AH, 0
		JZ setNumber
		;else
		CMP SI, len-1
		JGE goToD2
		inc SI
		JMP while1
	
	setNumber:
		mov DL, S1[SI]
		mov D[BP], DL
		inc BP
		CMP  SI, len-1
		JGE goToD2
		;else
		inc SI
		JMP while1
	
	
	goToD2:
			mov CX, len2
			mov SI, CX
			dec SI
		while2:
			mov DL, S2[SI]
			mov D[BP], DL 
			inc BP
			dec SI
			LOOP while2
	
	
	
	mov AX, 4c00h
	int 21h
code ends
end start