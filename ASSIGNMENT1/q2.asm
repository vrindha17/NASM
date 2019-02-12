section .bss
 	sum: resb 1
	sum1:resb 1
	num: resb 1
        junk: resb 1
section .data
	msg1: db "Enter a number :"
        l1: equ $-msg1
        endline: db 0Ah
        l: equ $-endline
section .text
       	global _start:
	_start:
	mov byte[sum],0
       	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h


       	mov eax,3
	mov ebx,0
	mov ecx,num
	mov edx,1
	int 80h

       	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h

        sub byte[num],30h
        mov al,byte[num]
        cmp al,0
        je action
        
        loop1:
        add byte[sum],al
        dec al
        cmp al,0
        ja loop1
        
        action:
        mov bl,10
  	mov al,byte[sum]
        div bl
        mov byte[sum],al
        mov byte[sum1],ah

	add byte[sum1],30h
        add byte[sum],30h

	mov eax,4
	mov ebx,1
	mov ecx,sum
	mov edx,1
	int 80h  

	mov eax,4
	mov ebx,1
	mov ecx,sum1
	mov edx,1
	int 80h     

        mov eax,4
	mov ebx,1
	mov ecx,endline
	mov edx,l
	int 80h     
        

	mov eax,1
	mov ebx,0
	int 80h

