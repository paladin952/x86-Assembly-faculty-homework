
;15. Se dau cuvintele A si B. Se cere cuvantul C:
;- bitii 0-2 ai lui C au valoarea 0
;- bitii 3-5 ai lui C au valoarea 1
;- bitii 6-9 ai lui C coincid cu bitii 11-14 ai lui A
;- bitii 10-15 ai lui C coincid cu bitii 1-6 ai lui B

assume cs:code, ds:data
data segment
    a dw 0110101101001011b
    b dw 0110101001010101b
    c dw ?
data ends
 ; c should be like 00 111 0010 011010
code segment
start:
	 mov ax, data ; incarcam adresa segmentului de date in resgistrul ds
	 mov ds, ax
	 
	 mov bx, 0
	 ;facem biti 3-5 sa aiba val 1
	 or bx, 0000000000111000b
	 
	 mov ax, a
	 ;izolam biti 11-14 ai lui a
	 and ax, 0111100000000000b
	 mov cl, 5
	 shr ax, cl ; mutam 5 poz spre dreapta
	 or bx, ax ; punem bitii in rezultat
	 
	 ;izoam bitii 1-6 ai lui b
	 mov ax, b
	 and ax, 0000000001111110b
	 mov cl, 9
	 shl ax, cl
	 
	 ;rezultatul
	 or bx, ax
	 mov c, bx
	 
	 mov ax, 4c00h ; terminam programul
	 int 21h
code ends
end start