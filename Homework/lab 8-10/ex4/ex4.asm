;4) Print the current date on the screen and also the current day of the week (using letters, not numbers).

assume CS:code, DS:data

data segment
		
	
	months 			DB	"JanuaryFebruaryMarchAprilMayJuneJulyAugustSeptemberOctoberNovemberDecember"
	monthsOffsets	DB	0,76,15,20,25,28,32,36,42,51,58,66,73
	days					DB	"MondayTuesdayWednesdayThursdayFridaySaturdaySunday"
	daysOffset			DB	0,6,13,22,30,36,44,50
	zece 				DW 10
	dayWeek			DB	?
	day					DB	?
	month				DB	?
	year					DW	?
	
data ends

code segment
		AfisBaza10 PROC
			; define a procedure which prints the value of the AX register, in base 10, on the screen
			cmp ax, 0
			jge pozitiv 
			; else, if the number is negative print the character '-' using function 02h a int 21h
			push ax
			mov ah, 02h
			mov dl, '-'
			int 21h
			pop ax
			neg ax ; ax:= -ax

			pozitiv:
			; in order to avoid overflows, we will always divide DX:AX to 10 (not just AX). We
			; keep dividing to 10 and store the remainders (the digits) on the stack. When we will
			; pop the digits off the stack they will be in the reverse order which is the correct order

			mov cx, 0 ; cx will hold the number of digits placed on the stack
			repeta:
				mov dx, 0
				div zece
				push dx
				inc cx
				cmp ax, 0
				ja repeta ; if quotient>0 jmp repeta 

			; now we pop each digit off the stack and print it on the screen using function 02h of int 21h

			scoate:
				pop dx
				; the remainder, that is the digit, is in DL (because it is a number between 0 and 10); DH will be zero
				add dl, '0' ; obtain the character corresponding to the digit
				mov ah, 02
				int 21h
				loop scoate
			ret 	; return from procedure
AfisBaza10 ENDP
	
	printSpace PROC
		mov AH, 02
		mov DL, 32
		int 21h
	ret
printSpace ENDP

	
	start:
		mov AX, data
		mov DS, AX
		
		
		
		mov AH, 2Ah
		int 21h
		mov day, DL
		mov month, DH
		mov dayWeek, AL
		mov year, CX
		
		;day of the week
		mov AH, 0
		CMP AL, 1
		JZ mon
		CMP AL, 2
		JZ tue
		CMP AL, 3
		JZ wed
		;JMP to second check because jump is out of range
		JMP secondCheck
	
		mon:
			mov BH, 0
			mov BL, daysOffset[0]
			do1:
				CMP BL, daysOffset[1]
				JZ back1
				mov AH, 02h
				mov DL, days[BX]
				int 21h
				inc BX
				JMP do1
		tue:
			mov BH, 0
			mov BL, daysOffset[1]
			do2:
				CMP BL, daysOffset[2]
				JZ back1
				mov AH, 02h
				mov DL, days[BX]
				int 21h
				inc BX
				JMP do2
		wed:
			mov BH, 0
			mov BL, daysOffset[2]
			do3:
				CMP BL, daysOffset[3]
				JZ back
				mov AH, 02h
				mov DL, days[BX]
				int 21h
				inc BX
				JMP do3
				
				
		secondCheck:
			CMP AL, 4
			JZ thu
			CMP AL, 5
			JZ  fri
			CMP AL, 6
			JZ sat
			CMP AH, 0
			JZ sun
			
		back1:
			JMP back
		thu:
			mov BH, 0
			mov BL, daysOffset[3]
			do4:
				CMP BL, daysOffset[4]
				JZ back
				mov AH, 02h
				mov DL, days[BX]
				int 21h
				inc BX
				JMP do4
		fri:
			mov BH, 0
			mov BL, daysOffset[4]
			do5:
				CMP BL, daysOffset[5]
				JZ back
				mov AH, 02h
				mov DL, days[BX]
				int 21h
				inc BX
				JMP do5
		sat:
			mov BH, 0
			mov BL, daysOffset[5]
			do6:
				CMP BL, daysOffset[6]
				JZ back
				mov AH, 02h
				mov DL, days[BX]
				int 21h
				inc BX
				JMP do6
		sun:
			mov BH, 0
			mov BL, daysOffset[6]
			do7:
				CMP BL, daysOffset[7]
				JZ back
				mov AH, 02h
				mov DL, days[BX]
				int 21h
				inc BX
				JMP do7
				
	back:
		call printSpace
		;print day
		mov AH, 0
		mov AL, day
		call AfisBaza10
		call printSpace
		
		;print month
		mov AH, 0
		mov AL, month
		call AfisBaza10
		call printSpace
		
		;print year
		mov AX, year
		call AfisBaza10

	endProg:
		mov AX, 4c00h
		int 21h
code ends
end start


