;5. Read the numbers a, b and c and compute and print on the screen a+b-c.


ASSUME CS:code, DS:data

data SEGMENT public
	resMSG	DB 10,13,"YOUR RESULT IS: $"
	zece	DW 10
	MSG1 DB 10,13,"ENTER THE NUMBER: $"
	first		DW	?
	second	DW ?
	a			DB	6,?,7 dup(0)
	n			DB	?
	p			DB	1
	ten		DB	10
data ENDS

extrn read: near
extrn compute:near
extrn print:near

code SEGMENT PUBLIC

AfisBaza10 PROC
		; define a procedure which prints the value of the AX register, in base 10, on the screen
		cmp ax, 0
 		jge pozitiv 
		; else, if the number is negative print the character '-' using function 02h a int 21h
		push ax
		mov ah, 02h
		mov dl, '-'
		int 21h
		pop ax
		neg ax ; ax:= -ax

		pozitiv:
		; in order to avoid overflows, we will always divide DX:AX to 10 (not just AX). We
		; keep dividing to 10 and store the remainders (the digits) on the stack. When we will
		; pop the digits off the stack they will be in the reverse order which is the correct order

		mov cx, 0 ; cx will hold the number of digits placed on the stack
		repeta:
			mov dx, 0
			div zece
			push dx
			inc cx
			cmp ax, 0
			ja repeta ; if quotient>0 jmp repeta 

		; now we pop each digit off the stack and print it on the screen using function 02h of int 21h

		scoate:
			pop dx
			; the remainder, that is the digit, is in DL (because it is a number between 0 and 10); DH will be zero
			add dl, '0' ; obtain the character corresponding to the digit
			mov ah, 02
			int 21h
			loop scoate
		ret 	; return from procedure
AfisBaza10 ENDP

	
readNumber PROC
		;enter 1 message
	LEA DX,MSG1
	MOV AH,9
	INT 21H
	
	;read
	mov AH, 0Ah
	mov dx, offset a
	int 21h
	
	;convert a in digits
	mov AH, 0
	mov BL, 0
	mov DL, a[1]
	mov n, DL
	while1:
		CMP BL,  n
		JZ doneReading
		mov AL, a[BX+2]
		sub AL, 30h
		mov a[BX+2], AL
		inc BX
		JMP while1
	doneReading:
	;move in AX the read numberd
	mov BH, 0
	mov BL, a[1]
	mov BP, 0
	mov p, 1
	while2:
		CMP BX, 0
		JZ endRead
		mov AX, 0
		mov AL, a[BX+1]
		mul p
		add BP, AX
		mov AL, p
		mul ten
		mov p, AL
		dec BX
		JMP while2
		
	endRead:
	mov AX, BP
	ret
	
readNumber ENDP

start:

	PUSH data
	POP DS

	;call read
	;call compute
	;call print
	;LEA DX, resMSG	
	;MOV AH,9
	;INT 21H
	
	
	
	;//////////
	
	call readNumber
	
	LEA DX, resMSG	
	MOV AH,9
	INT 21H
	
	mov AX, BP
	call AfisBaza10
	
	
	
	
	
	MOV AX, 4C00h
	INT 21h
	
code ENDS
END start







































