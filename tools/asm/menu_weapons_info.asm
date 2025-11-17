.ps2
.open __SLPS_PATH__, 0x00FE580

; Weapon Stats size
.org 0x003924DC
	li  a0, 0x13

; Adjust Y Coord to be more aligned
.org 0x392510
    addiu s7 ,s8 ,0x2E
	
.org 0x00392930
	addiu a2, s4, 0x1
	
	

	
;.org 0x00392A3C
;	li 	$a0, 0x13
	
;.org 0x00392A7C
;	li 	$a0, 0x13
	


; Weapon Name Size
.org 0x0039285C
	li  a0, 0x13
	
; Move Weapon to the left
.org 0x003928D0
	addiu	a1, s0, 0x22
	
.org 0x003928D4
	addiu 	a2, s7, 0x1
	
; Move Weapon Icon to the left
.org 0x00392890
	addiu	v0 ,s0 ,0x6

; Move Attack Power stats
;.org 0x392928
;	addiu 	v1, s0, 0x1D8
	
; Move Range stats 
;.org 0x3929C0
;	addiu	a1, s0, 0x1DB

	

	
;Draw_Weapon_Info_Left
.org 0x391594
	li  a0, 0x13
	
.org 0x39167C
	li  a0, 0x13
	
.org 0x3916E4
	li  a0, 0x13
	

	
.org 0x3918AC
	li  a0, 0x13
	

	
; Move the 5 labels to the left
.org 0x03915C8
	addiu	s1, v0, 0x25
	
; Adjust position of Special effects and Upgrade
.org 0x3916A8
	addiu	s3, v0, 0x12F

; Terrain Type Icons + Values Settings
; Size for Terrain Type Value
.org 0x391AA0
	li  a0, 0x1C
	
; Move Terrain Type Values
.org 0x391AC8
	addiu	a1, v0, 0x9A
	
; Size for Terrain Icons
.org 0x39171C
	li  a0, 0x1C
	
	
	
; Draw_Weapon_Info_Top	

; Move Weapon Name Label
.org 0x39251C
	addiu 	a2, s4, 0x1E
	
; Move Class Label
.org 0x392540
	addiu 	a2, s4, 0x11F
	
; Move Type Label
.org 0x392564
	addiu 	a2, s4, 0x15A

; Move Atk PWR Label	
.org 0x392588
	addiu 	a2, s4, 0x19F
	
; Move Range Label
.org 0x3925B0
	addiu 	a2, s4, 0x1DB
; Move CRT Label
.org 0x39260C
	addiu 	a2, s4, 0x24E
	
; Hits and CRT Label Size
.org 0x003925D4
	li  a0, 0x13
	
.org 0x00392668
	li  a0, 0x13
	
;Adjust Y Coord for CRT and ACC
.org 0x003925E0
    addiu s6 ,s8 ,0x2E
	
.close