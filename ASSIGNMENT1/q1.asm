section .bss
 	a: resb 1
	b: resb 1
 	c: resb 1
	counter: resb 1
section .data
space: db ' '
sl: equ $-space
endline: db 0Ah
el: equ $-endline

section .text
        global _start:
        _start:

	mov byte[counter],3
	mov byte[a],0
	mov byte[b],1
        
        add byte[a],30h
	add byte[b],30h
         
	mov eax,4
	mov ebx,1
	mov ecx,a
 	mov edx,1
	int 80h


	mov eax,4
	mov ebx,1
	mov ecx,space
 	mov edx,sl
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,b
 	mov edx,1
	int 80h   
        
	loop1:
        
	mov eax,4
	mov ebx,1
	mov ecx,space
 	mov edx,sl
	int 80h

	mov al,byte[a]
        mov bl,byte[b]
        add al,bl
        mov byte[c],al   	
        sub byte[c],30h
        
	mov eax,4
	mov ebx,1
	mov ecx,c
 	mov edx,1
	int 80h
	  

	mov al,byte[b]
        mov byte[a],al
        mov bl,byte[c]
        mov byte[b],bl 
        inc byte[counter]

	cmp byte[counter],5
        jna loop1
  


	mov eax,4
	mov ebx,1
	mov ecx,endline
 	mov edx,el
	int 80h

	mov eax,1
	mov ebx,0   
	int 80h  	
	
