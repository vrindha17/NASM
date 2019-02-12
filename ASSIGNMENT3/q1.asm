section .data
	msg1: db 'Enter the size of the array: '
	l1: equ $-msg1
	msg2: db 'Enter the element: '
	l2: equ $-msg2
	el: db 0Ah
	le: equ $-el
	space: db ' '
	l: equ $-space
	hi: db 'hi'
        hil: equ $-hi

section .bss
	i: resw 1
	j: resw 1
	n: resw 1
	t: resw 1
	left: resw 1
	right: resw 1
	ele: resw 1
	array: resw 100
	num: resw 1
        temp: resw 1
        temp2: resw 1
	x: resw 1
	nod: resw 1
	dig: resw 1
	n2:resw 1


section .text
	global _start:
	_start:
	
	mov word[nod],0

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

	
        
        call read_num
        mov ax,word[num]

	mov word[n],ax
	mov word[t],ax
        mov word[x],ax

	mov word[temp],0
	mov ax,word[n]
	mov bx,word[t]
	mul bx
	mov word[n2],ax   ;n2 has total no of elements . t has no of rows or columns 

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
        dec word[n2]
        cmp word[n2],0
	jg reading
        

;ACCEPTING ARRAY DONE
        
        sub word[x],1		;x=n-1
	mov ebx,array
        mov word[i],0
       
	iloop:
                                ;starting with index n-i-1
        mov ax,word[x]
        mov word[t],ax
	mov ebx,array
        mov ax,word[i]
        sub word[t],ax		;t=n-i-1
	mov cx,word[n]
        mul cx	                ;ax=i*n
        movzx eax,ax
        movzx ecx,word[t]
        add ecx,eax
       	mov dx,word[ebx+2*ecx]
        mov word[right],dx      ;ebx+2*ecx will give the [i][n-i-1]
        
        
;a[i][n-i-1] got in variable right
        

;starting with a[i][i]
        push ecx
        mov ax,word[i]
        mov cx,word[n]
        mul cx	
	pop ecx		
        movzx eax,ax	;now eax has i*n
	movzx edx,word[i]
	add edx,eax
        mov ax,word[ebx+2*edx]  
        mov word[left],ax      ;ebx+2*edx will give the [i][i]
        	
	
	mov word[ebx+2*ecx],ax
      	mov ax,word[right]
        mov word[ebx+2*edx],ax 	


        iloopupdation:
	add word[i],1
        mov ax,word[n]
        cmp word[i],ax
	jb iloop

;starting with printing matrix
	
        mov ax,word[n]
	mov bx,word[n]
	mul bx
	mov word[n2],ax

	mov ebx,array

	loop1:
	
        mov ax,word[ebx]
	mov word[num],ax

	push ebx
	call print_num
	mov eax,4
	mov ebx,1
	mov ecx,space
	mov edx,l
        int 80h

	pop ebx

	loopupdation:
	add ebx,2
	sub word[n2],1

        push ebx
        mov dx,0
        mov ax,word[n2]
        mov bx,word[n]
        div bx
        cmp dx,0
        je endline
        continue:               
	cmp word[n2],0
        pop ebx
	ja loop1

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
        cmp byte[dig],40
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
cmp word[num],0
je printzero
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

endline:

mov eax,4
mov ebx,1
mov ecx,el
mov edx,le
int 80h
 jmp continue
        

printzero:
add word[num],30h
mov eax,4
mov ebx,1
mov ecx,num
mov edx,1
int 80h
jmp end_print	







