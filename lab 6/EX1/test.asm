;1. Two byte strings S1 and S2 are given. Obtain the string D by concatenating the elements of S1 from the left hand side to the right hand side and the elements of S2 from the right hand side to the left hand side.
;Exemple:
;S1: 1, 2, 3, 4
;S2: 5, 6, 7
;D: 1, 2, 3, 4, 7, 6, 5

assume CS:code, DS:data
data segment

	a	DD	1

data ends
code segment
start:
	mov AX, data
	mov DS, AX
	
	
	
	mov AX, word PTR a
		
	
	mov AX, 4c00h
	int 21h
code ends
end start
	