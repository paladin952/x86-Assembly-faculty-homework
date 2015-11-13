assume CS:code, DS:data

data segment
	a DW ?
	b DW ?
data ends
	
code segment
start:
	mov AX, data
	mov DS, AX
	mov AX, 10
	mov BX, 2
	
	xor AX, BX
	xor BX, AX
	xor AX, BX
	
	mov a, AX
	mov b, BX
	

	mov AX, 4c00h
	int 21h


code ends
end start