ORG 00H

MAIN:   
        SETB P2.0       
        ACALL DELAY     
        CLR P2.0        
        ACALL DELAY    
        SJMP MAIN       

DELAY:  
        MOV R7, #255    
D1:     MOV R6, #255    
D2:     DJNZ R6, D2     
        DJNZ R7, D1     
        RET             

END