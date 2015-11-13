;1. (yy+h+m)-(d+d)

assume CS:code, DS: data
data segment
	m 	DB 	10
	h 	DB 	15
	yy	DB	2
	d 	DB	2
	res	DB	?
data ends
code segment
start:
	mov AX,	data
	mov	DS, AX

	mov AL, yy
	add AL, h
	
	mov BL, m
	add AL, BL

	
	mov BL, d
	add BL, d

	
	sub AL, BL
	mov res, AL

	mov AX, 4c00h
	int 21h
code ends
end start


