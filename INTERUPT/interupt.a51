ORG 0000H         ; Start of program memory

START:
    MOV A, #00H    ; Initialize accumulator A with 0

LOOP:
    MOV P1, A      ; Send current value of A to Port 1
    ACALL DELAY    ; Wait some time to see the output
    INC A          ; Increment counter (A = A + 1)
    SJMP LOOP      ; Repeat forever
DELAY:
    MOV R1, #100
D1: MOV R2, #250
D2: DJNZ R2, D2
    DJNZ R1, D1
    RET

END
