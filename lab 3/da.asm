assume cs:code, ds:data
data segment
	m db 2
	h db 173
	yy db 95
	d db 10
data ends
code segment
start:
	mov ax, data
	mov ds, ax
	; (yy+h+m)-(d+d)
	mov AL,yy
	add AL,h
	add AL,m
	mov AH,d
	add AH,d
	sub AL,Ah
	
	mov ax, 4c00h
	int 21h
code ends
end start