ORG 0000H         ; Reset vector
LJMP MAIN         ; Jump to main program

ORG 0003H         ; External Interrupt 0 vector (INT0)
LJMP ISR_INT0     ; Jump to Interrupt Service Routine


MAIN:
    MOV P1, #00H      ; Clear Port 1 (LED off)
    SETB IE.7         ; Enable global interrupts (EA)
    SETB IE.0         ; Enable External Interrupt 0 (EX0)
    CLR TCON.0        ; Trigger INT0 on low level (can use SETB for edge)
    CLR TCON.1        ; Level-triggered (or use SETB for edge-triggered)

WAIT_LOOP:
    SJMP WAIT_LOOP    ; wait for interrupt


ISR_INT0:
    CPL P1.0          ; Toggle LED connected to P1.0
    RETI              ; Return from interrupt

END
