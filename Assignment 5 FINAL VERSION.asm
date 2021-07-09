TITLE   Assignment 5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Sergio Gutierrez
; date: 5/13/2016
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


INCLUDE Irvine32.inc

.data
one sdword ?
two sdword ?
string1 byte "Enter an integer: ",0
string2 byte "The sum is: ",0
string3 byte "The difference is: ",0
string4 byte "Press any key...",0

.code

main PROC

mov ecx, 3            ; setting ECX to iterate loop 3 times

L1:
call clrscr          ; Clears the console window.
mov bh, 8            ; moving 8 into bh, which will be used in the Locate procedure.

call Locate          ; locates the cursor at a certain point in the console screen.
call Input           ; prompts the user to enter two signed integers
call crlf             ; Writes an end-of-line sequence to console window

call Locate
call DisplaySum       ; Adds the value of variable one and two
call crlf

call Locate          
call DisplayDiff      ; Substracts the two signed variables
call crlf

call Locate
call WaitForKey       ; prints "Press any Key..." and waits for an input
call crlf
Loop L1

call Locate
call WaitMsg    ; displays default wait message. I know its not needed but in class an extra waitmsg was displayed in assignment sample run...

    exit
main ENDP


;---------------------------------------------------
; Input PROC
;
; Description: This procedure prompts the user to enter two 
; integers, reads them, and stores them into two signed variables.
; Receives: EAX which stores the user's input into the named variables.
; Returns: 2 signed variables named "one" and "two" of 4 bytes
; with user's input.
; Requires: Nothing
;----------------------------------------------------
Input PROC

mov edx, offset string1     ; point to string1
call writestring            ; displays "Enter an integer: "
call readint                ; reads integer
mov one, eax                ; stores integer in variable "one"

call crlf                   ; Writes an end-of-line sequence to console window 
call Locate                 ; Locate calls Gotoxy to locate cursor in console window

mov edx, offset string1     
call writestring            ; displays "Enter an integer: "
call readint                ; reads integer into EAX
mov two, eax                ; stores integer in variable "two"

ret
Input ENDP


;--------------------------------------------------
; DisplaySum Proc
;
; This procedure adds the value of variable one and two, stores 
; the added value in EAX, and displays it into the screen.
; Receives: 2 signed variables named "one" and "two" of 4 bytes.
; Returns: EAX = Sum
; Requires: Nothing
;--------------------------------------------------
DisplaySum PROC
mov eax, one                   ; moves variable "one" in EAX
add eax, two                   ; EAX now contains addition of "one" and "two"

mov edx, offset string2        ; point to string2
call writestring               ; displays "The sum is: "
call writeint                  ; displays the sum of "one" and "two"

call crlf                      ; Writes an end-of-line sequence to console window 
ret
DisplaySum ENDP


;--------------------------------
; DisplayDiff Proc
;
; Substracts two signed variables
; Receives: 2 signed variables named one and two of 4 bytes.
; Returns: EAX = Difference
; Requires: Nothing
;--------------------------------
DisplayDiff PROC
mov eax, one                      ; Moves the value of "one" into EAX
sub eax, two                      ; EAX now contains the value of the substraction between two signed integers

mov edx, offset string3           ; point to string3
call writestring                  ; Prints "The difference of the two integers is: "
call writeint                     ; Displays the value of the substraction between the two signed integers

call crlf
ret
DisplayDiff ENDP


;---------------------------------------
; WaitForKey Proc
;
; This procedure prints the string, "Press any Key..." and waits for an input
; Receives: Nothing
; Returns: Nothing
; Requires: Nothing
;---------------------------------------
WaitForKey PROC
mov edx, offset string4           ; point to string4
call writestring                  ; Displays "Press any key..."
call readchar                     ; Waits for user to enter a char
call crlf
ret
WaitForKey ENDP


;----------------------------------------------
; Locate Proc
;
; This procedure locates the cursor at a certain point in the console screen.
; The X (column) and Y (row) coordinates are adjusted according to the values
; found at dh and dl. A call to Gotoxy is done to place the cursor at the desired point.
; Receives: bh = counter for dh (y-coordinate)
; Returns: Nothing
;----------------------------------------------
Locate PROC
add bh, 2                      ; adds 2, to bh
mov dh,bh                      ; moves the already altered value of bh, to dh (y-coordinate, row)
mov dl,20                      ; moves 20 into dl (x-coordinate, column)
call Gotoxy                    ; places cursor according to the values of dh and dl
ret
Locate ENDP


END main