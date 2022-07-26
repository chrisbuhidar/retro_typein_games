1 REM      ***  STARSHIP  ***
2 REM MACHINE LANGUAGE SPRITE MOVEMENT
4 REM ** MOVE TOP OF MEMORY TO MAKE ROOM FOR VIDEO BLOCK AT 32768
5 POKE 55,255:POKE 56,127:POKE 643,255:POKE 644,127:PRINT "[CLEAR]"
6 REM ** DECLARE PRIMARY VARIABLES
7 F$=" ":C0%=0:C1%=0:C2%=0:C3%=0:C4%=0:C5%=0:C6%=0:SP%=0
8 DEF FN PG(X)=INT(X/256):DEF FN LO(X)=X-256*(INT(X/256))
9 REM      *** SET-UP SUBROUTINES ***
10 GOSUB 90:GOSUB 600:REM (VIDEO MEMORY)
12 PRINT "[CLEAR]";:GOSUB 95:GOSUB 700:GOSUB 2000:REM (MACHINE LANGUAGE AND SPRITES)
13 GOSUB 900:REM (SPRITE POSITIONS AND GAME SCREEN)

14 SYS 38067:REM (START INTERRUPT!)

15 REM ** ENABLE SPRITES
16 FOR I=0 TO 29:NEXT:POKE ES,31:REM (SPRITES 0-4)
17 GOTO 100
19 REM ** LOAD SUBROUTINE
20 FOR I=XB TO XE:READ A:POKE I,A:NEXT:PRINT "[RVSON].[RVSOFF]";:RETURN
89 REM TURN OFF SCREEN
90 POKE 53265,0:RETURN
94 REM TURN ON SCREEN (AND EXTENDED BACKGROUND COLOR TEXT MODE)
95 POKE 53265,91:RETURN
98 REM      *** ACTION LOOP ***
100 K=PEEK(653):IF K=7 THEN 300
110 FOR I=1 TO 4:SP%=I:SYS 38336:NEXT
115 PRINT "[HOME][5" "][HOME][DOWN][6" "][HOME][DOWN][DOWN][6" "][HOME][3"[DOWN]"][5" "]"
120 ON C0% GOSUB 200:C0%=0:C4%=0:C5%=0:C6%=0
125 FOR I=1 TO 4:SP%=I:SYS 38336:NEXT
130 IF C1%>0 THEN GOSUB 220:C1%=0
135 IF C2%>0 THEN GOSUB 240:C2%=0
140 IF C3%>0 THEN GOSUB 260:C3%=0
196 GOTO 100
199 REM ** FIREBUTTON ROUTINE GOES HERE
200 PRINT "[HOME]F"
201 IF C4%=1 THEN PRINT "[HOME][RIGHT][RIGHT]!"
202 IF C5%>1 THEN PRINT "[HOME][4"[RIGHT]"]S"
203 IF C6%=1 THEN PRINT "[HOME][6"[RIGHT]"]F"
205 RETURN
220 PRINT "[HOME][3"[DOWN]"]EW"STR$(C1%):RETURN
239 REM ** SPR/SPR COLLISION ROUTINE
240 PRINT "[HOME][DOWN]CS"STR$(C2%):RETURN
259 REM ** SPR/FORE COLLISION ROUTINE
260 PRINT "[HOME][DOWN][DOWN]CF"STR$(C3%):RETURN
296 RETURN
298 REM    *** END HANDLING ***
299 REM ** PUT VIDEO MEMORY BACK TO FIRST BLOCK, AND SCREEN MEMORY TO 1024
300 GOSUB 90:POKE ES,0:REM DISABLE SPRITES
304 REM RESTORE VIDEO/SCREEN MEMORY
305 POKE 56578,PEEK(56578)OR3:POKE 56576,(PEEK(56576)AND 252)OR 3
306 I=PEEK(53272):POKE 53272, 20:K=PEEK(648):POKE 648,4
310 GOSUB 95:PRINT "[CLEAR]QUIT? ([RVSON][s Y][RVSOFF] OR [RVSON][s N][RVSOFF])":PRINT:PRINT
315 GET A$:IF A$="" THEN 315
320 IF A$="Y" THEN PRINT "[HOME]SO LONG, STAR PILOT!":GOTO 370
325 GOSUB 90:POKE 56578,PEEK(56578)OR3:POKE 56576,(PEEK(56576)AND 252)OR 1
330 POKE 53272,I:POKE 648,K:POKE ES,31:GOSUB 95:GOTO 100
370 FOR I= 0 TO 599:NEXT
379 REM ** REENABLE SHIFT/COMMODORE AND RUN-STOP/RESTORE
380 POKE 657,0:POKE 792,71:POKE 808,237
390 SYS 65126
598 REM    *** ARRANGE MEMORY ***
599 REM USE THIRD VIDEO BLOCK (32768 TO 49151), SO ROM CHARACTER SET IS USABLE.
600 VB=32768:POKE 56578,PEEK(56578)OR3:POKE 56576,(PEEK(56576)AND 252)OR 1
601 REM ** TELL VIC-2 WHERE SCREEN IS WITHOUT CHANGING CHARACTER SET LOCATION
602 SB=0:POKE 53272,(SB*16)+4:SB=VB+1024*SB
603 REM ** TELL BASIC WHERE SCREEN IS
604 BB=SB/256:POKE 648,BB
608 REM    *** REGISTER ADDRESSES ***
611 REM ** SPRITE COLOR TABLE
612 CT(0)=53287:FOR I=1 TO 7:CT(I)=CT(I-1)+1:NEXT
613 REM ** SPRITE HORIZONTAL POSITION TABLE (LOW BYTES)
614 HT(0)=53248:FOR I=1 TO 7:HT(I)=HT(I-1)+2:NEXT
615 REM ** SPRITE VERTICAL POSITION TABLE
616 VT(0)=53249:FOR I=1 TO 7:VT(I)=VT(I-1)+2:NEXT
617 REM ** SPRITE HORIZONTAL HIGH-BIT REGISTER
618 HR=53264
619 REM ** SPRITE ENABLE REGISTER
620 ES=53269
621 REM ** VERTICAL EXPANSION REGISTER (1=DOUBLE HEIGHT)
622 VE=53271
623 REM ** HORIZONTAL EXPANSION REGISTER (1=DOUBLE WIDTH)
624 HE=53277
625 REM ** SPRITE PRIORITY REGISTER (1=SPRITE IS IN FRONT OF FOREGROUND)
626 PR=53275
627 REM ** MULTICOLOR ENABLE REGISTER (1=MULTI-COLOR ENABLED)
628 EM=53276
629 REM ** SPRITE MULTICOLOR COLOR REGISTERS
630 MR=53285:REM ('01' REGISTER: ADD 1 TO MR FOR '11' REGISTER)
633 REM ** SET-BIT AND CLEAR-BIT VALUES
634 BS(0)=1:FOR I=1 TO 7:BS(I)=2*BS(I-1):NEXT
635 FOR I=0 TO 7:BC(I)=255-BS(I):NEXT
638 REM     *** INITIALIZE VALUES ***
639 REM ** FOREGROUND COLOR
640 POKE 53281,0:PRINT "[CLEAR][c 7]";:REM (LIGHT BLUE)
641 REM ** BACKGROUND COLOR
642 POKE 53281,0 :REM (BLACK)
643 REM ** BORDER COLOR
644 POKE 53280,0:REM (BLACK)
645 REM ** SPRITE COLORS (DEFAULTS: WHI,RED,L-GRN,PUR,GRN,BLU,YEL,M-GRAY)
646 POKE CT(0),7:POKE CT(1),5:POKE CT(2),2:POKE CT(3),6:POKE CT(4),12
647 REM ** SET PRIORITY
648 POKE PR,0:REM (ALL IN FRONT)
649 REM ** SET HORIZONTAL SIZES
650 POKE HE,0:REM (ALL SMALL)
651 REM ** SET VERTICAL SIZES
652 POKE VE,0:REM (ALL SMALL)
653 REM ** ENABLE SPRITES
654 POKE ES,0:REM (LEAVE THEM OFF FOR NOW)
655 REM ** ENABL MULTICOLOR FOR SPR 1-4
656 POKE EM,30
657 REM ** SET MULTI-COLORS 1 AND 3 (1=LIGHT GREY, 3=YELLOW)
658 POKE MR,15:POKE MR+1,7
659 REM       *** ML TABLE SETUP ***
660 REM ** ANIMATION TIMER (1=FASTEST)
661 POKE 37920,4:POKE 37921,4
662 REM ** ANIMATION COUNTER (ALWAYS 1)
663 POKE 37922,1
664 REM ** ANIMATE SPRITE 0? (1=YES)
665 POKE 37923,0

666 REM ** MOVEMENT TIMER (NUMBER OF INTERRUPTS BETWEEN MOVES [1=FASTEST])

667 POKE 37924,1:POKE 37925,1
668 REM ** ALL SPRITES WRAP AT SCREEN EDGE? (1=YES)
669 POKE 37936,1
670 REM ** SPRITE 0 BOUNCE OFF SPRITES? (1=YES)
671 POKE 37940,1
672 REM ** SPRITE 0 BOUNCE OFF FOREGROUND? (1=YES)
673 POKE 37941,0

674 REM ** GO-SPEED TIMER (NUMBER OF SPRITE 0 MOVES PER INTERRUPT [1=SLOWEST])

675 POKE 37926,3:POKE 37928,3
676 REM CLEAR FLAGS
677 POKE 37927,0:POKE 37935,0:POKE 37943,0
678 REM ** EXTENDED BACKGROUND COLORS
679 POKE 53282,1:POKE 53283,7:POKE 53284,9
683 REM ** SPRITE 0-7 BIT TABLE
684 X=1:FOR I=37962 TO 37969:POKE I,X:X=X*2:NEXT
693 REM     *** SAFETY PROCEDURES ***
694 POKE 657,128:REM DISABLE SHIFT/COMMODORE CHARACTER SET SWITCH
695 REM POKE 808,234:POKE 792,193:REM DISABLE STOP AND STOP/RESTORE
696 RETURN
699 REM *** INTRO SCREEN ***
700 PRINT "[CLEAR][5"[DOWN]"]"TAB(12)"[s S][s T][s A][s R][s S][s H][s I][s P][SS][s C][s A][s P][s T][s A][s I][s N]"
710 PRINT:PRINT TAB(6)"[RVSON][s Y][s O][s U][s R][SS][s C][s R][s A][s F][s T][SS][s I][s S][SS][s B][s E][s I][s N][s G][SS][s P][s R][s E][s P][s A][s R][s E][s D][RVSOFF]":PRINT:PRINT
796 RETURN
898 REM     *** SPRITE POSITIONS ***
899 REM ** POSSIBLE POSITIONS DIM'ED
900 FOR I=1 TO 4:POKE HT(I),20+INT(RND(9)*220)
901 POKE VT(I),50+INT(RND(9)*190):NEXT
902 POKE HR,0
909 REM ** PUT STARS ON THE SCREEN
910 PRINT "[CLEAR]";:FOR I= 0 TO 49:POKE VB+INT(RND(9)*1024),46:NEXT
915 FOR I= 0 TO 8:POKE VB+INT(RND(9)*1024),42:NEXT
919 REM ** STARSHIP POSITION
920 POKE 53248,175:POKE 53249,150
921 REM ** STARSHIP DIRECTION
922 POKE VB+1016,16
946 RETURN
1998 REM    *** MACHINE LANGUAGE ***
1999 REM ** STARTUP SYS ROUTINE
2000 POKE 37888,PEEK(788):POKE 37889,PEEK(789)
2002 XB=38067:XE=38079:GOSUB 20
2003 REM BLOCK INTERR, SET VECTOR TO ANIMATION SHELL,ENABLE INTERR
2004 REM SEI LDA #0 STA 788 LDA #149 STA 789 CLI RTS
2005 DATA 120,169,0,141,20,3,169,149,141,21,3,88,96
2019 REM   *** ANIMATION SHELL ***
2020 XB=38144:XE=38176:GOSUB 20
2021 REM SEE IF TIMER CALLS FOR ANIMATION OR MOVEMENT
2022 REM DEC 37920 BEQ+3 JMP(37898)
2023 DATA 206,32,148,240,3,108,10,148
2024 REM RESET ANIMATION TIMER
2025 REM LDA 37921 STA 37920
2026 DATA 173,33,148,141,32,148
2027 REM  GET NEXT STEP IN ANIMATION SEQUENCE
2028 REM DEC 37922 BNE+5 LDA#8 STA 37922 LDX 37922 DEX
2029 DATA 206,34,148,208,5,169,8,141,34,148,174,34,148,202
2030 REM IF CALLED FOR, ANIMATE #0
2031 REM LDA 37923 BEQ+6
2032 DATA 173,35,148,240,6
2033 REM ANIMATE ALL SPRITES
2034 REM LDA ANIM.SEQ.TAB,X STA SPRITE.SHAPE.TAB
2035 A=192:B=248:FOR I=38177 TO 38219 STEP 6:POKE I,189:POKE I+1,A:POKE I+2,148
2036 POKE I+3,141:POKE I+4,B:POKE I+5,131:A=A+8:B=B+1:NEXT
2037 REM EXIT THROUGH MOVEMENT HANDLER
2038 REM JMP (37898)
2039 POKE 38225,108:POKE 38226,10:POKE 38227,148
2049 REM *** MOVEMENT COUNTER ***
2050 XB=38272:XE=38288:GOSUB 20
2051 X=38272:POKE 37896,FN LO(X):POKE 37897,FN PG(X):REM SET COUNTER ADDRESS
2052 POKE 37898,FN LO(X):POKE 37899,FN PG(X):REM MOVE.VECT.=JOYDIR
2053 REM DECREMENT TIMER; IF NOT 0, GO FINISH UP
2054 REM DEC 37924 BEQ+3 JMP(37900)
2055 DATA 206,36,148,240,3,108,12,148
2056 REM RESET TIMER AND JUMP TO READ ROUTINE THROUGH VECTOR SET FROM BASIC
2057 REM LDA 37925 STA 37924 JMP(37890)
2058 DATA 173,37,148,141,36,148,108,2,148
2059 REM ** BITSET SUBROUTINE **
2060 XB=38314:XE=38323:GOSUB 20
2061 REM GET BITMASK AND PUT IT IN HORIZONTAL HI-BIT REGISTER
2062 REM LDA 37962,Y ORA 53264 STA 53264 RTS
2063 DATA 185,74,148,13,16,208,141,16,208,96
2069 REM ** BITCLEAR SUBROUTINE **
2070 XB=38324:XE=38335:GOSUB 20
2071 REM GET BITMASK, REVERSE IT, AND PUT IT IN HORIZONTAL HI-BIT REGISTER
2072 REM LDA 37962,Y EOR#255 AND 53264 STA 53264 RTS
2073 DATA 185,74,148,73,255,45,16,208,141,16,208,96
2099 REM      *** XMOVE ***
2100 XB=38400:XE=38467:GOSUB 20
2101 REM TEST FOR UPMOVE
2102 REM LDA#1 AND 37963,Y BEQ+3 JSR 38528
2103 DATA 169,1,57,75,148,240,3,32,128,150
2107 REM TEST FOR DOWNMOVE
2108 REM LDA#2 AND 37963,Y BEQ+3 JSR 38592
2109 DATA 169,2,57,75,148,240,3,32,192,150
2117 REM TEST FOR LEFTMOVE AND HI-BIT
2118 REM LDA#4 AND 37963,Y BEQ+17 LDA 37962,Y AND 53264 BEQ+6
2119 DATA 169,4,57,75,148,240,17,185,74,148,45,16,208,240,6
2120 REM DO EITHER LEFTSET OR LEFTCLEAR
2121 REM JSR 38656 JMP 38444 JSR 38720
2122 DATA 32,0,151,76,44,150,32,64,151
2126 REM TEST FOR RIGHTMOVE AND HI-BIT
2127 REM LDA#8 AND 37963,Y BNE+1 RTS LDA 37962,Y AND 53264 BEQ+4
2128 DATA 169,8,57,75,148,208,1,96,185,74,148,45,16,208,240,4
2129 REM DO EITHER RIGHTSET OR RIGHTCLEAR
2130 REM JSR 38784 JMP 38515 JSR 38848 RTS
2131 DATA 32,128,151,96,32,192,151,96
2139 REM   *** UPMOVE SUBROUTINE ***
2140 XB=38528:XE=38561:GOSUB 20
2141 REM GET VERT.LOC.,DECREMENT,CHECK EDGE,STORE NEW VERT.LOC.
2142 REM LDX 53249,Y DEX TXA CMP 37978,Y BNE+3 JSR 38546 TXA STA 53249,Y RTS
2143 DATA 190,1,208,202,138,217,90,148,208,3,32,146,150,138,153,1,208,96
2144 REM * TOPCHECK
2145 REM LDA 37936 BNE+4 INX JMP 38391 LDX 37979,Y DEX JMP 38391
2146 DATA 173,48,148,208,4,232,76,247,149,190,91,148,202,76,247,149
2159 REM   *** DOWNMOVE SUBROUTINE ***
2160 XB=38592:XE=38625:GOSUB 20
2161 REM GET VERT.LOC.,INCREMENT,CHECK EDGE,STORE NEW VERT.LOC.
2162 REM LDX 53249,Y INX TXA CMP 37979,Y BNE+3 JSR 38610 TXA STA 53249,Y RTS
2163 DATA 190,1,208,232,138,217,91,148,208,3,32,210,150,138,153,1,208,96
2164 REM * BOTTOMCHECK
2165 REM LDA 37936 BNE+4 DEX JMP 38391 LDX 37978,Y INX JMP 38391
2166 DATA 173,48,148,208,4,202,76,247,149,190,90,148,232,76,247,149
2179 REM *** LEFTMOVE (HI BIT SET) ***
2180 XB=38656:XE=38669:GOSUB 20
2181 REM GET HORIZ LOC, DECREMENT, CHECK CROSSOVER, STORE AND RETURN
2182 REM LDX 53248,Y DEX BPL+3 JSR 38324 TXA STA 53248,7 RTS
2183 DATA 190,0,208,202,16,3,32,180,149,138,153,0,208,96
2199 REM *** LEFTMOVE (HI BIT CLR) ***
2200 XB=38720:XE=38756:GOSUB 20
2201 REM GET HORIZONTAL POSITION, DECREMENT; IF EDGE, MOVE AND LEAVE
2202 REM LDX 53248,Y DEX TXA CMP 37994,Y BNE+3 JSR 38738 TXA STA 53248,Y RTS
2203 DATA 190,0,208,202,138,217,106,148,208,3,32,82,151,138,153,0,208,96
2204 REM *** LEFT CHECK
2205 REM LDA 37936 BNE+4 INX JMP 38391 LDX 37995,Y DEX JSR 38314 JMP 38391
2206 DATA 173,48,148,208,4,232,76,247,149,190,107,148,202,32,170,149,76,247,149
2219 REM *** RIGHTMVE (HI BIT SET) ***
2220 XB=38784:XE=38820:GOSUB 20
2221 REM GET HORIZONTAL POSITION, INCREMENT; IF EDGE, MOVE AND LEAVE
2222 REM LDX 53248,Y INX TXA CMP 37932,Y BNE+3 JSR 38802 TXA STA 53248,Y RTS
2223 DATA 190,0,208,232,138,217,107,148,208,3,32,146,151,138,153,0,208,96
2224 REM *** RIGHT CHECK
2225 REM LDA 37936 BNE+4 DEX JMP 38391 LDX 37994, Y INX JSR 38324 JMP 38391
2226 DATA 173,48,148,208,4,202,76,247,149,190,106,148,232,32,180,149,76,247,149 
2239 REM *** RIGHTMVE (HI BIT CLR) ***
2240 XB=38848:XE=38861:GOSUB 20
2241 REM GET HORIZ LOC, INCREMENT, CHECK CROSSOVER, STORE AND RETURN
2242 REM LDX 53248, Y INX BNE+3 JSR 38314 TXA STA 53248, Y RTS
2243 DATA 190,0,208,232,208,3,32,170,149,138,153,0,208,96
2399 REM *** BASIC MOVEMENT HANDLER ***
2400 XB=38336:XE=38346:GOSUB 20
2401 REM SET Y TO OFFSET OF SELECTED SPRITE
2402 REM LDY#59 LDA(45)Y TAX LDY 37944, X JMP 38400
2403 DATA 160,59,177,45,170,188,56,148,76,0,150

2469 REM ** REPORT NON-SPRITE-0 WRAPS AND EDGES TO BASIC

2470 XB=38391:XE=38399:GOSUB 20
2471 REM WAS IT SPRITE 0? IF NOT, REPORT WRAP
2472 REM CPY#0 BNE+1 RTS STY 37943 RTS
2473 DATA 192,0,208,1,96,140,55,148,96
2499 REM *** READ JOYSTICK ***
2500 XB=38912:XE=38972:GOSUB 20
2501 REM SET READ VECTOR TO POINT TO JOYSTICK ROUTINE 
