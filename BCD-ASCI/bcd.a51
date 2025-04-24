ORG 0000H

HIGH_BYTE:
MOV A, #45H         
ANL A, #0F0H        
SWAP A              
ADD A, #30H         
MOV R5, A
MOV P1, R5          

LOW_BYTE:
MOV A, #45H
ANL A, #0FH         
ADD A, #30H         
MOV R6, A
MOV P2, R6          

HERE:
SJMP HERE           

END
