
;2 A string of doublewords is given. Order in decreasing order the string of the 
;low words (least significant) from these doublewords. The high words (most significant) remain unchanged. 
;Ex: being given: sir DD 12345678h 1256ABCDh, 12AB4344h 
;the result will be 1234ABCDh, 12565678h, 12AB4344h.


assume CS:code, DS:data
data segment
	
	S		DD	12345678h,1256ABCDh,12AB4344h 
	len	EQU $-S; len = how many bytes we have
	t		DB	?	; truth value
	sixteen	DB	16;
	

data ends
code segment
start:
		push data
		pop	DS
		
		
		;BUBBLE SORT
		bubble:
			mov SI, len-4-1 ; the iterator
			mov t, 1  ; true
			for1:
				mov AX, WORD PTR S[SI]
				CMP  WORD PTR S[SI-4], AX ; we compare if S[SI] > S[SI-1]
				JS greaterThan ; if yes we swap the least significant word from the number
				CMP SI, 3	; if iterator ==1 we end the for and jumb at the end of the while
				JZ endFor
				sub SI,4
				JMP for1
			endFor:
				CMP t, 0 ; if t == false then the string is not sorted
				JZ bubble
				mov SI, 0; if is sorted we need to print it
				JMP print
				
				
		greaterThan:

			mov t, 0
			;swaps the values
			mov BX, WORD PTR S[SI]
			mov DX, WORD PTR S[SI-4]
			
			mov WORD PTR S[SI], DX
			mov WORD PTR S[SI-4], BX
			
			CMP SI, 3
			JZ endFor
			sub SI,4
			JMP for1
			
				;prints DD each number
		print:
			whileWeHaveNumbers:
				mov BP, 3
					inWord:
						mov AH, 0
						mov AL, BYTE PTR S[SI+BP]
					printEachNumber:
						mov AH, 0
						div	sixteen
						CMP AH, 10
						mov DL, AH
						JGE isHexa ; if number > 10
						add DL, 48
						backFromHexa:
						mov BL, AL
						mov AH, 02h
						int 21h
						mov AL, BL

						CMP AL, 0
						JNZ printEachNumber
						
						CMP BP, 0
						dec BP
						JNZ inWord
						; if Di==0 we go for another number
						CMP SI, len
						JZ endProg
						add SI, 4
						mov AH, 02h
						mov DL, 32
						int 21h
						JMP whileWeHaveNumbers
		
		isHexa:
			add DL, 55
			JMP backFromHexa
	
		endProg:
			mov AX, 4c00h
			int 21h

code ends
end start

