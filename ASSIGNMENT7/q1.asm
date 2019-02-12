section .bss
	two: resd 1
	num2: resd 1
section .data
	format1: db "%lf",0
	format2: db "The perimeter is : %lf",10
	msg1: db "Enter the radius of the circle : "
	len1: equ $-msg1


section .text
	global main
	extern scanf
	extern printf
	
	print:
	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[ebp-8]
	push format2
	call printf
	mov esp, ebp
	pop ebp
	ret

	read:
	push ebp
	mov ebp, esp
	sub esp, 8
	lea eax, [esp]
	push eax
	push format1
	call scanf
	fld qword[ebp-8]
	mov esp, ebp
	pop ebp
	ret

	main:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h


	call read

	fldpi 
	fmul ST1
	mov dword[two],2
	fimul dword[two]

	
	call print

exit:
mov eax, 1
mov ebx, 0
int 80h


