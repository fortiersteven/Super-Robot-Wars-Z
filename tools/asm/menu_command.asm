.ps2
.open __SLPS_PATH__, 0x00FE580

; Bottom text size
.org 0x00351EE4
	li  a0, 0x0C

.org 0x00351EC0
	addiu	a1 ,s0 ,-0xE


; Top text size
;.org 0x003522B0
;	li	t0, 0xC
	
;Your game will be saved size
.org 0x003580dc
	li v1, 0x0C
	
.org 0x358654
	li $a0, 0x0C
	
.org 0x35865C
	li $a0, 0x0C
	
.org 0x3597A8
	li $v1, 0x010C
	
.org 0x3580DC
	li $v1, 0x0C
	
; Move Yes position
.org 0x35867C
	addiu 	$v0, $s0, -0x1C
	
; Move No position
.org 0x3586C8
	addiu 	$v0, $s0, 0x1C
	
.org 0x35995C
	li 	$v1, 0x5C
	
; Move positions of Enemies and \Enemies
.org 0x3518C4
	addiu 	$v0, $v0, 0x62
	
.org 0x3518D0
	addiu	$v0, $v0, 0x48
.close