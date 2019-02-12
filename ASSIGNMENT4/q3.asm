section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	msg2: db 'New sring is : '
        l2: equ $-msg2
	el: db 0Ah
	le: equ $-el
section .bss
	string: resb 100
	stringlength: resb 1
	char: resb 1
	

section .data
	global _start:
	_start:
	
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

	call read_string                 ;readstring function will read the string and store it in 'string' and its length in stringlength
        
	

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h  



	mov ebx,string

	forloop:

	cmp byte[ebx],0
        je print

	mov al,byte[ebx]

        cmp al,'a'
        je remove

	cmp al,'A'
	je remove

	cmp al,'i'
        je remove

	cmp al,'I'
        je remove
	
	updation:
	inc ebx
	jmp forloop

	

	print:
	call print_string
      

	mov eax,4
	mov ebx,1
	mov ecx,el
	mov edx,le
	int 80h
	exit:
	mov eax,1
	mov ebx,0
	int 80h




	remove:
        push ebx		;ebx has position of 'i' or 'a' and ecx=ebx+1
				;we shift all the elements in the right of ebx to left by  one position
	mov ecx,ebx
        inc ecx
        
        rloop:
        cmp byte[ebx],0
	je exit_remove
        mov al,byte[ecx]
        mov byte[ebx],al
	
	inc ebx
	inc ecx
        jmp rloop

	exit_remove:
	pop ebx 
	dec ebx                   ;NOW EBX HAS THE ADDRESS OF A SHIFTED ELEMENT WHICH WAS NOT CHECKED (WHETHER IT IS 'I' OR 'A')
        jmp updation		  ;SO WE NEED TO DECREASE EBX BY 1
                                  ; BECAUSE IN UPDATION EBX IS AGAIN GOING TO INCREASE
	               
        

read_string:
pusha
mov ebx,string
mov byte[stringlength],0

readloop:
	push ebx
	mov eax,3
	mov ebx,0
	mov ecx,char
	mov edx,1
	int 80h
        pop ebx

	
	cmp byte[char],10
        je end_read
	
	mov al,byte[char]
        mov byte[ebx],al
	inc byte[stringlength]
	inc ebx
        jmp readloop
end_read:
mov byte[ebx],0
popa
ret	     


print_string:
pusha
mov ebx,string
printloop:
	cmp byte[ebx],0
        je end_print
 	mov al,byte[ebx]
	mov byte[char],al
	
	push ebx
	mov eax,4
	mov ebx,1
	mov ecx,char
	mov edx,1
	int 80h
	pop ebx
         
        inc ebx
        jmp printloop
end_print:
popa
ret
