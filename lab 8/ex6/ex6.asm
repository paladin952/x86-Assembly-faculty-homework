
;6. Implement an authentication program. The program has the string 'password' defined in its data segment. 
;The program repeatedly asks the user to input the password at the keyboard and verifies if the password given 
;by the user is identical with the string 'password' from the data segment and prints a suitable message on the screen.
; The program exits when the user guessed the password.

assume cs:code, ds:data
data segment

	pass	DB	'password'
    len	EQU	$-pass
	msg1	DB	'Enter the password: $'
	msg2	DB	'Wrong password$'
	msg3	DB	'Succesfuly loged in$'
	LinieNoua db 10,13,'$'
	userI	DB	12,?,13 dup (?)
data ends

code segment
start:
	 mov ax, data ; incarcam adresa segmentului de date in resgistrul ds
	 mov ds, ax
	 
	 mov ah, 09h
	 LEA DX,msg1
	 int 21h
	 
	 mov ah, 0Ah
	 mov dx, offset userI
	 int 21h
	 
	 mov AL, len
	 mov AH, userI[1]
	 
	 CMP AH, AL
	 JNZ wrong
	 
	 mov BL, 0
	 mov BH, 0
	 while1:
		CMP BL, len
		JZ endProg
		mov CL, userI[BX+2]
		CMP CL, pass[BX]
		JNZ wrong
		inc BX
		JMP while1
	
	 
	 wrong:
		mov ah, 09h
		lea dx, LinieNoua
		int 21h
	 
		mov ah, 09
		LEA DX,msg2
		int 21h
		JMP deadEnd
	endProg:
		mov ah, 09h
		lea dx, LinieNoua
		int 21h
	
		mov ah, 09h
		LEA DX,msg3
		int 21h
	
	deadEnd:
	 mov ax, 4c00h ; terminam programul
	 int 21h
code ends
end start