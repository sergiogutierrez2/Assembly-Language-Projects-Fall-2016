;no puede con input de 257
INCLUDE Irvine32.inc

.DATA
    InputMsg BYTE "Please enter a number: ",0
    PrimeNumbers BYTE "Prime numbers found until the given number: ",0
    limit dWORD ?

.CODE
    main PROC
        mov eax,0
 
        ; Display Message On Console For input Number
        mov edx, OFFSET InputMsg  ; "Please enter a number: "
        call WriteString
 
        call Readdec    ; fijate si asi se debe quedar
        mov limit, eax
 
        mov edx, OFFSET PrimeNumbers   ; "Prime numbers found until the given number::  "
        call WriteString
        call Crlf                  ; Writes an end-of-line sequence to the console window.
 
 
    ; Set The Starting Number Of The Series
        mov esi, 1            ; ESI has starting number 1

    L1:
        cmp esi,limit            ; compare ESI and b
        jg next           ; jump if not Less than or equal  !(<=)
 
        mov ebx, 2          ;  Starting Dividend, ebx has 2

        mov edx,esi         ; edx has startingnumber 3

        mov ecx,edx        ; ecx has startingnumber 3

        dec ecx             ; ecx now has 2
        call isPrime

      ;next:
        jmp L1

		next:
		call WaitMsg
        exit    ; The exit statement (indirectly) calls a predefined
                ; MS-Windows function that halts the program.
    main ENDP   ; The ENDP directive marks the end of the main procedure.

    ;L1:
    isPrime PROC
        Upper :
            cmp ebx,ecx       ; Compare BX and CX
            jg Prime       ; jump if not Less than  !(<)
            mov eax, edx    ; eax 3 edx 3 ebx 2 ecx 3
            div bl
            cmp ah,0         ; eax 1
            je Increment    ; jump if equal  (=)
            inc bl          ; Increment Dividend
            jmp Upper
        Prime:
            mov eax, edx   ; limit and number1
            call WriteDec   ; Display an unsigned 32-bit integer value
                            ; in EAX in decimal format.
            call Crlf
        Increment:
             inc esi ; Increment the ESI

             ;jmp L1
             ret
             isPrime ENDP


END main        ; The END directi 