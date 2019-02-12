section .bss
	a: resb 1
	b: resb 1
        junk: resb 1
section .data
	msg1: db 'Enter first number :'
        l1: equ $-msg1
        msg2: db 'Enter second number :'
        l2: equ $-msg2
	msg3: db 'Multiple',0Ah
        l3: equ $-msg3
        msg4: db 'Not a multiple',0Ah
        l4: equ $-msg4


section .text
    	global _start:
               _start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
        mov edx,l1
	int 80h
	

	mov eax,3
	mov ebx,0
	mov ecx,a
        mov edx,1
	int 80h
        

	mov eax,3
	mov ebx,0
	mov ecx,junk
        mov edx,1
	int 80h

        sub byte[a],30h

	mov eax,4
	mov ebx,1
	mov ecx,msg2
        mov edx,l2
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,b
        mov edx,1
	int 80h

	
       	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
	
	sub byte[b],30h

	mov al,byte[a]
	mov bl,byte[b]
	div bl
	cmp ah,0

        jne notmul

	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
        mov edx,l3
	int 80h
               
        jmp exit

        notmul:

	mov eax,4
	mov ebx,1
	mov ecx,msg4
        mov edx,l4
	int 80h
      
	exit:
 	mov eax,1
	mov ebx,0
 	int 80h
