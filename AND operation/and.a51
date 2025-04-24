 ORG 000H
    	MOV R0, #0x5A    
        MOV R1, #0x3C   

        MOV A, R0        
        ANL A, R1        
        MOV P2, A        

        SJMP $   
END			