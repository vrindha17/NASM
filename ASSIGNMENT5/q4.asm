;TO FIND SMALLEST AND LARGEST WORD IN A STRING


section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	msg2: db 'The largest word is : '
	l2: equ $-msg2
	msg3: db 'The smallest word is : '
	l3: equ $-msg3
	
	el: db 0Ah
        le: equ $-el

	space: db ' '
        sl: equ $-space

section .bss
	string: resb 100
	stringlength: resw 1
	char: resb 1
	
	string2: resb 1
	temp: resw 1
	maxctr: resw 1
	ctr: resw 1
	minctr:resw 1
	num: resw 1
	dig: resw 1
	nod: resw 1
section .data
	global _start:
	_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

        mov edi,string
	call read_string                 ;readstring function will read the string and store it in 'string' and its length in stringlength

	
	cld
	mov edx,string
	mov esi,string
	
	largestloop:
	lodsb
        cmp al,32
        je setctr
	cmp al,0
	je setctr
	inc word[ctr]
        update:
	cmp al,0
	jne largestloop

mov bx,word[maxctr]
mov word[num],bx
call print_num
call print_endline



pusha
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h
popa


        mov esi,edx

	endloop1:
	lodsb
	cmp al,32
	je smallest
	cmp al,0
	je smallest
	mov byte[char],al
	call print_char
	jmp endloop1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

smallest:
call print_endline


mov word[ctr],0
mov word[minctr],1000

	mov edx,string
	mov esi,string
	
	sloop:
	lodsb


        cmp al,32
        je setminctr
	cmp al,0
	je setminctr
	inc word[ctr]
        updatemin:
	cmp al,0
	jne sloop

mov bx,word[minctr]
mov word[num],bx
call print_num
call print_endline


pusha
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h
popa


        mov esi,edx

	endloop2:
	lodsb
	cmp al,32
	je exit
	cmp al,0
	je exit
	mov byte[char],al
	call print_char
	jmp endloop2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





	
	exit:
	call print_endline
	mov eax,1
	mov ebx,0
	int 80h


setctr:
	mov bx,word[ctr]
	mov word[ctr],0
	cmp word[maxctr],bx
	ja update
	mov word[maxctr],bx
	mov edx,esi
	sub edx,ebx
	sub edx,1
jmp update



setminctr:


	mov bx,word[ctr]
	mov word[ctr],0
	cmp word[minctr],bx
	jb updatemin
	mov word[minctr],bx
	mov edx,esi
	sub edx,ebx
	sub edx,1
jmp updatemin






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

        inc word[stringlength]
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


print_space:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,space
	mov edx,sl
	int 80h
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


print_char:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,char
	mov edx,1
	int 80h
popa
ret
