; Program template
TITLE   Assignment 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Sergio Gutierrez
; date: 4/20/2016
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


INCLUDE Irvine32.inc

.data
a DWORD ?
b DWORD ?
cvar DWORD ?
result DWORD ?

string1 BYTE "Enter the value of a? ",0
string2 BYTE "Enter the value of b? ",0
string3 BYTE "Enter the value of c? ",0
ResultString BYTE "The result is: ",0

.code
main proc
	mov edx, 0
	mov edx, offset string1
	call writestring
	call readdec
	call crlf
	mov a, eax

	mov edx, offset string2
	call writestring
	call readdec
	call crlf
	mov b, eax

	mov edx, offset string3
	call writestring
	call readdec
	call crlf
	mov cvar, eax
	

	; (2 * b)
    mov eax, 2
    mul b
    mov ebx, eax ;EBX now has the result of (2*b)

	; (a + b * c)
    mov eax, b
    mul cvar     ;EAX now has b * c
    add eax, a   ;EAX now has (a + b * c)
	
	; (a + b * c)/ (2 * b)
    mov edx, 0
    div ebx           ; result of division is stored in EAX
    mov result, eax   ; variable result now has (a + b * c) / (2 * b)

    ; Print code is below.
	; Note that the assignment does not require the student to print any remainder of the division.
	; Therefore, I omitted code that would do this (just like the example on catalyst does not print remainders)

    mov edx, offset resultString
    call writestring

    mov edx, offset result
    call writedec 
    call crlf


	exit
main endp
end main

