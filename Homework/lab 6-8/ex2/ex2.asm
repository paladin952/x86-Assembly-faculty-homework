;Se dau doua siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel
; fiecare element de pe pozitiile pare din D este suma elementelor de pe pozitiile corespunzatoare din 
;S1 si S2, iar fiecare element de pe pozitiile impare are ca si valoare diferenta elementelor de pe pozitiile
; corespunzatoare din S1 si S2.
;Exemplu
;S1: 1, 2, 3, 4
;S2: 5, 6, 7, 8
;D:   6, -4, 10, -4

assume CS:code, DS:data
data segment
	S1	DB	1, 2, 3, 4
	S2	DB	5, 6, 7, 8
	len 	EQU	 $-S2
	D		DB	len	dup(?)
data ends
code  segment
start:
		mov AX, data
		mov DS, AX
		
		mov SI, 0
		mov CX, len
		again:
			mov AL, S1[Si]
			add AL, S2[SI]
			mov D[SI], AL
			
			mov AL, S1[SI +1]
			sub AL, S2[SI+1]
			mov D[SI+1], AL
		
			inc SI
			inc SI
			
			dec CX
			LOOP again
		
		mov AX, 4c00h
		int 21h
code ends
end start
	