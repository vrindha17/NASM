;TO COUNT THE NUMBER OF WORDS IN A STRING



section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	
	el: db 0Ah
        le: equ $-el


section .bss
	string: resb 100
	stringlength: resb 1
	char: resb 1
	
	ctr: resw 1
	num: resw 1
	dig: resw 1
	nod: resw 1	


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

	countloop:

	lodsb
        cmp al,32
        je ctrupdate
        cmp al,0
	je ctrupdate
        jmp countloop


	end:
	mov ax,word[ctr]
        mov word[num],ax
	call print_num
        
	exit:
	call print_endline
	mov eax,1
	mov ebx,0
	int 80h

ctrupdate:
inc byte[ctr]
cmp al,0
je end
jmp countloop



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



read_num:

pusha
mov word[num],0
loop2:

	mov eax,3
	mov ebx,0
	mov ecx,dig
	mov edx,1
	int 80h
     
        cmp word[dig],10  ;10 ASCII for new line
	je end_loop
        cmp word[dig],32
        je end_loop
	sub word[dig],30h
        mov dx,0
	mov ax,word[num]
        mov bx,10
        mul bx
        add ax,word[dig]
        mov word[num],ax
        jmp loop2

end_loop: 
popa
ret







print_num:
pusha
cmp word[num],0
je printzero
loop3:
	cmp word[num], 0
	je print_no
	inc word[nod]
	mov dx,0
	mov ax, word[num]
	mov bx, 10
	div bx
	push dx
	mov word[num], ax
	jmp loop3

	print_no:
	cmp word[nod], 0
	je endprint
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
endprint:
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

