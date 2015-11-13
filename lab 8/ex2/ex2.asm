;2. Read a character from the keyboard without echo. If the character is a digit, print it on the screen. 
;If the character is '$', end the current program. In any other situation, the character is added to a buffer 
;(i.e. a string) which will be printed on the screen when the program exits.


assume CS:code, DS:data

data segment
	
	msg1		DB		"Enter the digits: $"
	msg2		DB		"The result is: $"
	msg3		DB		"The input is null!$"
	newLine DB		10,13,'$'
	string		DB		20 dup(?)
	
	
data ends

code segment
start:

	mov AX, data
	mov DS, AX
	
	mov AH, 09h
	lea DX, msg1
	int 21h
	
	mov SI, 0
	while1:
		mov AH, 01h
		int 21h
		CMP AL, '$'
		JZ print
		
		;is digit?
		CMP AL, 48
		JAE greater
		JMP while1
		
	greater:
		CMP AL, 57
		JBE save
		JMP while1
	
	save:
		mov string[SI], AL
		inc SI
		JMP while1
		
		
	print:
		
		CMP SI, 0
		JZ null
		mov BL, '$'
		mov string[SI], BL
		
		;newl ine
		mov AH, 09h
		lea DX, newLine
		int 21h
		
		mov AH, 09h
		lea DX, msg2
		int 21h
		
		mov AH, 09h
		lea DX, string
		int 21h
		JMP endProg
	
	null:
		mov AH, 09h
		lea DX, newLine
		int 21h
	
		mov AH, 09h
		lea DX, msg3
		int 21h
	
	endProg:
		mov AX, 4c00h
		int 21h
code ends
end start


