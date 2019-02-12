;TO FIND A PALINDROMIC SUBSTRING


section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	
	el: db 0Ah
        le: equ $-el
	space: db ' '
	sl: equ $-space

yes: db 'Yes',0Ah
yl: equ $- yes
no: db 'No',0Ah
nl: equ $-no
	hi: db 'hi',0Ah
	hl: equ $-hi

section .bss
	string: resb 100
	stringlength: resb 1
	char: resb 1
	
	i: resb 1
	j: resb 1
	k: resb 1
ctr: resb 1

section .data
	global _start:
	_start:
	
	cld
mov byte[ctr],0
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

        mov edi,string
	call read_string              

	
	mov byte[i],0
	mov esi,string

	iloop:
	lodsb
	cmp al,0
	je end		
	call check1	
	add byte[i],1
	jmp iloop

        end:
cmp byte[ctr],0
jne exit
call print_no
	exit:
	call print_endline
	mov eax,1
	mov ebx,0
	int 80h
check1:
pusha

	mov al,byte[stringlength]
	mov byte[j],al
	sub byte[j],1

	jloop:
	call check2
	sub byte[j],1
	mov al,byte[j]
	cmp byte[i],al
	jb jloop
	
end_check1:
popa
ret

check2:
pusha
cld
mov al,byte[j]
cmp al,byte[i]
je end_check2
	mov esi,string
	mov bl,byte[i]
	movzx ebx,bl
	add esi,ebx
	mov ecx,esi	;ecx has the starting address

	mov edx,string
	mov bl,byte[j]
	movzx ebx,bl
	add edx,ebx

	mov edi,edx     ;in edi simply storing the end value

	check_loop:
	lodsb

;mov byte[char],al
;call print_char
;mov cl,byte[edx]
;mov byte[char],cl
;call print_char

	cmp al,byte[edx]
	jne end_check2
	sub edx,1
	cmp esi,edx
	jae found
	jmp check_loop
call print_endline
found:
inc byte[ctr]
cmp byte[ctr],1
jne label
call print_yes
label:
	mov esi,ecx
	add edi,1
	printing:
	lodsb
	mov byte[char],al
	call print_char
	cmp esi,edi
	je end_print1	
        jmp printing
	
end_print1:
call print_endline

end_check2:		

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

print_char:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,char
	mov edx,1
	int 80h
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

print_hi:
pusha
mov eax,4
mov ebx,1
mov ecx,hi
mov edx,hl
int 80h
popa
ret

print_yes:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,yes
	mov edx,yl
	int 80h
popa
ret


print_no:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,no
	mov edx,nl
	int 80h
popa
ret
