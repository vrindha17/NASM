;check validity of sin expression
section .data
	msg1: db "Enter x : "
	len1: equ $-msg1
	ms: db "The computed answer by processor instruction : "
	le: equ $-ms
	ms2: db "The computed answer by expansion : "
	le2: equ $-ms2
	m1: db 0Ah
	l1: equ $-m1
	msg4: db "Enter k: "
	len4: equ $-msg4
	format1: db "%lf",0
	format2: db "%lf ",10



section .bss
	num: resd 1
	flag: resd 1
	x: resd 1
	ans: resd 1
	lt: resd 1
	i: resd 1
	j: resd 1
	sum: resd 1
	denom: resd 1
	dig: resd 1

section .text
global main
extern scanf
extern printf


main:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

call read
fst dword[x]
;;;;;;;;accepting x done

fsin
fst dword[ans]		;fsin value stored in ans 
ffree st0
ffree st1

mov eax,4
mov ebx,1
mov ecx,ms
mov edx,le
int 80h

fld dword[ans]
call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;printed the sin value

	mov edx,dword[x]
	mov dword[sum],edx		;sum exp ans
	mov byte[i],1

	LOOP:
	cmp byte[i],25
	je EXIT
	mov al,byte[i]
	mov ah,0
	mov bl,2
	mul bl
	mov word[dig],1
	add ax,word[dig]
				;2i+1
	mov word[j],ax
	mov ax,word[i]
	mov bl,2
	mov ah,0
	div bl
	cmp ah,0
	jne even_neg		;flag is 1
	mov byte[flag],0
	cont:
	inc byte[i]
	mov edx,dword[x]
	mov dword[num],edx
	mov dword[denom],2
	Lp2:
	cmp byte[j],1
	je termover
	dec byte[j]
	fld dword[num]
	fmul dword[x]
	fidiv dword[denom]
	fst dword[num]

ffree st0
ffree st1
	inc dword[denom]
	jmp Lp2
				even_neg:
				mov byte[flag],1
				jmp cont
termover:
	cmp byte[flag],0
	je positive

	fld dword[sum]
	fsub dword[num]
	fst dword[sum]
;call print
	ffree st0
	ffree st1
jmp LOOP

positive:

fld dword[sum]
	fadd dword[num]
	fst dword[sum]
;call print
	ffree st0
	ffree st1
jmp LOOP


EXIT:
mov eax,4
mov ebx,1
mov ecx,ms2
mov edx,le2
int 80h

	fld dword[sum]
	call print		
mov eax,1
mov ebx,0
int 80h


print:
push ebp
mov ebp, esp
sub esp, 8
fst qword[ebp-8]
push format2
call printf
mov esp, ebp
pop ebp
ret


read:
push ebp
mov ebp, esp
sub esp, 8
lea eax, [esp]
push eax
push format1
call scanf
fld qword[ebp-8]
mov esp, ebp
pop ebp
ret

