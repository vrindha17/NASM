section .data
	endline: db 0Ah
        l: equ $-endline
	littleendian: db 'LITTLE ENDIAN',0Ah
        ls: equ $-littleendian
        bigendian: db 'BIG ENDIAN',0Ah
	lb: equ $-bigendian

section .bss
	var: resb 1

section .text
	global _start:
	       _start:

	
        mov ax,1234h
        
	cmp al,12
        je big

        mov eax,4
        mov ebx,1
	mov ecx,littleendian
	mov edx,ls
        int 80h
        jmp exit

        big:

        mov eax,4
        mov ebx,1
	mov ecx,bigendian
	mov edx,lb
        int 80h


        exit:
        

	mov eax,1
 	mov ebx,0
	int 80h
