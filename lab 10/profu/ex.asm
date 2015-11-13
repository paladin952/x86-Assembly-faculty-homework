;1. Read a number from keyboard, in hexadecimal format. 
;Validate that it is between 0 and 0xFFFF (it should be represented 
;on a word). If it's not, display a message and read the number again. 
;Open a file named "in.txt", which should contain exactly 16 bytes. Read them, 
;and then print on the screen only those characters whose corresponding bit index 
;in the number read from the keyboard is set.

assume CS:code, DS:data

data segment
	
	msg 			DB 'Name of the file: $'
	msg2		DB 'The number: $'
	number 	db 15,?,16 dup (?)
	error 		DB	"Invalid input!&"
	num			DW	?
	wrongIO		DB	"wrong input"
	handler dw 0
	
	
data ends

code segment
start:
	mov AX, data
	mov DS, AX
	
	mov ah, 09h		; put the name of the function in AH
	mov dx, offset msg2	; in DS:DX there must be a pointer to the message that will be written on the screen 
			; (this string must end with '$')
	int 21h		
	
	; read from standard input the number of the file using function 0ah, int 21h
	mov ah, 0ah
	mov dx, offset number
	int 21h
	; after reading, the name of the file will be stored at the address fileName+2 
	; at the address fileName + 1 the length (in bytes) of the filename will be stored by the IHR (Interrupt Handling Routine)
	
	 ; transform the filename in an ASCIIZ string
        mov bl, number[1]
        mov bh, 0
        add bx, offset number
        add bx, 2
		
	;validate
		mov 
		CMP number[1], 15
		
		
		mov AH, 02h
		mov DL, number[3]
		int 21h
		
        
	

	wrong:
		mov ah, 09h		
		mov dx, offset wrongIO
		int 21h
		JMP start
	
	
	endProg:
		mov AX, 4c00h
		int 21h
code ends
end start


