;1. Given a string containing alphabets in lower-case and upper-case, find the maximum count of distinct lower-case alphabets present between two upper-case alphabets

section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	
	el: db 0Ah
        le: equ $-el


section .bss
	string: resb 100
	stringlength: resb 1
	char: resb 1
	
	maxctr: resw 1
	
	subarray: resw 100
	subctr: resw 1
	i: resw 1
	j: resw 1
	ctr: resw 1
	num: resw 1
	dig: resw 1
	nod: resw 1	
	


section .data
	global _start:
	_start:
	cld

	mov word[maxctr],0
	mov word[ctr],0
	mov word[subctr],0

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

        mov edi,string
	call read_string                

	
	mov ecx,subarray
	mov esi,string

	loop1:

	lodsb
	cmp al,0
	je end
	call isupper    ;function will call another function if its uppercase and counts the lowercase till an uppercount is encountered
	jmp update

	updation:
	mov word[subctr],0
	mov ax,word[ctr]
	cmp word[maxctr],ax
	jb setctr

	update:
	jmp loop1

	end:
	mov ax,word[maxctr]
	mov word[num],ax
	call print_num
        
	exit:
	call print_endline
	mov eax,1
	mov ebx,0
	int 80h


setctr:
mov ax,word[ctr]
mov word[maxctr],ax
mov word[ctr],0
dec esi
jmp update

isupper:
pusha
	cmp al,'A'
	jb end_isupper
	
	cmp al,'Z'
	ja end_isupper

	jmp function

end_isupper:	

popa
ret


function:
	lodsb
	cmp al,0
	je end
	call islower   ;this function will set the ctr if al is lowercase.If not lowercase it jumps to updation
	jmp function        


islower:
pusha
	cmp al,'a'
	jb isupper2    ;checks if its an uppercase and if yes it jumps to updation

	cmp al,'z'
	ja isupper2
	
	call checkrep   ;it checks for repetition and if there is repetition it jumps to function
	
	

popa
ret

isupper2:
pusha
	cmp al,'A'
	jb end_isupper2
	
	cmp al,'Z'
	ja end_isupper2
	jmp updation
end_isupper2:
	
popa
jmp function

checkrep:
pusha
	cmp word[ctr],0
	je subarrayupdate
	mov bx,word[ctr]

	mov word[i],bx
	movzx ax,al

	
        mov word[j],ax

	mov ecx,subarray
        
	loopcheck:	;checks for repetion of elements ...as all the elements counted previously is put in an array with ecx as pointer
	
	mov ax,word[j]

	cmp word[ecx],ax
        je end_checkrep

	add ecx,2
	dec word[i]
	cmp word[i],0
	ja loopcheck
	
	subarrayupdate:
        
        mov word[ecx],ax
	add word[ctr],1

  	;add word[ctr],1
end_checkrep:
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


