section .data

	msg1: db 'Enter the no of rows of matrix 1   : '
	l1: equ $-msg1

	msg2: db 'Enter the no of columns of matrix 1: '
	l2: equ $-msg2

	msg3: db 'Enter the no of rows of matrix 2   : '
	l3: equ $-msg3

	msg4: db 'Enter the no of columns of matrix 2: '
	l4: equ $-msg4

	error: db 'c1 and r2 must be equal ',0Ah
	er: equ $-error

	msg5: db 'Enter the elements of first matrix : '
	l5: equ $-msg5

	msg6: db 'Enter the elements of second matrix: '
	l6: equ $-msg6

	el: db 0Ah
	le: equ $-el

	space: db ' '
	l: equ $-space

	hi: db 'hi'
        hil: equ $-hi

section .bss
	i: resw 1
	j: resw 1
        r1: resw 1
	c1: resw 1
        r2: resw 1
	c2: resw 1
	t: resw 1
	matrix1: resw 100
        matrix2: resw 100
	array: resw 100
	sum: resw 1
        num: resw 1
        temp: resw 1
	x: resw 1
	nod: resw 1
	dig: resw 1
	n1: resw 1
	n2:resw 1
	k: resw 1
	ele :resw 1
	temp1: resd 1
	temp2: resd 1


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

	mov word[r1],ax
;ACCEPTING R1 DONE


	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h
        
        call read_num
        mov ax,word[num]

	mov word[c1],ax
        
;ACCEPTING C1 DONE


	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,l3
	int 80h

	call read_num
        mov ax,word[num]

	mov word[r2],ax
;ACCEPTING R2 DONE


	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,l2
	int 80h
        
        call read_num
        mov ax,word[num]

	mov word[c2],ax
        
;ACCEPTING C2 DONE

mov ax,word[c1]
cmp ax,word[r2]
jne errormsg

;ACCEPTING OF SIZE OF ARRAY DONE
	
	mov ax,word[r1]
	mov bx,word[c1]
	mul bx
	mov word[n1],ax   ;n1 has total no of elements in 1st matrix 
        mov word[temp],ax ;temp has the total no of elements in 1st matrix



;STARTING WITH ACCEPTING MATRIX1

        
	mov ebx,matrix1
	
reading:

        push ebx

	mov eax,4
	mov ebx,1
	mov ecx,msg5
	mov edx,l5
	int 80h

        
        call read_num
        mov ax,word[num]

        pop ebx
	mov word[ebx],ax
	add ebx,2
        dec word[temp]
        cmp word[temp],0
	jg reading
        

;ACCEPTING MATRIX1 DONE
  


	
	mov ax,word[r2]
	mov bx,word[c2]
	mul bx
	mov word[n2],ax   ;n2 has total no of elements in 2nd matrix 
        mov word[temp],ax ;temp has the total no of elements in 2nd matrix



;STARTING WITH ACCEPTING MATRIX2

        
	mov ecx,matrix2
	
reading1:

        push ecx

	mov eax,4
	mov ebx,1
	mov ecx,msg6
	mov edx,l6
	int 80h

        
        call read_num
        mov ax,word[num]

        pop ecx
	mov word[ecx],ax
	add ecx,2
        dec word[temp]
        cmp word[temp],0
	jg reading1
        

;ACCEPTING MATRIX2 DONE

;STARTING WITH THE PROBLEM
  
        mov ebx,matrix1
	mov ecx,matrix2
	mov word[i],0
	
	iloop:
	mov word[j],0

		jloop:	
		mov word[sum],0
		mov word[k],0

			kloop:

	 
		                mov ax,word[i]
		                mov bx,word[c1]
				mul bx
				add ax,word[k]   
		                movzx edx,ax
	  			mov ebx,matrix1	 			
				mov eax,[ebx+2*edx]
				
		                mov dword[temp1],eax


					
				mov ax,word[k]
				mov bx,word[c2]
				mul bx
		                add ax,word[j]
				movzx edx,ax	    ;edx has k*c2+j
				mov ecx,matrix2
				mov edx,[ecx+2*edx] ;eax has b[k][j]
                                
		                mov dword[temp2],edx  ;temp1 has b[k][j]

		               

				

		                mov ax,word[temp1]
				mov bx,word[temp2]
				mul bx
                                add word[sum],ax
			
			
                              
			
			kloopupdation:
			add word[k],1
                        mov ax,word[r2]
                        cmp word[k],ax
                        jb kloop
		
		mov ax,word[sum]
                mov word[num],ax
                call print_num
                
                mov eax,4
		mov ebx,1
		mov ecx,space
		mov edx,l
		int 80h
                
                
                
		jloopudation:
		add word[j],1
		mov ax,word[c2]
		cmp word[j],ax
		jb jloop
         
        mov eax,4
	mov ebx,1
	mov ecx,el
	mov dx,le
	int 80h

	iloopupdation:		
	add word[i],1
	mov ax,word[r1]
	cmp word[i],ax
	jb iloop			



	exit:
        mov eax,1
	mov ebx,0
	int 80h

errormsg:
mov eax,4
mov ebx,1
mov ecx,error
mov edx,er
int 80h
jmp exit

	
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



