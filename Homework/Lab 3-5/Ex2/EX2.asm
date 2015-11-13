;(yy+h)-m-(d+d)

assume CS:code, DS:data
data segment
	m	DB	50
	h	DB	100
	yy	DB  250
	d 	DB	1
	res	DW	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX

	mov AL, yy
	add AL, h
	mov AH, 0
	adc AH, 0

	mov BL, m
	mov BH, 0
	sub AX, BX

	mov BL,	d
	add BL,	d
	mov	BH,	0

	sub AX, BX
	mov res, AX
	mov AX, 4c00h
	int 21h
code ends
end start