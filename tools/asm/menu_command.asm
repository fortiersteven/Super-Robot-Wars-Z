.ps2
.open __SLPS_PATH__, 0x00FE580

; Bottom text size
.org 0x00351EE4
	li  a0, 0x0C

.org 0x00351EC0
	addiu	a1 ,s0 ,-0xE


; Top text size for Formation glitch
.org 0x00351094
	li	t1, 0x0
	
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
	
;Adjust Y alignment with first Command Menu
.org 0x35186C
	addiu 	$s0, $a3, -0x1
	
;Adjust Y alignment with second Command Menu
.org 0x353084
	addiu 	$s2, $a3, -0x1
; Move Yes position
.org 0x35867C
	addiu 	$v0, $s0, -0x24
	
; Move No position
.org 0x3586C8
	addiu 	$v0, $s0, 0x14
	
; Adjust / position
.org 0x358A54
	addiu 	$a1, $v0, -0x6
	
.org 0x35995C
	li 	$v1, 0x5C
	
; Move positions of Enemies and \Enemies
.org 0x3518C4
	addiu 	$v0, $v0, 0x62
	
.org 0x3518D0
	addiu	$v0, $v0, 0x48
	
.org 0x3530F0
	addiu 	$a1, $a1, -0x2
	
.org 0x351A28
	addiu 	$v1, $v1, 0x2
	
; Adjust size of Command Overlay / Bubble around text
.org 0x350818
	li 	$a1, 0x66
	
.org 0x3512FC
	li 	$a2, -0x10
	
.close