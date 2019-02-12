section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	a: db 'Count of a = '
        l2: equ $-a
	e: db 'Count of e = '
        l3: equ $-e
	i: db 'Count of i = '
        l4: equ $-i
	o: db 'Count of o = '
        l5: equ $-o
	u: db 'Count of u = '
        l6: equ $-u
	el: db 0Ah
	le: equ $-el
section .bss
	string: resb 100
	stringlength: resb 1
        char: resb 1
	
	dig: resw 1
	num: resw 1
	nod: resw 1

	acount: resw 1
	ecount: resw 1
	icount: resw 1
	ocount: resw 1
	ucount: resw 1


section .data
	global _start:
	_start:
	
	mov byte[acount],0
	mov byte[ecount],0
	mov byte[icount],0
	mov byte[ocount],0
	mov byte[ucount],0



	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

	call read_string                 ;readstring function will read the string and store it in 'string' and its length in stringlength

;;;;;;;;;;;;;;;;;READ A STRING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov ebx,string

	forloop:
	cmp byte[ebx],0
	je printcount



	mov al,byte[ebx]

        cmp al,'a'
        je inc_a
	
        cmp al,'e'
        je inc_e	

        cmp al,'i'
        je inc_i	

        cmp al,'o'
        je inc_o	

        cmp al,'u'
        je inc_u	

        cmp al,'A'
        je inc_a	

        cmp al,'E'
        je inc_e	

        cmp al,'I'
        je inc_i	

        cmp al,'O'
        je inc_o
	
        cmp al,'U'
        je inc_u	

	updation:	
        inc ebx
	jmp forloop

	printcount:
	
	mov eax,4
	mov ebx,1
	mov ecx,a
	mov edx,l2
	int 80h
	mov ax,word[acount]
	mov word[num],ax
	call print_num

	call print_endline

	mov eax,4
	mov ebx,1
	mov ecx,e
	mov edx,l3
	int 80h

	mov ax,word[ecount]
	mov word[num],ax
	call print_num

	call print_endline

	mov eax,4
	mov ebx,1
	mov ecx,i
	mov edx,l4
	int 80h

	mov ax,word[icount]
	mov word[num],ax
	call print_num

	call print_endline

	mov eax,4
	mov ebx,1
	mov ecx,o
	mov edx,l5
	int 80h

	mov ax,word[ocount]
	mov word[num],ax
	call print_num


	call print_endline

	mov eax,4
	mov ebx,1
	mov ecx,u
	mov edx,l6
	int 80h

	mov ax,word[ucount]
	mov word[num],ax
	call print_num

	call print_endline

	exit:
	mov eax,1
	mov ebx,0
	int 80h


inc_a:
pusha
add word[acount],1
popa
jmp updation


inc_e:
pusha
add word[ecount],1
popa
jmp updation

inc_i:
pusha
add word[icount],1
popa
jmp updation

inc_o:
pusha
add word[ocount],1
popa
jmp updation

inc_u:
pusha
add word[ucount],1
popa
jmp updation



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
        je end_print_string
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
end_print_string:
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
	je end_print
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
end_print:
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

print_endline:
pusha
mov eax,4
mov ebx,1
mov ecx,el
mov edx,le
int 80h
popa
ret

