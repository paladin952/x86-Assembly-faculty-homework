;5. Read the numbers a, b and c and compute and print on the screen a+b-c.


ASSUME CS:code, DS:data

data SEGMENT public
	resMSG	DB 10,13,"YOUR RESULT IS: $"
	MSG1 DB 10,13,"ENTER THE NUMBER: $"
	first		DW	?
	second	DW ?
	zece	DW 10
	a			DB	6,?,9 dup(0)
	n			DB	?
	p			DB	1
	ten		DB	10
data ENDS

;extrn readNumber: proc
extrn compute: proc
extrn AfisBaza10: proc

code SEGMENT PUBLIC




start:

	PUSH data
	POP DS

	call readNumber
	mov first, AX
	call readNumber
	mov second, AX
	call readNumber
	mov DX, first
	mov Cx, second
	call compute
	mov CX, AX
	
	LEA DX, resMSG
	mov AH, 9
	int 21h
	
	mov AX, CX
	
	call AfisBaza10
	
	MOV AX, 4C00h
	INT 21h
	
code ENDS
END start
