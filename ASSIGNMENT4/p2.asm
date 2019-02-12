section .data
	msg1: db 'Enter the 1st string : '
	l1: equ $-msg1
	msg2: db 'Enter the 2nd string : '
        l2: equ $-msg2
	hi: db 'hi'
        hl: equ $-hi

section .bss
	string: resb 100
	stringlength: resb 1
	char: resb 1
	
	string1: resb 100
        length1: resb 1
	string2: resb 100
	length2: resb 1


section .data
	global _start:
	_start:
	cld
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h
        mov edi,string1
	call read_string                 ;readstring function will read the string and store it in 'string' and its length in stringlength
        mov al,byte[stringlength]
	mov byte[length1],al
	


	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h
        mov edi,string2
	call read_string

	call concat

	mov esi, string1
	call print_string
        
	exit:
	mov eax,1
	mov ebx,0
	int 80h


read_string:
pusha
	read_string_loop:

	mov eax,3
	mov ebx,0
	mov ecx,char
	mov edx,1
	int 80h

        cmp byte[char],10
        je end_read

        inc byte[stringlength]
        mov al,byte[char]
	stosb
	jmp read_string_loop

end_read:
mov byte[edi],0
popa
ret	     


print_string:
pusha
	printloop:
	
	lodsb
        mov byte[char],al

        cmp al,0
        je end_print

	mov eax,4
	mov ebx,1
	mov ecx,char
	mov edx,1
	int 80h
	jmp printloop

end_print:

popa
ret

concat:
pusha
cld
mov edi,string1
movzx eax,byte[length1]
add edi,eax
mov esi,string2
	concatloop2:
        lodsb
        stosb
        cmp al,0
	jne concatloop2

end_string_copy:
mov byte[edi],0
popa 
ret



print_hi:
pusha
mov eax,4
mov ebx,1
mov ecx,hi
mov edx,hl
int 80h
popa 
ret
