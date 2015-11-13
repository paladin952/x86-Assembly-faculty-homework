
;  (h+h)-yy-(m+d)


assume CS:code, DS:data
data segment
	h	DW	100
	yy	DB	60
	m	DW	2
	d	DB	-2
	res	DW	?
data ends
code segment
start:
	mov AX,data
	mov DS,AX
	
	mov AX, h
	mov BX, h
	add AX, BX ; AX = h + h
	
	mov DL, yy	
	mov DH, 0	; converting to word, unsigned
	
	sub AX, DX ; h + h - yy
	
	
	mov BX, AX	; BX = h+h-yy
	mov AL, d
	mov AH, 0
	
	add AX, m ; -d + m
	sub BX, AX
	
	mov res, BX
	
	mov AX, 4c00h
	int 21h
code ends
end start
	
	
	