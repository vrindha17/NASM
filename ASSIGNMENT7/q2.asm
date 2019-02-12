section .bss
	a: resq 1
	b: resq 1
	c: resq 1
x: resq 1
	root1: resq 1
	root2: resq 1
	ac4: resq 1
	temp: resw 1
section .data

	msg1: db "Enter the values of a,b and c: "
	len1: equ $-msg1
	msg2: db "The roots are : ",0Ah
	len2: equ $-msg2
	format1: db "%lf",0
	format2: db "%lf",10



section .text
	global main
	extern scanf
	extern printf
	

	main:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h


	call read	;the value will be stored in st0
	fstp qword[a]

	call read	
	fstp qword[b]
	
	call read	
	fstp qword[c]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;accepting done
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h

	
	fld qword[b]
	fchs
	fst qword[b]    ;;;;b is made to -b and st0 contains -b
	
	fmul st0        ;;;;now st0 contains b^2
	fld qword[a]    ;;;;now st1 contains b^2 and st0 contains a
	fmul qword[c]  ;;;st0 contains ac
	
	mov dword[temp],4
	fimul dword[temp]  ;now st0 contains 4ac and st1 contains b^2

	fsubr ST1          ;now st0 contains b^2-4ac
	fsqrt              ;st0=root(b^2-4ac) =x  
	
	fst qword[x]        
	fld qword[b]
	fadd st1          ;st0=-b+root(b^2-4ac)         
  
	mov dword[temp],2
	
	fld qword[a]
	fimul dword[temp]
	fdivr st1	
	
	call print
	fstp qword[root1]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;calculating root1 over

	fld qword[x]
	fld qword[b]
	fsub st1
	mov dword[temp],2
	fld qword[a]
	fimul dword[temp]

	fdivr st1	
	
	call print

	exit:
	mov eax, 1
	mov ebx, 0
	int 80h

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


