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
thearray byte 1, 2
count DWORD ?

.code
main proc
mov eax, 0
mov ecx, 3
mov edx, 0
mov ebx, 0

LoopNumber1:
mov count, ecx
mov ecx, 2
mov esi, 0

LoopNumber2:
add al, thearray[esi]
inc esi
add ebx, 1
Loop LoopNumber2

mov ecx, count
inc edx

Loop LoopNumber1



exit
main endp
end main