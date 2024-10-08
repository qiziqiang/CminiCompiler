DSEG	SEGMENT
STORE	DW	4 DUP(?)
TEMP	DW	64 DUP(?)
DSEG	ENDS
SSEG	SEGMENT	STACK
FUNCST	DW	20 DUP(?)
SSEG	ENDS
CODE	SEGMENT
	ASSUME	CS:CODE
DISPLAY	PROC	FAR
MOV	CX,0
DISP1:	MOV	DX,0
DIV	BX
PUSH	DX
INC	CX
OR	AX,AX
JNE	DISP1
DISP2:	MOV	AH,02H
POP	DX
ADD	DL,30H
INT	21H
LOOP	DISP2
RET
DISPLAY	ENDP
CODE	ENDS
CSEG	SEGMENT
	ASSUME	CS:CSEG,DS:DSEG,SS:SSEG
START:
MOV	AX,DSEG
MOV	DS,AX
MOV	AX,SSEG
MOV	SS,AX
MOV	SI,OFFSET STORE
MOV	DI,OFFSET TEMP
MOV	SP,SIZE FUNCST
MOV	[SI+0],DX
MOV	DX,1
MOV	[SI+2],DX
MOV	DX,0
MOV	[SI+2],DX
CMP1:
MOV	BX,10
CMP	DX,BX
JBE	DX11
JA	DX01
DX11:
MOV	DX, 01H
JMP	CONTINUE1
DX01:
MOV	DX, 00H
JMP	CONTINUE1
CONTINUE1:
MOV	[DI+0],DX
MOV	DX,[DI+0]
CMP	DX,01H
JNE	END1
JE	START1
INC1:
MOV	BX,1
ADD	DX,BX
MOV	[SI+2],DX
JMP	CMP1
START1:
ADD	DX,BX
MOV	[SI+0],DX
JMP	INC1
END1:
MOV	BX,10
MOV	AX,[SI+0]
CALL	FAR PTR	DISPLAY
MOV	AH,4CH
INT	21H
CSEG	ENDS
	END	START
