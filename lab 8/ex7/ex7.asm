;7. Write a program which reads the name of a file from the keyboard and then it prints on the screen the even lines from this file.


assume CS:code, DS:data

data segment
	msg1 	DB 	'Name of the file: $'
	newLine DB		10,13,'$'
	path		DB		13,?,14 dup(?)
	buffer 	db 	21 dup (?)
	openErrorMsg db 'The File does not exist.$'
	readErrorMsg db 'Can not read from file.$'
	handler dw 0
	two	db	2
	i			db		0
data ends

code segment
start:

	mov AX, data
	mov DS, AX
	
	mov ah, 09h
  	mov dx, offset msg1
	int 21h 
	
	
	mov ah, 0ah
	mov dx, offset path
	int 21h
	
	mov bl, path[1]
	mov bh, 0
	add bx, offset path
	add bx, 2
	mov byte ptr [bx], 0	
	
	mov ah, 3dh
	mov al, 0 ; open file for reading  
	mov dx, offset path+2
	int 21h	
	
	jc openError ; if CF=1 we have an error opening file
	mov handler, ax
	
	goOn:
		; read maximum 20 characters from the file using function 3fh of interrupt 21h
		mov ah, 3fh
		mov bx, handler		; BX must contain the handle of an open file
		mov dx, offset buffer	; read in buffer
		mov cx, 100 ; we read maxim 20 characters
		int 21h

		jc readError

		; if no error occured the function 3dh returns in ax the number of read bytes
		; save the number of the read bytes and prepare the string for printing on the screen 
		mov si, ax
		mov buffer[si], '$'
		;;;;;;;;
		mov BX, 0
		mov BP, 0
		mov i, 0
		while1:
			CMP BP, SI
			JZ endPrg
			
			mov CL, buffer[BP]
			CMP CL, 10
			JZ isNew
			inc BP
			JMP while1
		
		back:
		mov BX, BP
		inc BX
		inc BP
		JMP while1

	
	
	
	openError:
			; print openErrorMsg on the screen using function 09h of interrupt 21h
			mov ah, 09h
			mov dx, offset openErrorMsg
			int 21h
			jmp endPrg

		readError:
			 ; print readErrorMsg on the screen using function 09h of interrupt 21h
			mov ah, 09h
			mov dx, offset readErrorMsg
			int 21h

	isNew:
		inc i
		mov AL, i
			mov AH, 0
			mov two, 2
			div two
			CMP AH, 0
			JZ print
			JMP back
			
	print:
		; print on the screen what we have read
		while2:
			CMP BX, BP
			JZ back
			mov DL, buffer[BX]
			mov AH, 02h
			int 21h
			inc BX
			JMP while2
			
	endPrg:
			; close the file using function 3eh of interrupt 21h
			mov ah, 3eh
			mov bx, handler
			int 21h
			mov ax,4c00h
			int 21h
	
code ends
end start


