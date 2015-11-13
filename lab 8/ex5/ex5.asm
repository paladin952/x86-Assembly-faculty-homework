;13. Read from standard input (keyboard) the name of a file and the name of a directory. Print a suitable message if that file exists or does not exist in the specified directory.


assume cs:code, ds:data
data segment
	LinieNoua 	db 	10,13,'$'
	twelve		db		12
	zece			dw	10
	am1			db		" AM$"
	pm1			db		" PM$"
	minutes		db		?
data ends
code segment

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

start:
        mov ax, data
        mov ds, ax
		
		mov ah, 2Ch
		int 21h
		
		mov ah, 0
		mov al, ch
		mov minutes, cl
		
		div twelve
		CMP al, 0
		JNZ PM
		mov al, ah
		mov ah, 0
		
		call AfisBaza10
		mov ah, 02h
		mov dl, ':'
		int 21h
		
		mov AL, minutes
		mov AH, 0
		call AfisBaza10
		
		mov ah, 09h
		lea dx, am1
		int 21h
		JMP endProg
		PM:
		mov al, ah
		mov ah, 0
		
		call AfisBaza10
		mov ah, 02h
		mov dl, ':'
		int 21h
		mov AL, minutes
		mov AH, 0
		call AfisBaza10
		
		mov ah, 09h
		lea dx, pm1
		int 21h
		
	endProg:
		
	mov ax, 4c00h
	int 21h
code ends
end start
