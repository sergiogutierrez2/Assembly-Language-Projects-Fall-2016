; Program template
TITLE   Assignment 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Sergio Gutierrez
; date: 4/29/2016
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Comment !
Write a complete program that:
	1. Promts the user to enter 10 numbers.
	2. saves those numbers in a 32 bit integer array.
	3. Calculates the sum of the numbers and displays it.
	4. Calcualtes the mean of the array and displays it.
	5. Prints the array with the same order it was enterd.
	6. Rotates the members in the array forward one position for 
	   9 times. so the last rotation will display the array in 
	   reversed order. Print the array after each rotation.
	   check the sample run.
	
	  
	  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	  Don't use any shift or rotate instuctions which we have
	  not coverd yet. You need to use loop and indexed addressing.
	  All you work should be on the original array. Don't make 
	  a copy of the array at any time.
	  Add comments to make your program easy to read.
!

INCLUDE Irvine32.inc

.data
sum dword ?
thearray dword 10 DUP(?)

enternum BYTE "Please enter a number: ",0
ScreenSum BYTE "The sum is: ",0
ScreenMean BYTE "The mean is: ",0
OriginalArray BYTE "The original array: ",0
ScreenRotation BYTE "After a rotation: ",0
Space BYTE " ", 0
DivisionThingy BYTE "/10", 0
count DWORD ?


.code
main proc
mov eax, 0
mov ecx, 10
mov esi, OFFSET thearray


GetUserInput:                  ; Loop to get user's input
    mov edx, offset enternum  
	call writeString
	call readDec
	;call crlf
	mov [esi], eax
	add esi, 4                    ; increment to next array element
loop GetUserInput
    

	mov esi, OFFSET thearray
	mov eax, 0
	mov ecx, lengthof thearray


AddElementsinArray:     ; Loop to add elements in the array
	add eax, [esi]      ; add array element
	add esi, 4              ; increment to next array element
loop AddElementsinArray


;print the sum
mov sum, eax
mov edx, offset ScreenSum
call writestring     
call writedec     ;print the sum found in eax
call crlf

;division to get mean, eax has 55 at this point

mov ecx, 10
mov ebx, 0
mov edx, 0        ;clearing of trash from the remainder destination
div ecx           ; division takes place
mov ebx, edx     ; remainder is in ebx now

mov edx, 0
mov edx, offset ScreenMean
call writestring
call writedec

mov edx, offset Space              ; this is space on output screen
call writestring

mov eax, ebx
call writedec                      ;print eax

mov edx, offset DivisionThingy     ; this is the /10 on the output screen
call writestring
call crlf

mov esi, OFFSET thearray
mov ecx, lengthof thearray
mov eax, 0

mov edx, offset OriginalArray
call writestring
mov edx, offset Space

PrintOriginalArray:
	mov eax, [esi]
	add esi, 4   ; increment to next array element
	call writeDec
    call writestring

Loop PrintOriginalArray
call crlf


mov esi, OFFSET thearray    ; prepare values for two loops which will print array in reverse
mov esi, 0
mov ebx, 0
mov ecx, 9
mov eax, 0
mov ebp, 0

ReversingArray:
call crlf
mov edx, offset ScreenRotation
call writestring

XCHG ebx, [thearray+36]

mov count, ecx
mov ecx, 10        ;preparing ecx to iterate 10 times

;print the elements in the array but first reverse them using xchg
L2:
mov eax, ebx
call writedec           ;print value
mov edx, offset Space
call writestring
XCHG ebx, [thearray+ESI]
add esi, 4

Loop L2

mov esi, ebp
mov ecx, count      ;normalize ecx iterations

loop ReversingArray

Call waitmsg

exit
main endp
end main