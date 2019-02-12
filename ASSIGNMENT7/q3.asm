section .bss
	array: resq 50
	i: resw 1
	j: resw 1
	x: resq 1
	temp: resw 1
	num: resw 1
	nod: resw 1
	dig: resw 1
	n: resw 1
ascii: resw 1

section .data
	hi: db "hi",0Ah
	hl: equ $-hi
	msg1: db "Enter the size of the array : "
	len1: equ $-msg1
	msg2: db "Enter the numbers of the array : "
	len2: equ $-msg2
	msg3: db "Enter the numbers of the array : "
	len3: equ $-msg3
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
	
	call read_num
	mov ax,word[num]
	mov word[n],ax


	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h
	
	mov ebx,array
	mov word[i],0
	loop1:
	call read_float
	fstp qword[ebx]
	add ebx,8
	inc word[i]
	mov ax,word[n]
	cmp word[i],ax
	jb loop1
;;;;;;;;;;;;;;;;;;;;;;ACCEPTING SIZE AND ELEMENTS DONE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
dec word[n]
	

	mov word[i],0
	iloop:
	mov word[j],0
		jloop:
		mov ebx,array
		movzx ecx,word[j]
		fld qword[ebx+8*ecx]

		
		fld qword[ebx+8*ecx+8]


		fcomi st1
		ja jupdate
		else:
		movzx ecx,word[j]
		fstp qword[ebx+8*ecx]
		fstp qword[ebx+8*ecx+8]
		ffree st0
		ffree st1
		
		jupdate:
		
		ffree st0
		ffree st1
		
		inc word[j]
		mov ax,word[n]
		cmp word[j],ax
		jb jloop
	
		
	iupdate:
	inc word[i]
	mov ax,word[n]
	cmp word[i],ax
	jb iloop
	
	
		




inc word[n]
	mov ebx,array
	mov word[i],0
	loop3:
	fld qword[ebx]

pusha
	call print_float
popa
	inc word[i]
	mov ax,word[n]
	add ebx,8
	cmp word[i],ax
	jb loop3
	
	
	
	exit:
	mov eax, 1
	mov ebx, 0
	int 80h



	print_float:
	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[ebp-8]
	push format2
	call printf
	mov esp, ebp
	pop ebp
	ret

	read_float:
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


	read_num:
	pusha
	mov word[num],0
	read_num_loop:
	mov eax,3
	mov ebx,0
	mov ecx,dig
	mov edx,1
	int 80h
   
        cmp word[dig],10  ;10 ASCII for new line
	je end_loop
        cmp word[dig],32
        je end_loop
	sub word[dig],30h
        mov dx,0
	mov ax,word[num]
        mov bx,10
        mul bx
        add ax,word[dig]
        mov word[num],ax
        jmp read_num_loop

	end_loop: 
	popa
	ret

	print_num:
	pusha
	cmp word[num],0
	je printzero
	print_num_loop:
	cmp word[num], 0
	je print_no
	inc word[nod]
	mov dx,0
	mov ax, word[num]
	mov bx, 10
	div bx
	push dx
	mov word[num], ax
	jmp print_num_loop

	print_no:
	cmp word[nod], 0
	je end_print
	dec word[nod]
	pop dx
	mov word[dig], dx
	add word[dig], 30h

	mov eax,4
	mov ebx,1
	mov ecx,dig
	mov edx,1
	int 80h

	jmp print_no
	end_print:
	popa
	ret

        

	printzero:
	add word[num],30h
	mov eax,4
	mov ebx,1
	mov ecx,num
	mov edx,1
	int 80h
	jmp end_print	

print_hi:
pusha

	mov eax,4
	mov ebx,1
	mov ecx,hi
	mov edx,hl
	int 80h
popa
ret
