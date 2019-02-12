;TO REVERSE EACH WORD IN A STRING



section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	
	el: db 0Ah
        le: equ $-el


section .bss
	string: resb 100
	stringlength: resb 1
	char: resb 1
	
	


section .data
	global _start:
	_start:
	cld

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

        mov edi,string
	call read_string                 ;readstring function will read the string and store it in 'string' and its length in stringlength


	mov esi,string
	mov ebx,esi

	revloop1:

	lodsb
        cmp al,32
        je functioncall
        cmp al,0
	je functioncall
        jmp revloop1


	end:
	mov esi, string
	call print_string
        
	exit:
	call print_endline
	mov eax,1
	mov ebx,0
	int 80h

functioncall:
call reverse
cmp al,0
je end
mov ebx,esi
jmp revloop1

reverse:
pusha

	mov ecx,esi
	sub ecx,2
        
	revloop2:
	mov dl,byte[ecx]
	mov al,byte[ebx]
        mov byte[ebx],dl
	mov byte[ecx],al
	dec ecx
	inc ebx
        cmp ebx,ecx
	jb revloop2	


popa
ret



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




print_endline:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,el
	mov edx,le
	int 80h
popa 
ret
