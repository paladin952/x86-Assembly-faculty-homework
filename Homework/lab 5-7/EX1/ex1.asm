;1. Se dau cuvintele A si B. Sa se obtina cuvantul C:
;- bitii 0-4 ai lui C coincid cu bitii 11-15 ai lui A
;- bitii 5-11 ai lui C au valoarea 1
;- bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B


assume CS:code, DS:data
data segment
	A	DW	0010111010110110b
	B	DW	0010111010101010b
	C	DW	?
data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	;5-11 have value 1
	mov C, 0000111111100000b
	
	;mov 0-4 = 11-15A
	mov AX, A
	AND AX, 1111100000000000b
	mov CL, 11
	SHR AX, CL
	OR C, AX
	;mov 12-15 = 8-11B
	mov AX, B
	AND AX, 000011110000000b
	mov CL, 4
	SHL AX, CL
	OR C, AX

	mov AX, 4c00h
	int 21h

code ends
end start