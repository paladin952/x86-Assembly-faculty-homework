;15. Read from the standard input (keyboard) two directory names, dir1 and dir2. Create the new directory dir1\dir2.


assume cs:code, ds:data
data segment
	
	msg		DB	'Enter the name: $'
	dir1		DB	13,?, 14 dup(?)
	dir2		DB	13,?, 14 dup(?)
	res		DB	28 dup (?)
	LinieNoua db 10,13,'$'
data ends
code segment
start:
        mov ax, data
        mov ds, ax
		
		mov ah, 09h
		lea dx, msg
		int 21h
		
		mov ah, 0Ah
		mov dx, offset dir1
		int 21h
		
		mov ah, 09h
		lea dx, LinieNoua
		int 21h
		
		mov ah, 09h
		lea dx, msg
		int 21h
		
		mov ah, 0Ah
		mov dx, offset dir2
		int 21h
		
		mov ah, 09h
		lea dx, LinieNoua
		int 21h
		
		;concat the 2 registers
		mov BL, 0
		mov BH, 0
		while1:
			CMP BL, dir1[1]
			JZ endWhile1
			mov AL, dir1[BX+2]
			mov res[BX], AL
			inc BX
			JMP while1
			
		endWhile1:
			mov res[BX], "\"
			inc BX
			mov CL, dir2[1]
			add CL, dir1[1]
			inc CL
			mov BP, 0
		while2:
			CMP BL, CL
			JZ endWhile2
			mov AL, dir2[BP+2]
			mov res[BX], AL
			inc bx
			inc bp
			JMP while2
		
		endWhile2:
		mov res[BX], 0
		mov BL, dir1[1]
		mov BH, 0
		add BX, offset dir1
		add BX, 2
		mov BYTE PTR [BX], 0
		
		mov ah, 39h
		mov dx, offset dir1+2
		int 21h
		
		;creater dir1
		mov ah, 39h
		mov dx, offset res
		int 21h
		
		
	
		
	mov ax, 4c00h
	int 21h
code ends
end start
