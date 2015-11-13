;3. Se da un sir de octeti S. Sa se construiasca sirul D astfel: sa se puna mai 
;intai elementele de pe pozitiile pare din S iar apoi elementele de pe pozitiile impare din S.
;Exemplu:
;S: 1, 2, 3, 4, 5, 6, 7, 8
;D: 1, 3, 5, 7, 2, 4, 6, 8

assume CS:code, DS:data
data segment
	S1	DB	1,2,3,4,5,6,7,8
	len EQU	$ - S1
	half	EQU	len/2
	D		DB	len dup (?)

data ends
code  segment
start:
		mov AX, data
		mov DS, AX
		mov CX, len
		mov SI, 0
		mov BX, 0
		again1:
			mov AL, S1[SI]
			mov D[BX], AL
			
			inc SI
			inc SI
			inc BX
			dec CX
			dec CX
			
			CMP CX, 0
			JG again1
			
			
		mov SI, 0
		mov SI, 1
		mov CX, len
		again2:
			mov AL, S1[SI]
			mov D[BX], AL
			
			inc SI
			inc SI
			inc BX
			dec CX
			dec CX
			
			CMP CX, 0
			JG again2
			
			
			
		mov AX, 4c00h
		int 21h
code ends
end start
	