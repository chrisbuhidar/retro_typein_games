(  PROGRAMMING IN THE IRQ INTERRUPT x  RUN THIS PROGRAM, THEN TYPE CHARACTERS IN UPPER LEFTHAND CORNER OF SCREEN Â  THE BORDER COLOR WILL CHANGE, DEPENDING ON SCREEN CODE OF CHARACTER 		  13-BYTE PROGRAM SETS UP THE INTERRUPT: 11-BYTE PROGRAM RUNS IT '	
  IČ5011 € 5023: A: I,A: G	  IČ5000 € 5010: A: I,A: R	  5011 X	(  	/   *** SYS CALL TO SET INTERRUPT VECTOR Î	0  BLOCK INTERRUPTS, SET VECTOR ADDRESS (LOW, HIGH), ENABLE INTERRUPTS  
1  SEI LDA#136 STA 788  LDA#19 STA 789 CLI RTS 1
2  120,169,136,141,20,3,169,19,141,21,3,88,96 U
9   *** ACTUAL INTERRUPT ROUTINE 
:  GET FIRST SCREEN CHARACTER; USE LOW NYBBLE TO SET BORDER COLOR Ä
;  LDA 1024 AND#15 STA 53280 JMP 59953 í
<  173,0,4,41,31,141,32,208,76,49,234   