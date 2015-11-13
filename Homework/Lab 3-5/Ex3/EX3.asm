; (h+h+d)-(yy+m)

assume CS:code, DS:data
data segment
	
	x dw y - z
	y dd near ptr x
	z dw 128
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	mov ax,word ptr x+1
	not ah
	neg al
	mov bx, word ptr x+2
	xchg bh,bl
	neg bx
	cbw
	xor ax,bx
	xor bx,ax
	sub ax,bx
	les di,y+1
	inc di
	push ds
	pop es
	mov ch,es:[di]
	inc di
	mov dx,es:[di]

	
	
	mov AX, 4c00h
	int 21h
code ends
end start