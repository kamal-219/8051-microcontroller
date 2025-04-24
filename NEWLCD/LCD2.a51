ORG 0000H

; Data Port and Control Port Setup
MOV P2, #00H      ; Data port (connected to LCD data lines)
MOV P3, #00H      ; Control port: P3.0 = RS, P3.1 = RW, P3.2 = EN

MAIN:
    ACALL INIT_LCD
    MOV DPTR, #MSG
    ACALL DISPLAY_TEXT

LOOP_SCROLL:
    ACALL DELAY
    MOV A, #18H       ; Command: Shift display left
    ACALL SEND_CMD
    SJMP LOOP_SCROLL

; LCD Initialization
INIT_LCD:
    MOV A, #38H       ; Function set: 8-bit, 2-line, 5x7
    ACALL SEND_CMD
    MOV A, #0CH       ; Display ON, Cursor OFF
    ACALL SEND_CMD
    MOV A, #01H       ; Clear display
    ACALL SEND_CMD
    MOV A, #06H       ; Entry mode: increment cursor
    ACALL SEND_CMD
    MOV A, #80H       ; Set cursor to 1st line
    ACALL SEND_CMD
    RET

; Send Command to LCD
SEND_CMD:
    MOV P2, A
    CLR P3.0          ; RS = 0
    CLR P3.1          ; RW = 0
    SETB P3.2         ; EN = 1
    ACALL DELAY
    CLR P3.2          ; EN = 0
    ACALL DELAY
    RET

; Send Data to LCD
SEND_DATA:
    MOV P2, A
    SETB P3.0         ; RS = 1
    CLR P3.1          ; RW = 0
    SETB P3.2         ; EN = 1
    ACALL DELAY
    CLR P3.2          ; EN = 0
    ACALL DELAY
    RET

; Display message from ROM
DISPLAY_TEXT:
NEXT_CHAR:
    CLR A
    MOVC A, @A+DPTR
    JZ END_DISPLAY
    ACALL SEND_DATA
    INC DPTR
    SJMP NEXT_CHAR
END_DISPLAY:
    RET

; Delay Subroutine
DELAY:
    MOV R3, #50
DELAY1:
    MOV R4, #255
DELAY2:
    NOP
    DJNZ R4, DELAY2
    DJNZ R3, DELAY1
    RET

; Message to be displayed
MSG: DB "HI SILICIC", 0

END
