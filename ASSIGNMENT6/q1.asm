section .data
	msg1: db 'Enter the 10 numbers: '
	l1: equ $-msg1
	msg2: db 'The sum of squares of 10 numbers : '
	l2: equ $-msg2
	el: db 0Ah
	le: equ $-el
	space: db ' '
	l: equ $-space
	hi: db 'hi'
        hil: equ $-hi

section .bss
	i: resw 1
	array: resw 100
	num: resw 1
        temp: resw 1
	nod: resw 1
	dig: resw 1
	sum: resw 1
	


section .text
	global _start:
	_start:
	
	mov word[nod],0

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

	
        
       



;STARTING WITH ACCEPTING ARRAY

        


	mov ebx,array
	mov word[i],10
 
	reading:     
        call read_num
        mov ax,word[num]
	mov word[ebx],ax
	add ebx,2
        dec word[i]
        cmp word[i],0
	jg reading
        

;ACCEPTING 10 NUMBERS DONE
        
	call sum_of_square

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h
	
	
	mov ax,word[sum]
	mov word[num],ax
	call print_num
	call print_endline
	exit:
        mov eax,1
	mov ebx,0
	int 80h



read_num:

pusha
mov word[num],0
loop2:

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
        jmp loop2

end_loop: 
popa
ret







print_num:
pusha
cmp word[num],0
je printzero
loop3:
	cmp word[num], 0
	je print_no
	inc word[nod]
	mov dx,0
	mov ax, word[num]
	mov bx, 10
	div bx
	push dx
	mov word[num], ax
	jmp loop3

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

print_endline:
pusha
mov eax,4
mov ebx,1
mov ecx,el
mov edx,le
int 80h
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


sum_of_square:
pusha
	mov word[sum],0
	mov ebx,array
	mov word[i],10

	sumloop:
	mov ax,word[ebx]
	mov word[num],ax
	call square_num
	mov ax,word[num]
	add word[sum],ax

	dec word[i]
	add ebx,2
	cmp word[i],0
	ja sumloop

popa
ret


square_num:
pusha
	mov dx,0
	mov ax,word[num]
	mov bx,word[num]
	mul bx
mov word[num],ax
popa
ret

