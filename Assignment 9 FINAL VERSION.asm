Title Assignment 9

COMMENT !
@@@@@@@@@@@@@@@@
name: Sergio Gutierrez
date: 6/14/16
@@@@@@@@@@@@@@@@
!

include irvine32.inc
; ===============================================
.data
MsgOne1 byte "Enter up to 40 unsigned dword integers. To end the array, enter 0: ",0
DescendingArray byte "Array sorted in descending order: ", 0

MessageEnter byte "Enter an element in your array: ", 0
OriginalArray byte "The Initial Array was: ", 0
SortedArray byte "The Sorted Array in descending order is: ", 0
Space byte " ", 0
tableD dword 41 dup(?)
NumberElements dword ?

;=================================================
.code
main proc
    
	mov ECX, 0
    mov eax, 0
	mov edx, offset MsgOne1
    call writestring
	call crlf
	call crlf

	sub esp, 4
	push offset tableD
    call enter_elem
	pop NumberElements
	call crlf

	mov edx, offset OriginalArray
    call writestring
	push offset tableD
	push NumberElements
	call print_arr

	push offset tableD
	push NumberElements
	call sort_arr
	call crlf

	mov edx, offset SortedArray
    call writestring
	push offset tableD
	push NumberElements
	call print_arr
	
   call crlf
   call crlf
   call WaitMsg

   exit
main endp

; ================================================
enter_elem proc
	
push EBP
mov EBP, ESP
pushad

mov edi, OFFSET tableD

LD:
mov edx, offset MessageEnter
call writestring
call readdec

STOSD
cmp EAX, 0
JE Next
Inc ECX
JMP LD

Next:
mov [ebp + 12], ECX

popad
pop     EBP            ; restore EBP

ret 4

enter_elem endp

; ================================================
print_arr proc

push EBP
mov EBP, ESP
pushad

mov ECX, [ebp + 8]

xor edi, edi
xor eax, eax
xor esi, esi
xor edx, edx

call crlf
mov esi, OFFSET tableD
mov edx, offset Space

PrintOriginalArray:
	mov eax, [esi]
	add esi, 4   ; increment to next array element
	call writeDec
    call writestring

Loop PrintOriginalArray

popad
pop ebp

ret 8

print_arr endp


; ================================================
sort_arr proc

push EBP
mov EBP, ESP
pushad

xor edi, edi
xor eax, eax
xor esi, esi
xor edx, edx

mov ECX, [ebp + 8]

dec ecx

L1: push ecx
mov esi, OFFSET tableD

L2:
call compare_and_swap
loop L2

pop ecx
loop L1

L4: 

popad
pop ebp

ret 8
sort_arr endp

; ===============================================
compare_and_swap proc

   mov eax, [esi]
   cmp [esi + 4], eax
   jb L3
   call swap
   L3: add esi, 4

   ret

compare_and_swap endp

; =================================================
swap proc

xchg eax, [esi + 4]
mov [esi], eax

ret
swap endp

end main