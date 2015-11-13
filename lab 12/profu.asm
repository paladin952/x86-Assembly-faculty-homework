;show how many minutes are until the end of the day


ASSUME CS:code, DS:data

data SEGMENT public
	
	minutes		DW	?
	sixty			Db	60
	maxim		DW	1440
	zece			DW	10
	
data ENDS

;extrn readNumber: proc
extrn compute: proc

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


start:

	PUSH data
	POP DS
	
	mov AH, 2Ch
	int 21h
	
	mov AH, 0
	mov AL, CH
	mul sixty
	
	mov CH, 0
	add AX, CX
	
	sub maxim, AX
	
	mov AX, maxim
	
	call AfisBaza10
	
	
	
	
	
	MOV AX, 4C00h
	INT 21h
	
code ENDS
END start
