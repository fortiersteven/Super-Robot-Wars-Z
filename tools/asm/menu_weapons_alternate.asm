.ps2
.open __SLPS_PATH__, 0x00FE580

; Update sizes for Label and values
.org	0x391D8C
	li	$a0, 0x13
	
.org	0x39201C
	li	$a0, 0x13
	
; Adjust Labels X Coord
.org  	0x391DE4
	addiu 	$a2, $s0, 0x18
	
.org 	0x391E14
	addiu 	$a2, $s0, 0x1C
	
.org 	0x391E40
	addiu 	$a2, $s0, 0x22
	
; Remove icon
.org 	0x39208C
	nop
	
; Move values on the right
.org 	0x392048
	addiu	$s0, $s8, 0x80
	
; Adjust alignment for PLA/TRI/P stuff
.org 	0x3902C0
	addiu 	$v0, $v0, 0x62
	
.org 	0x39040C
	addiu 	$v1, $v0, 0x89
	
; Move Y Coord (PLA/TRI/MAP)
.org  	0x3920F4
	addiu 	$v1, $v1, 0xBA
	
; Move Y Coord (P)
.org 	0x392148
	addiu 	$s6, $v1, 0xC6
	
; MAP strings
; Move X Coord for Enemies Only
.org 	0x391ED4
	addiu 	$a2, $s8, 0x128
	
; Move X Coord for Type
.org 	0x391EFC
	addiu 	$a2, $s8, 0x1B8
	
; Move X Coord for Centered on Self
.org 	0x3921E8
	addiu 	$a1, $s8, 0x1E4
	
; Move X Coord for Yes/No valid
.org 	0x3921BC
	addiu 	$a1, $s8, 0x190
	
; Write Close-range
.org 	0x390078
	lui        v0,0x736F		;os
	sh         v1,0xc(s4)
	ori        v1,v0,0x6C43		;Cl
	swr        v1,0xe(s4)
	lui        v0,0x6172		;ra
	ori        s0,v0,0x2D65		;e-
	swl        v1,0x11(s4)
	swr        s0,0x12(s4)
	lui        v0,0x0065		;e	
	ori        v1,v0,0x676E		;ng
	swl        s0,0x15(s4)
	swr        v1,0x16(s4)
	lui        v0,0x0		;)		
	swl        v1,0x19(s4)
	ori        v0,v0,0x0		;(

; Write range
.org 	0x3900D0
    lui        v0,0x676E
    ori        v1,v0,0x6152
    lui        v0,0x0
    swr        v1,0xe(s4)	
    ori        s0,v0,0x0065
    swl        v1,0x11(s4)
    lui        v0,0x0
    swr        s0,0x12(s4)
    ori        v1,v0,0x0
    swl        s0,0x15(s4)
    lui        v0,0x0
    swr        v1,0x16(s4)
    ori        v0,v0,0x0




.close