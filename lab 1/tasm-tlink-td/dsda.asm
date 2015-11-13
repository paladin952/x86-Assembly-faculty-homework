assume cs:code, ds:data
data segment
a dd 125
b db 2
c dw 15
d db 200
data ends
code segment
start:
mov ax, data
mov ds, ax

;for computing b/c, we convert b from byte to doubleword, so that we can divide it by the word c
mov al, b
mov ah, 0	;unsigned conversion from al to ax
mov dx, 0	;unsigned conversion from ax to dx:ax
;dx:ax = b
div c	 ;unsigned division dx:ax by c
;ax=b/c	;the quotient of the division is in ax (the remainder is in dx, but we only use the quotient in the further computations)

mov bx, ax	;we save b/c in bx so that we can use ax for multiplying d and 2
mov al, 2
mul d	 ;ax=d*2

sub bx, ax	;bx=b/c-d*2
; we convert the word bx to doubleword so that we can add it with the doubleword a
mov cx, 0	; unsigned conversion from bx to cx:bx
;cx:bx=b/c-d*2

mov ax, word ptr a
mov dx, word ptr a+2	;dx:ax=a

add ax, bx
adc dx, cx	;the final results is in dx:ax

mov ax, 4C00h
int 21h
code ends
end start