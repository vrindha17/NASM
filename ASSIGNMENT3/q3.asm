;ROTATING ANTICLOCKWISE



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
	length: equ $-space
	hi: db 'hi'
        hil: equ $-hi

section .bss
	i: resw 1
	j: resw 1
        m: resw 1
	n: resw 1
	t: resw 1
	array: resw 100
	array2: resw 100
        num: resw 1
        temp: resw 1
	x: resw 1
	nod: resw 1
	dig: resw 1
	n2:resw 1
	k: resw 1
	l: resw 1
	ele :resw 1


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
  
;STARTING WITH ROTATING WITH 90DEG
      
        mov ecx,array2
        mov ax,word[n]
        dec ax
	mov word[j],ax
        mov word[l],0
        jloop:  mov ebx,array  
		
                
                mov word[i],0
                mov word[k],0
               
		iloop:  push ecx
			mov ebx,array 
                        mov ax,word[i]
		        mov cx,word[n]
		        mul cx
			movzx eax,ax
			movzx ecx,word[j]
		        add eax,ecx
		        mov dx,[ebx+2*eax]
                        pop ecx
                        mov [ecx],dx
                        
			
		iloopupdation:

		add ecx,2
		inc word[i]
                add word[k],1
		mov ax,word[m]
                cmp word[k],ax
                jb iloop
        
	jloopupdation:
        dec word[j]
	inc word[l]
        mov ax,word[n]
        cmp word[l],ax
        jb jloop
	      




;PRINTING THE MATRIX
	mov ebx,array2

	loop1:
	
        mov ax,word[ebx]
	mov word[num],ax

	push ebx
	call print_num
	mov eax,4
	mov ebx,1
	mov ecx,space
	mov edx,length
        int 80h

	pop ebx

	loopupdation:
	add ebx,2
	sub word[n2],1
        push ebx
        mov dx,0
        mov ax,word[n2]
        mov bx,word[m]
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



	
;READING AN N DIGIT NUMBER
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




;PRINTING AN N DIGIT NUMBER


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

endline:
mov eax,4
mov ebx,1
mov ecx,el
mov edx,le
int 80h
jmp continue
