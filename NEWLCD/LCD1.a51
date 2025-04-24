; Alternate LCD Scroll Left Code - 8051 Assembly

ORG 0000H

; Pin definitions
RS  EQU P3.0
RW  EQU P3.1
EN  EQU P3.2

; Delay routine
DELAY:
    MOV R5, #100
DLY_LOOP:
    MOV R6, #255
DLY_INNER:
    DJNZ R6, DLY_INNER
    DJNZ R5, DLY_LOOP
    RET

; Enable pulse
ENABLE_PULSE:
    SETB EN
    ACALL DELAY
    CLR EN
    RET

; Send command to LCD
LCD_COMMAND:
    CLR RS
    CLR RW
    ACALL ENABLE_PULSE
    RET

; Send data to LCD
LCD_WRITE:
    SETB RS
    CLR RW
    ACALL ENABLE_PULSE
    RET

; LCD Initialization
LCD_INIT:
    MOV A, #38H
    MOV P1, A
    ACALL LCD_COMMAND

    MOV A, #0CH
    MOV P1, A
    ACALL LCD_COMMAND

    MOV A, #01H
    MOV P1, A
    ACALL LCD_COMMAND

    MOV A, #06H
    MOV P1, A
    ACALL LCD_COMMAND

    RET

; Print a string
LCD_PRINT:
    MOV DPTR, #MESSAGE
NEXT_CHAR:
    CLR A
    MOV A, @DPTR
    JZ END_PRINT
    MOV P1, A
    ACALL LCD_WRITE
    INC DPTR
    SJMP NEXT_CHAR
END_PRINT:
    RET

; Main program
MAIN:
    ACALL LCD_INIT
    ACALL LCD_PRINT

SCROLL_LEFT:
    MOV A, #18H
    MOV P1, A
    ACALL LCD_COMMAND
    ACALL DELAY
    SJMP SCROLL_LEFT

; Message to display
MESSAGE: DB "HI SILICON", 0

END
