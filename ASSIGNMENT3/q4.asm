section .data
	msg1: db 'Enter the value of m: '
	l1: equ $-msg1
	msg2: db 'Enter the value of n: '
	l2: equ $-msg2
	msg3: db 'Enter the element: '
	l3: equ $-msg3
	el: db 0Ah
	le: equ $-el
	space: db ' '
	l: equ $-space
	hi: db 'hi'
        hil: equ $-hi

section .bss
	i: resw 1
	j: resw 1
        m: resw 1
	n: resw 1
	t: resw 1
	array: resw 100
        num: resw 1
        temp: resw 1
	x: resw 1
	nod: resw 1
	dig: resw 1
	n2:resw 1
	k: resw 1


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

	mov word[m],ax
;ACCEPTING M DONE


	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h
        
        call read_num
        mov ax,word[num]

	mov word[n],ax
        mov word[x],ax
;ACCEPTING N DONE

	
	mov ax,word[n]
	mov bx,word[m]
	mul bx
	mov word[n2],ax   ;n2 has total no of elements 
        mov word[temp],ax

;ACCEPTING OF SIZE OF ARRAY DONE




;STARTING WITH ACCEPTING ARRAY


	mov ebx,array
	
reading:

        push ebx

	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,l3
	int 80h

        
        call read_num
        mov ax,word[num]

        pop ebx
	mov word[ebx],ax
	add ebx,2
        dec word[temp]
        cmp word[temp],0
	jg reading
        

;ACCEPTING ARRAY DONE
        
     
	

        mov word[i],0
       
	iloop:
                mov ebx,array
		mov dx,0
		mov ax,word[i]
                mov cx,2
                div cx
                cmp dx,0
                je case1
                jmp case2
	
        iloopupdation:
	add word[i],1
        mov ax,word[m]
        cmp word[i],ax
	jb iloop



	exit:
        mov eax,1
	mov ebx,0
	int 80h



	case1:
	        mov word[j],0
            
		jloop1:
		mov ebx,array
		mov ax,word[i]
		mov cx,word[n]
		mul cx
		movzx eax,ax  ;eax has i*n
                movzx ecx,word[j]
                add eax,ecx
                mov dx,[ebx+2*eax]
                mov word[num],dx

                push ebx
		call print_num
                mov eax,4
		mov ebx,1
		mov ecx,space
		mov edx,l
		int 80h
		
 		pop ebx
              
		jloopupdation:
                add word[j],1
                mov ax,word[n]
                cmp word[j],ax
                jb jloop1

		jmp iloopupdation

	case2: 
		mov ebx,array
		mov ax,word[x]
		dec ax
		mov word[j],ax  ;x=n-1
		mov word[k],0

		jloop2:
		mov ax,word[i]
		mov cx,word[n]
		mul cx
		movzx eax,ax  ;eax has i*n
                movzx ecx,word[j]
                add ecx,eax
                mov dx,[ebx+2*ecx]
                mov word[num],dx
        
	        push ebx
		call print_num
                mov eax,4
		mov ebx,1
		mov ecx,space
		mov edx,l
		int 80h
 		pop ebx
              
		jloopupdation2:
                sub word[j],1
                add word[k],1
                mov ax,word[n]
                cmp word[k],ax
                jb jloop2
                jmp iloopupdation


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

printzero:
	add word[num],30h
	mov eax,4
	mov ebx,1
	mov ecx,num
	mov edx,1
	int 80h
jmp end_print


