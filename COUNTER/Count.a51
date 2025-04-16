ORG 0000H       ; Program starts at address 0
MOV A, #00H     ; Initialize accumulator A with 0

UP_COUNTER:
    INC A        ; Increment A (A = A + 1)
    ACALL DELAY  ; Call delay subroutine
    SJMP UP_COUNTER ; Infinite loop

; Simple Delay Routine (adjustable)
DELAY:
    MOV R1, #255
WAIT1:
    MOV R2, #255
WAIT2:
    DJNZ R2, WAIT2
    DJNZ R1, WAIT1
    RET

END             ; End of program
