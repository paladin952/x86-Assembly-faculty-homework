assume cs:code, ds: data

data segment public
	
data ends

public compute
code segment public
compute proc
	
	add DX, CX ;a+b
	sub DX, AX; a+b-c
	XCHG DX, AX
	ret
	
compute ENDP 
code ends
end
