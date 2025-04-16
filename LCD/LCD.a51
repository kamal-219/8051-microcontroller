ORG 0000H

;-------------------------------
; PORT SETUP
;-------------------------------
MAIN:
    MOV P2, #00H    ; LCD Data Port as output
    MOV P3, #00H    ; LCD Control Port as output

    ACALL LCD_INIT  ; Initialize LCD
    ACALL DISPLAY_MSG

    ; Infinite loop
    SJMP $

;-------------------------------
; LCD INITIALIZATION
;-------------------------------
LCD_INIT:
    MOV A, #38H     ; Function Set
    ACALL LCD_CMD
    MOV A, #0CH     ; Display ON, Cursor OFF
    ACALL LCD_CMD
    MOV A, #01H     ; Clear Display
    ACALL LCD_CMD
    MOV A, #06H     ; Entry Mode Set
    ACALL LCD_CMD
    RET

;-------------------------------
; LCD COMMAND WRITE
;-------------------------------
LCD_CMD:
    CLR P3.0        ; RS = 0
    CLR P3.1        ; RW = 0
    ACALL LCD_WRITE
    RET

;-------------------------------
; LCD DATA WRITE
;-------------------------------
LCD_DATA:
    SETB P3.0       ; RS = 1
    CLR P3.1        ; RW = 0
    ACALL LCD_WRITE
    RET

;-------------------------------
; COMMON LCD WRITE PULSE
;-------------------------------
LCD_WRITE:
    MOV P2, A       ; Send A to LCD
    SETB P3.2       ; EN = 1
    ACALL DELAY
    CLR P3.2        ; EN = 0
    ACALL DELAY
    RET

;-------------------------------
; DISPLAY STRING FROM MSG
;-------------------------------
DISPLAY_MSG:
    MOV DPTR, #MSG
NEXT_CHAR:
    CLR A
    MOVC A, @A+DPTR
    JZ DONE_DISPLAY
    ACALL LCD_DATA
    INC DPTR
    SJMP NEXT_CHAR

DONE_DISPLAY:
    RET

;-------------------------------
; SIMPLE DELAY
;-------------------------------
DELAY:
    MOV R7, #200
D1: MOV R6, #255
D2: DJNZ R6, D2
    DJNZ R7, D1
    RET

;-------------------------------
; MESSAGE STRING
;-------------------------------
MSG: DB "Hi Silicon", 0

END
