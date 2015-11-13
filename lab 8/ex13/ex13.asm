;13. Read from standard input (keyboard) the name of a file and the name of a directory. Print a suitable message if that file exists or does not exist in the specified directory.


assume cs:code, ds:data
data segment
	msg1			DB	"Enter the name of the file: $"
	msg2			DB "Enter the name of the directory: $"
	msg3			DB	"The file exists$"
	msg4			DB	"The file does not exists$"
	input			DB	13,?,14 dup(?)
	path			DB	28 dup (?)
	dir				DB 13,?,14 dup(?)
	LinieNoua 	db 10,13,'$'
data ends
code segment
start:
        mov ax, data
        mov ds, ax
		
		mov ah, 09h
		lea dx, msg1
		int 21h
		
		mov ah, 0Ah
		mov dx, offset input
		int 21h
		
		mov ah, 09h
		lea dx, LinieNoua
		int 21h
		
		mov ah, 09h
		lea dx, msg2
		int 21h
		
		mov ah, 0Ah
		mov dx, offset dir
		int 21h
		
		mov ah, 09h
		lea dx, LinieNoua
		int 21h
		
		;create filepath
		mov BX, 0
		while1:
			CMP BL, dir[1]
			JZ endwhile1
			mov CL, dir[BX+2]
			mov path[BX], CL
			inc BX
			JMP while1
			
		
		endWhile1:
		mov path[BX], "\"
		inc BX
		mov CL, input[1]
		add CL, dir[1]
		inc CL
		mov BP ,0
		while2:
			CMP BL, CL
			JZ endWhile2
			mov AL, input[BP+2]
			mov path[BX], AL
			inc BX
			inc BP
			JMP while2
		
		endWhile2:
			mov path[BX], 0
			
			mov AH, 3Dh
			mov al, 0
			mov DX, offset path
			int 21h
			
		JC notFound
		JMP found
		notFound:
			mov ah, 09h
			lea dx, msg4
			int 21h
			JMP endProg
		found: 
		mov ah, 09h
		lea dx, msg3
		int 21h
		JMP endProg
		
		
	endProg:
		
		
	mov ax, 4c00h
	int 21h
code ends
end start
