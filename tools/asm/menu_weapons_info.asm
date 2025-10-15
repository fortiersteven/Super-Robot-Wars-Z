.ps2
.open __SLPS_PATH__, 0x00FE580

; Weapon Stats size
.org 0x003924DC
	li  a0, 0x13

.org 0x392510
    addiu s7 ,s8 ,0x2E
	
; Hits and CRT Label
.org 0x003925D4
	li  a0, 0x13
	
.org 0x00392668
	li  a0, 0x13
	
.org 0x00392A3C
	li 	$a0, 0x13
	
.org 0x00392A7C
	li 	$a0, 0x13
	
.org 0x003925E0
    addiu s6 ,s8 ,0x2E

; Weapon Name Size
.org 0x0039285C
	li  a0, 0x13
	
; Move Weapon to the left
.org 0x003928D0
	addiu	a1, s0, 0x22
	
.org 0x003928D4
	addiu 	a2, s7, 0x1
	
; Move Icon to the left
.org 0x00392890
	addiu	v0 ,s0 ,0x6

	

	
;Draw_Weapon_Info_Left
.org 0x391594
	li  a0, 0x0C
	
.org 0x39167C
	li  a0, 0x13
	
.org 0x3916E4
	li  a0, 0x13
	
.org 0x39171C
	li  a0, 0x13
	
.org 0x3918AC
	li  a0, 0x13
	
.org 0x391AA0
	li  a0, 0x13
.close