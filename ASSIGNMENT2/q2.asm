section .data
	msg1: db 'Enter the size of the array: '
	l1: equ $-msg1
	
	msg2: db 'Enter the element: '
	l2: equ $-msg2

	msg3: db 'No of odd elements: '
	l3: equ $-msg3

	msg4: db 'No of even elements: '
	l4: equ $-msg4

	el: db 0Ah
	le: equ $-el

	

section .bss
        e:resw 1
	o:resw 1
	n: resw 1
	t: resw 1
	ele: resw 1
	array: resw 100
	dig: resw 1
	nod: resw 1
	num: resw 1
        temp: resw 1


section .text
	global _start:
	_start:

        mov word[o],0
        mov word[e],0

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

        call read_num
	mov ax,word[num]

	mov word[n],ax
	mov word[t],ax
	mov word[temp],0

;ACCEPTING OF SIZE OF ARRAY DONE



;STARTING WITH ACCEPTING ARRAY


	mov ebx,array
	
reading:

        push ebx

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h

	
         call read_num
	mov ax,word[num]
 
        pop ebx
	mov word[ebx],ax
	add ebx,2
        dec word[n]
        cmp word[n],0
	jg reading
        

;ACCEPTING ARRAY DONE


	mov ebx,array

	loop1:
        mov dx,0
	mov ax,word[ebx]
	mov word[ele],ax
	mov cx,2
	div cx
	cmp dx,0
	jne else
         
        add word[e],1
        
	add ebx,2
	add word[temp],1
        mov ax,word[temp]
	cmp ax,word[t]
	jb loop1
        jmp print
        
        else:
	add word[o],1

	add ebx,2
	add word[temp],1
        mov ax,word[temp]
	cmp ax,word[t]
	jb loop1
        print:
	mov eax,4
	mov ebx,1
	mov ecx,msg3
        mov edx,l3
	int 80h
        
	mov ax,word[o]
        mov word[num],ax

        call print_num

	mov eax,4
	mov ebx,1
	mov ecx,el
        mov edx,le
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,msg4
        mov edx,l4
	int 80h


	mov ax,word[e]
        mov word[num],ax
        call print_num

	mov eax,4
	mov ebx,1
	mov ecx,el
        mov edx,le
	int 80h

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
     
        cmp byte[dig],10  ;10 ASCII for new line
	je end_loop
	sub word[dig],30h
        
	mov ax,word[num]
        mov bl,10
        mul bl
        add ax,word[dig]
        mov word[num],ax
        jmp loop2

end_loop: 
popa
ret







print_num:
pusha
loop3:
	cmp word[num], 0
	je print_no
	inc word[nod]
	mov dx, 0
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
