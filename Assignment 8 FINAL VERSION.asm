TITLE   Assignment 8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Sergio Gutierrez
; date: 06/11/2016
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INCLUDE Irvine32.inc

.data
MsgOne1 byte "Enter the number of elements in your array (no more than 40): ",0
MsgTwo2 byte "Enter the number of elements in each row in the array: ",0
MsgThree3 byte "Enter the type of your array. ",0
MsgThree2 byte "Type 1 for byte, 2 for word, 4 for doubleword: ",0

MessageEnter byte "Enter an element in your array: ", 0
MessageSum byte "Enter Row number that you want me to add: ", 0
MessageDisplaySum byte "The Sum in Hexadecimal is: ", 0

Elements dword ?
RowSize dword ?

tableB byte 40 dup(?)
tableW word 40 dup(?)
tableD dword 40 dup(?)

.code

main proc
    mov eax, 0
	mov edx, offset MsgOne1
    call writestring
    call readdec
	cmp EAX, 40
	ja More
	jmp next
	More:
	mov EAX, 40
	next:
    mov Elements, eax
	mov ECX, Elements

	mov edx, offset MsgTwo2
    call writestring
    call readdec
    mov RowSize, eax

	mov edx, offset MsgThree3
    call writestring

	STD

	Message:
	mov edx, offset MsgThree2
    call writestring
    call readdec

	cmp EAX, 1
	JE L1

	cmp EAX, 2
	JE L2

	cmp EAX, 4
	JE L3

	jmp Message

	L1:
	push OFFSET tableB
	call createArrayByte
	mov ECX, RowSize
	push OFFSET tableB
	call SumArrayByte
	jmp final

	L2:
	push OFFSET tableW
	call createArrayWord
	mov ECX, RowSize
	push OFFSET tableW
	call SumArrayWord
	jmp final

	L3:
	push OFFSET tableD
	call createArrayDword
	mov ECX, RowSize
	push OFFSET tableD
	call SumArrayDword
	jmp final

	final:
	CLD
	call crlf
	call WaitMsg     ; display a default wait message

	exit
    main endp

	

createArrayByte PROC
push EBP
mov EBP, ESP
push EDI            ; save EDX
push EDX           ; save EDX

mov edi, OFFSET tableB
LB:
mov edx, offset MessageEnter
call writestring
call readdec

STOSB

loop LB

pop     EDX            ; restore EDX
pop     EDI            ; restore ECX
pop     EBP            ; restore EBP

ret
createArrayByte ENDP




createArrayWord PROC
push EBP
mov EBP, ESP
push EDI            ; save EDX
push EDX           ; save EDX

mov edi, OFFSET tableW

LW:
mov edx, offset MessageEnter
call writestring
call readdec
STOSW
loop LW

pop     EDX            ; restore EDX
pop     EDI            ; restore ECX
pop     EBP            ; restore EBP

ret 2
createArrayWord ENDP



createArrayDword PROC
push EBP
mov EBP, ESP
push EDI            ; save EDX
push EDX           ; save EDX

mov edi, OFFSET tableD

LD:
mov edx, offset MessageEnter
call writestring
call readdec

STOSD
loop LD

pop     EDX            ; restore EDX
pop     EDI            ; restore ECX
pop     EBP            ; restore EBP

ret 4
createArrayDword ENDP

SumArrayByte PROC
push EBP
mov EBP, ESP
pushad
mov edx, offset MessageSum
call writestring
call readdec

mov ebx, offset tableB
mov edi, 0
mul ecx
add ebx, eax
xor eax, eax
mov esi, 0
xor edx, edx


SumByte:
mov dl, BYTE PTR [ebx + esi]
add eax, edx
inc esi
loop SumByte

mov edx, offset MessageDisplaySum
call writestring
call WriteHex

popad
pop ebp
ret
SumArrayByte ENDP



SumArrayWord PROC
push EBP
mov EBP, ESP
pushad

mov edx, offset MessageSum
call writestring
call readdec

mov ebx, offset tableW
mov edi, 0
mul ecx
mov edx, 2
mul edx
add ebx, eax
xor eax, eax
mov esi, 0
xor edx, edx

SumWord:
mov dx, WORD PTR [ebx + esi]
add eax, edx
add esi, 2
loop SumWord

mov edx, offset MessageDisplaySum
call writestring
call WriteHex

popad
pop ebp

ret 2
SumArrayWord ENDP



SumArrayDword PROC
push EBP
mov EBP, ESP
pushad

mov edx, offset MessageSum
call writestring
call readdec


mov ebx, offset tableD
mov edi, 0
mul ecx
mov edx, 4
mul edx
add ebx, eax
xor eax, eax
mov esi, 0
xor edx, 0

SumDword:
mov edx, [ebx + esi]
add eax, edx
add esi, 4
loop SumDword

mov edx, offset MessageDisplaySum
call writestring
call WriteHex

popad
pop ebp

ret 4
SumArrayDword ENDP


end main