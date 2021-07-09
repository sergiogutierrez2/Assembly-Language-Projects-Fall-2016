TITLE   Assignment 7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Sergio Gutierrez
; date: 5/27/2016
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INCLUDE Irvine32.inc

.DATA
	a dWORD ?
	b dWORD ?
	Result dWord ?
	msgOne BYTE "Please Enter Number 1: ",0
	msgTwo BYTE "Please Enter Number 2: ",0
	msgProduct BYTE "The Product of both numbers is: ",0
	msgEnd BYTE "Thank you for participating.",0
 
.CODE

	main PROC

	L1:

		mov edx, OFFSET msgOne  ; "Please Enter Number 1: "
        call WriteString                                       
		call ReadDec
		mov a, eax

		mov edx, OFFSET msgTwo  ; "Please Enter Number 2: "
        call WriteString                         
		call ReadDec
		mov b, eax

		sub esp, 4       ; saving space in stack
		push b           ; pushing parameter with user input 2
		push a           ; pushing parameter with user input 1
		call Product
		pop Result       ; get the result of the product from the stack

		mov edx, OFFSET msgProduct ; "The Product of both numbers is: " 
		call WriteString
		mov eax, result
		call WriteDec

		call Crlf
		call Crlf
		cmp a, 0
		jne L1       ; if a is not equal to zero, go to L1
		cmp b, 0
        je L2        ; if b is equal to zero, go to L2
		jmp L1

     L2:

		call Crlf
		mov edx, OFFSET msgEnd  ; "Thank you for participating."
        call WriteString                   

		call Crlf
		call WaitMsg     ; display a default wait message

		exit
		main ENDP

;---------------------------------------------------
; Product PROC
;
; Description: By using the stack, this procedure
; accesses the data values in the stack containing the 
; user's two inputs. In order to multiply them, it rols
; through the second input, b, and uses shl to multiply
; the first input by 2 to the power of the number of shifts
; needed to get a carry flag. It also adds all the 
; values that were multiplied into edx, and stores the result 
; into the stack, so that the main procedure can pop it.
;----------------------------------------------------
Product PROC

push EBP            ; save base pointer
mov  EBP, ESP
push ECX            ; save ECX
push EDX            ; save EDX
push ESI            ; save EDX

mov eax, [ebp + 8]     ; get the stack parameter a
mov ebx, [ebp + 12]    ; get the stack parameter b 

mov EDX, 0           ; Zero EDX, itll store multiplication result
mov ECX, 31          ; 31 are the number of shifts required
mov ESI, EAX         ; save original number in ESI

Multiply:
rol EBX, 1          ; 1 shift performed
jnc Next            ; jump if not carry (carry flag clear)
mov EAX, ESI         ; otherwise store original number in eax for mult.
shl EAX, CL          ; CL holds number of shift that has carry flag set
add EDX, EAX         ; Add all values multiplied into EDX

Next:
loop Multiply    
rol  EBX, 1         ; 1 more shift to make it 32 bits shifted.
jnc Finalize        ; Jump if not carry (carry flag clear)
add EDX, ESI        ; otherwise add original value

Finalize:
mov [ebp + 16], EDX    ; move final result into the stack

pop     ESI            ; restore ESI
pop     EDX            ; restore EDX
pop     ECX            ; restore ECX
pop     EBP            ; restore restore base pointer

ret 8                  ; Clean up stack.
Product ENDP

END main  
