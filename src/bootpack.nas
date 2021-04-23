[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_init_gdtidt
	EXTERN	_init_pic
	EXTERN	_io_sti
	EXTERN	_keyfifo
	EXTERN	_fifo8_init
	EXTERN	_mousefifo
	EXTERN	_io_out8
	EXTERN	_init_palette
	EXTERN	_init_screen8
	EXTERN	_init_mouse_cursor8
	EXTERN	_putblock8_8
	EXTERN	_sprintf
	EXTERN	_putfonts8_asc
	EXTERN	_io_cli
	EXTERN	_fifo8_status
	EXTERN	_fifo8_get
	EXTERN	_boxfill8
	EXTERN	_io_stihlt
	EXTERN	_io_in8
[FILE "bootpack.c"]
[SECTION .data]
LC0:
	DB	"(%d, %d)",0x00
LC2:
	DB	"[lcr %4d %4d]",0x00
LC3:
	DB	"(%3d, %3d)",0x00
LC1:
	DB	"%02X",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	MOV	EBX,2
	SUB	ESP,484
	CALL	_init_gdtidt
	CALL	_init_pic
	CALL	_io_sti
	LEA	EAX,DWORD [-348+EBP]
	PUSH	EAX
	PUSH	32
	PUSH	_keyfifo
	CALL	_fifo8_init
	LEA	EAX,DWORD [-476+EBP]
	PUSH	EAX
	PUSH	128
	PUSH	_mousefifo
	CALL	_fifo8_init
	PUSH	249
	PUSH	33
	CALL	_io_out8
	ADD	ESP,32
	PUSH	239
	PUSH	161
	CALL	_io_out8
	CALL	_init_keyboard
	CALL	_init_palette
	MOVSX	EAX,WORD [4086]
	PUSH	EAX
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_init_screen8
	MOVSX	EAX,WORD [4084]
	LEA	ECX,DWORD [-16+EAX]
	MOV	EAX,ECX
	CDQ
	IDIV	EBX
	MOV	EDI,EAX
	MOVSX	EAX,WORD [4086]
	PUSH	14
	LEA	ECX,DWORD [-44+EAX]
	MOV	EAX,ECX
	CDQ
	IDIV	EBX
	LEA	EBX,DWORD [-316+EBP]
	MOV	ESI,EAX
	PUSH	EBX
	CALL	_init_mouse_cursor8
	PUSH	16
	PUSH	EBX
	LEA	EBX,DWORD [-60+EBP]
	PUSH	ESI
	PUSH	EDI
	PUSH	16
	PUSH	16
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putblock8_8
	ADD	ESP,60
	PUSH	ESI
	PUSH	EDI
	PUSH	LC0
	PUSH	EBX
	CALL	_sprintf
	PUSH	EBX
	PUSH	7
	PUSH	0
	PUSH	0
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	LEA	EAX,DWORD [-492+EBP]
	ADD	ESP,40
	PUSH	EAX
	CALL	_enable_mouse
	POP	ECX
L2:
	CALL	_io_cli
	PUSH	_keyfifo
	CALL	_fifo8_status
	PUSH	_mousefifo
	MOV	EBX,EAX
	CALL	_fifo8_status
	LEA	EAX,DWORD [EAX+EBX*1]
	POP	EBX
	POP	EDX
	TEST	EAX,EAX
	JE	L18
	PUSH	_keyfifo
	CALL	_fifo8_status
	POP	ECX
	TEST	EAX,EAX
	JNE	L19
	PUSH	_mousefifo
	CALL	_fifo8_status
	POP	EDX
	TEST	EAX,EAX
	JE	L2
	PUSH	_mousefifo
	CALL	_fifo8_get
	MOV	EBX,EAX
	CALL	_io_sti
	MOVZX	EAX,BL
	PUSH	EAX
	LEA	EAX,DWORD [-492+EBP]
	PUSH	EAX
	CALL	_mouse_decode
	ADD	ESP,12
	TEST	EAX,EAX
	JE	L2
	PUSH	DWORD [-484+EBP]
	PUSH	DWORD [-488+EBP]
	PUSH	LC2
	LEA	EBX,DWORD [-60+EBP]
	PUSH	EBX
	CALL	_sprintf
	ADD	ESP,16
	MOV	EAX,DWORD [-480+EBP]
	TEST	EAX,1
	JE	L11
	MOV	BYTE [-59+EBP],76
L11:
	TEST	EAX,2
	JE	L12
	MOV	BYTE [-57+EBP],82
L12:
	AND	EAX,4
	JE	L13
	MOV	BYTE [-58+EBP],67
L13:
	PUSH	31
	PUSH	151
	PUSH	16
	PUSH	32
	PUSH	14
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_boxfill8
	PUSH	EBX
	PUSH	7
	PUSH	16
	PUSH	32
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	LEA	EAX,DWORD [15+ESI]
	ADD	ESP,52
	PUSH	EAX
	LEA	EAX,DWORD [15+EDI]
	PUSH	EAX
	PUSH	ESI
	PUSH	EDI
	PUSH	14
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_boxfill8
	ADD	ESP,28
	ADD	ESI,DWORD [-484+EBP]
	ADD	EDI,DWORD [-488+EBP]
	JS	L20
L14:
	TEST	ESI,ESI
	JS	L21
L15:
	MOVSX	EAX,WORD [4084]
	SUB	EAX,16
	CMP	EDI,EAX
	JLE	L16
	MOV	EDI,EAX
L16:
	MOVSX	EAX,WORD [4086]
	SUB	EAX,16
	CMP	ESI,EAX
	JLE	L17
	MOV	ESI,EAX
L17:
	PUSH	ESI
	PUSH	EDI
	PUSH	LC3
	PUSH	EBX
	CALL	_sprintf
	PUSH	15
	PUSH	79
	PUSH	0
	PUSH	0
	PUSH	14
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_boxfill8
	ADD	ESP,44
	PUSH	EBX
	PUSH	7
	PUSH	0
	PUSH	0
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	LEA	EAX,DWORD [-316+EBP]
	PUSH	16
	PUSH	EAX
	PUSH	ESI
	PUSH	EDI
	PUSH	16
	PUSH	16
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putblock8_8
	ADD	ESP,56
	JMP	L2
L21:
	XOR	ESI,ESI
	JMP	L15
L20:
	XOR	EDI,EDI
	JMP	L14
L19:
	PUSH	_keyfifo
	CALL	_fifo8_get
	MOV	EBX,EAX
	CALL	_io_sti
	PUSH	EBX
	LEA	EBX,DWORD [-60+EBP]
	PUSH	LC1
	PUSH	EBX
	CALL	_sprintf
	PUSH	31
	PUSH	15
	PUSH	16
	PUSH	0
	PUSH	14
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_boxfill8
	ADD	ESP,44
	PUSH	EBX
	PUSH	7
	PUSH	16
	PUSH	0
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	ADD	ESP,24
	JMP	L2
L18:
	CALL	_io_stihlt
	JMP	L2
	GLOBAL	_wait_KBC_sendready
_wait_KBC_sendready:
	PUSH	EBP
	MOV	EBP,ESP
L23:
	PUSH	100
	CALL	_io_in8
	POP	EDX
	AND	EAX,2
	JNE	L23
	LEAVE
	RET
	GLOBAL	_init_keyboard
_init_keyboard:
	PUSH	EBP
	MOV	EBP,ESP
	CALL	_wait_KBC_sendready
	PUSH	96
	PUSH	100
	CALL	_io_out8
	CALL	_wait_KBC_sendready
	PUSH	71
	PUSH	96
	CALL	_io_out8
	LEAVE
	RET
	GLOBAL	_enable_mouse
_enable_mouse:
	PUSH	EBP
	MOV	EBP,ESP
	CALL	_wait_KBC_sendready
	PUSH	212
	PUSH	100
	CALL	_io_out8
	CALL	_wait_KBC_sendready
	PUSH	244
	PUSH	96
	CALL	_io_out8
	MOV	EAX,DWORD [8+EBP]
	MOV	BYTE [3+EAX],0
	LEAVE
	RET
	GLOBAL	_mouse_decode
_mouse_decode:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	ESI
	PUSH	EBX
	MOV	EDX,DWORD [8+EBP]
	MOV	ECX,DWORD [12+EBP]
	MOV	ESI,ECX
	MOV	AL,BYTE [3+EDX]
	TEST	AL,AL
	JNE	L30
	CMP	CL,-6
	JE	L38
L37:
	XOR	EAX,EAX
L29:
	POP	EBX
	POP	ESI
	POP	EBP
	RET
L38:
	MOV	BYTE [3+EDX],1
	JMP	L37
L30:
	CMP	AL,1
	JE	L39
	CMP	AL,2
	JE	L40
	CMP	AL,3
	JE	L41
	OR	EAX,-1
	JMP	L29
L41:
	MOV	BL,BYTE [EDX]
	AND	ESI,255
	MOV	EAX,EBX
	MOV	BYTE [2+EDX],CL
	AND	EAX,7
	MOV	DWORD [8+EDX],ESI
	MOV	DWORD [12+EDX],EAX
	MOV	AL,BL
	MOVZX	ECX,BYTE [1+EDX]
	AND	EAX,16
	MOV	DWORD [4+EDX],ECX
	MOV	BYTE [3+EDX],1
	TEST	AL,AL
	JE	L35
	OR	ECX,-256
	MOV	DWORD [4+EDX],ECX
L35:
	AND	EBX,32
	TEST	BL,BL
	JE	L36
	OR	DWORD [8+EDX],-256
L36:
	NEG	DWORD [8+EDX]
	MOV	EAX,1
	JMP	L29
L40:
	MOV	BYTE [1+EDX],CL
	MOV	BYTE [3+EDX],3
	JMP	L37
L39:
	MOV	BYTE [EDX],CL
	MOV	BYTE [3+EDX],2
	JMP	L37
