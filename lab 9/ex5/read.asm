assume cs:code, ds: data


data segment public
	MSG1 DB 10,13,"ENTER THE NUMBER: $"
	
	a			DB	6,?,9 dup(0)
	n			DB	?
	p			DB	1
	ten		DB	10
data ends


public readNumber
code segment public

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
	
code ends
end