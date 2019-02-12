section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1

	yes: db 'palindrome ',0Ah
	yl: equ $-yes
	no: db 'not palindrome ',0Ah
	nl: equ $-no
	
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;READ STRING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        dec byte[stringlength]        ;stringlength=n-1
 
        mov ebx,string
        movzx ecx,byte[stringlength]
        add ecx,ebx		      ;ecx has the address of last character of string

	palindrome:
               


        mov al,byte[ebx]
        cmp al,byte[ecx]
        jne print_no
        
        inc ebx
	dec ecx
        cmp ebx,ecx
        jb palindrome
        
	jmp print_yes

     
        

	exit:
	mov eax,1
	mov ebx,0
	int 80h




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




        print_no:
        
        mov eax,4
	mov ebx,1         
	mov ecx,no
	mov edx,nl
	int 80h         
        
	jmp exit



        print_yes:
        
        mov eax,4
	mov ebx,1         
	mov ecx,yes
	mov edx,yl
	int 80h    
	jmp exit
