;TO REMOVE DUPLICATES
;EG BANANAS TO BANS


section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	
	el: db 0Ah
        le: equ $-el

	hi: db 'hi'
        hl: equ $-hi


section .bss
	string: resb 100
	stringlength: resb 1
	char: resb 1
	i: resb 1

	j: resb 1
	temp: resb 1

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

	mov byte[i],0
	mov esi,string

	iloop:
        lodsb             ;now al has got a single element . we will call check function and check whether the element is present or not
        cmp al,0         
        je end
        call check
        inc byte[i]
	jmp iloop          
	

	end:
        mov esi,string
	call print_string
	
        
	exit:
	call print_endline
	mov eax,1
	mov ebx,0
	int 80h

check:
pusha
	mov byte[temp],al
	
	mov bl,byte[i]
	inc bl
	          
	movzx ebx,bl             ;ebx=i+1

	mov esi,string
	add esi,ebx              ;esi+=i+1 as we need to start looking from the bvery next element

	jloop:
	lodsb
        cmp al,byte[temp]
        je remove                ;it should subtract 1 from esi because the shifted element is not checked
	cmp al,0
	je end_check
	jmp jloop
	
end_check:
popa
ret


remove:
push esi
dec esi
mov ecx,esi
inc ecx
	rloop:

        cmp byte[esi],0
        je exit_remove
        
	mov al,byte[ecx]
        mov byte[esi],al
          
	inc esi
	inc ecx
	jmp rloop

exit_remove:
pop esi
dec esi
jmp jloop 



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


print_hi:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,hi
	mov edx,hl
	int 80h
popa 
ret



