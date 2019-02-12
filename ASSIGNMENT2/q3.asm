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

        hi: db 'hi',0Ah
        l: equ $-hi

	

section .bss
        i: resw 1
	j: resw 1
	k: resw 1
	t: resw 1
	n: resw 1
	s: resw 1
	b: resw 1
	a: resw 1
	array: resw 100
	nod: resw 1
	dig: resw 1
	num: resw 1
        temp: resw 1


section .text
	global _start:
	_start:

        
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h
call read_num
mov ax,word[num]
	mov word[n],ax
	mov word[t],ax
	mov word[s],ax

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
        dec word[t]
        cmp word[t],0
	jg reading
        

;ACCEPTING ARRAY DONE

sub word[n],1
	
mov word[i],0

loop1:
	mov ebx,array	
	mov word[j],0

	loop2:
		mov ax,word[ebx]
	        mov word[a],ax
		add ebx,2
                mov cx,word[ebx]
		mov word[b],cx


		cmp ax,cx
		jb swap

		
		
		inc word[j]
		mov cx,word[j]
		cmp cx,word[n]
		jb loop2
	        jmp continue
		swap:
		
		
		mov ax,word[a]
		mov cx,word[b]
                 
		mov word[ebx],ax
		sub ebx,2
		mov word[ebx],cx
		
	        continue:
		add ebx,2
		inc word[j]
		mov cx,word[j]
		cmp cx,word[n]
		jb loop2




inc word[i]
mov ax,word[i]
cmp ax,word[n]
jbe loop1

mov word[i],0
mov ebx,array
printing:
        push ebx
	mov ax,word[ebx]
        mov word[num],ax
        call print_num

	mov eax,4
	mov ebx,1
	mov ecx,el
	mov edx,le
	int 80h
	
pop ebx
add ebx,2
inc word[i]
mov ax,word[n]
cmp word[i],ax
jbe printing





        exit:
	mov eax,1
	mov ebx,0
	int 80h




read_num:

pusha
mov word[num],0
loopa:


        

	mov eax,3
	mov ebx,0
	mov ecx,dig
	mov edx,1
	int 80h
     
        cmp word[dig],10  ;10 ASCII for new line
	je end_loop
	sub word[dig],30h
        
	mov ax,word[num]
        mov bl,10
        mul bl
        add ax,word[dig]
        mov word[num],ax
        jmp loopa

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

 
        
	




