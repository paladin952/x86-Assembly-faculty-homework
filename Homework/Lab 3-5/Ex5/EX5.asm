
;5. (yy+h+h)-(yy+m+d)

assume CS:code, DS:data
data segment
	m	DW	50
	h	DW	100
	yy	DB	1
	d	DW	-2
	res	DW	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	mov AL, yy
	mov AH, 0
	add AX, h
	add AX, h
	
	mov	BL, yy
	mov BH, 0
	add BX, m
	add BX, d
	
	sub AX, BX
	mov res, AX
	
	mov AX, 4c00h
	int 21h
code ends
end start
	
	