2 REM CHOPPER FLIGHT BY MIKE BUHIDAR JR.AND KEVIN WORAM
4 CN=0:POKE832,0:BC=53280:GOTO12
6 PRINTTAB(10);
8 D=D-8:POKECP,D:POKEPL,192:FORW=1TO12:NEXT:POKEPL,193
10 GOSUB122:FORW=1TO12:NEXT:RETURN
12 M1=0:GOSUB258:GOSUB132:FA=3:D=215
14 POKEV,164:POKEV+31,0:GOSUB302
16 PRINT"[CLEAR][WHITE]ENTER SKILL LEVEL (1-6)"
18 RM=14:WS=11:GOSUB258
20 GETSL$:IFVAL(SL$)<1ORVAL(SL$)>6THEN20
22 GOSUB132
24 POKEV+31,0:LS=192:Q=4:M=88:U=83
26 BR$="[RIGHT][RIGHT][c 2][RVSON][c R][c E][c R][c E][c R][c E][c R][c E][c R][c E]":B2$="[RIGHT][RIGHT][c 2][RVSON][c R][c E][c R][c E][c R][c E][c R][c E][c R][c E]":HD=4-SL/3:GH=HD-1:MD=INT(GH*30)
28 WN$="[RIGHT][RIGHT][c 2][RVSON][c E][c R][c E][RVSOFF] [RVSON][c R][c E][c R][RVSOFF] [RVSON][c E][c R][RVSOFF][c 5][s O][c Y][c V]":W2$="[c 5][c C][c Y][s P][c 2][RVSON][c E][c R][c E][RVSOFF] [RVSON][c R][c E][c R][RVSOFF] [RVSON][c E][c R][RVSOFF]":IFHD>3THENHD=3
30 TR$="[RIGHT][RIGHT][c 2][RVSON][c E][c R][c E][c 5][4"[c Y]"][c 2][c R][c E][c R][RVSOFF]":OS$="[RIGHT][RIGHT][c 2][RVSON][c R][c E][c R][RVSOFF][4" "][RVSON][c E][c R][c E][RVSOFF]"
32 F$="[RIGHT][c 5][s @][RVSON][10" "][RVSOFF][s L][RVSOFF]":SB=13+(2*SL):POKEZ,PEEK(Z)AND239:TD=(7-SL)*10
34 PRINT"[CLEAR][5"[DOWN]"]":RF$="[RIGHT][c 5][s P][RVSON][10"[c P]"][RVSOFF][s O]":PRINTRF$SPC(RM)RF$:POKEV+1,Y:POKEV,X
36 GOSUB374
38 PRINT"[UP]"BR$SPC(N)BR$
40 FORP=1TO5:PRINTWN$SPC(WS)W2$:PRINTBR$SPC(N)BR$:PRINTB2$SPC(N)B2$:NEXT
42 POKEZ,PEEK(Z)OR16
44 TI$="[6"0"]":FORL4=1TOSB:FORK=1TOQ
46 PRINTWN$SPC(WS)W2$:GOSUB80
48 PRINTBR$SPC(N)BR$:GOSUB80
50 PRINTB2$SPC(N)B2$:GOSUB80:NEXT
52 MP=INT(RND(1)*2)*RM:PRINTTAB(13+MP)"[c 1][UP][s X]":NEXT
54 PRINTWN$SPC(WS)W2$:GOSUB80
56 PRINTTR$SPC(15)TR$:GOSUB80:FORK=1TO3:PRINTOS$SPC(15)OS$:GOSUB80:NEXT
58 PRINTOS$SPC(5)"[c 5][6"[c P]"]"SPC(4)OS$
60 PRINTF$SPC(4)"[c 5][6"[s W]"]"SPC(4)F$;
62 PRINT"[c 5] [39"[c Y]"]":GOSUB80
64 CP=833:FORP=PEEK(V+1)TO211STEP2:D=D+8:POKEV+1,P:GOSUB8:NEXT:POKEPL,193
66 PRINT"[HOME][YELLOW][18"[DOWN]"][15"[RIGHT]"]YOU DID IT!":FORM=1TO2000:NEXT
68 ZZ=VAL(TI$):FORHH=0TO1000:NEXT:POKEV,0:GOSUB358
70 PRINT"[WHITE][6" "]PRESS TRIGGER TO PLAY AGAIN."
72 B=PEEK(JL)AND16:IFB=0THEN76
74 GOTO72
76 CLR:GOTO16
78 REM JOYSTICK ROUTINE
80 FR=(PEEK(JL)AND16)/16+1:ONFRGOTO110,116
82 SP=192:XD=HD:YD=0:RETURN
84 SP=194:XD=-HD:YD=0:RETURN
86 SP=LS:XD=0:YD=0:RETURN
88 SP=LS:YD=-HD:XD=0:RETURN
90 SP=LS:YD=HD:XD=0:RETURN
92 SP=194:XD=-HD:YD=-HD:RETURN
94 SP=194:XD=-HD:YD=HD:RETURN
96 SP=192:XD=HD:YD=-HD:RETURN
98 SP=192:XD=HD:YD=HD:RETURN
100 RETURN
102 POKEBC,8:RETURN
104 POKEBC,2:RETURN
106 POKEHF,20:X1=X:POKEV+40,2:GOSUB284
108 REM SLOWER FALL
110 GOSUB122:FA=FA+2:IFFA>50THEN252
112 GOSUB240:RETURN
114 REM FASTER FALL
116 GOSUB122:IFFA<1THENFA=2
118 FA=FA-2:GOSUB240:RETURN
120 REM SOUND
122 POKEHF,7:POKELF,53:POKEHF,0:POKELF,0:POKEHF,7:POKELF,163:POKELF,0:POKEHF,0
124 FORG1=0TO(50-FA):NEXT
126 POKEHF,7:POKELF,53:POKEHF,0:POKELF,0:POKEHF,7:POKELF,163:POKELF,0:POKEHF,0
128 RETURN
130 SPRITE INITIALIZATION
132 PRINT"[CLEAR]":POKEBC,0:POKEBC+1,0
134 V=53248:PL=2040:POKEV+21,7:X=170:Y=100:SP=192:POKEV+39,15:POKEPL,SP
136 POKEPL+1,196:POKEV+40,12
138 POKEPL+2,197:POKEV+28,4:POKEV+41,8:POKEV+37,7:POKEV+38,2
140 POKEV+29,4:POKEV+23,4:PRINT"[CLEAR][WHITE]READING DATA[3"."]"
142 IFPEEK(12660)=150THEN148
144 R=12288:FORG=1TO6:FORI=1TO63:READA:DC=DC+A:POKER,A:R=R+1:NEXT:R=R+1:NEXT
146 IFDC<>27628THENPRINT"[CLEAR]ERROR IN DATA. . .":STOP
148 JL=56320:N=15:Z=53265:CD=53269
150 POKEZ,PEEK(Z)AND247:POKEZ,(PEEK(Z)AND248)+7:RETURN
152 REM SPRITE DATA
154 DATA0,0,0,0,0,0,0,0,0,1,255,255,0,1,0,0,7,192,0,31,240
156 DATA192,63,136,224,63,4,255,255,2,255,255,130,0,63,130,0,47,252,0,15,248
158 DATA0,6,248,1,4,17,1,140,27,0,255,254,0,0,0,0,0,0,0,0,0
160 DATA0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,7,192,0,31,240
162 DATA192,63,136,224,63,4,255,255,2,255,255,130,0,63,130,0,47,252,0,15,248
164 DATA0,6,248,1,4,17,1,140,27,0,255,254,0,0,0,0,0,0,0,0,0
166 DATA0,0,0,0,0,0,0,0,0,255,255,128,0,128,0,3,224,0,15,248,0
168 DATA17,252,3,32,252,7,64,255,255,65,255,255,65,252,0,63,248,0,31,240,0
170 DATA12,96,0,136,32,128,216,49,128,127,255,0,0,0,0,0,0,0,0,0,0
172 DATA0,0,0,0,0,0,0,0,0,0,128,0,0,128,0,3,224,0,15,248,0
174 DATA17,252,3,32,252,7,64,255,255,65,255,255,65,252,0,63,248,0,31,240,0
176 DATA12,96,0,136,32,128,216,49,128,127,255,0,0,0,0,0,0,0,0,0,0
178 DATA0,0,0,0,62,0,0,119,0,0,239,128,0,207,128,0,255,128,0,0,0
180 DATA0,127,0,0,127,0,0,127,0,0,62,0,0,62,0,0,62,0,0,28,0
182 DATA0,127,0,0,235,128,0,193,128,1,128,192,1,128,192,1,0,64,1,0,64
184 DATA0,20,0,0,85,0,1,150,64,5,105,80,5,170,80,38,170,152,42,170,168
186 DATA46,170,184,91,190,229,122,255,173,119,255,221,90,255,165,27,190,232
188 DATA46,170,184
190 DATA42,170,168,5,170,80,5,105,80,1,150,64,0,85,0,0,20,0,0,0,0
192 REM SPRITE-DATA COLLISION
194 XP=X-24:YP=Y-54:CX=INT(XP/8):CY=INT(YP/8):BB=1104+CX+(40*CY)
