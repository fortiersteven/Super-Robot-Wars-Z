.ps2
.open __SLPS_PATH__, 0x00FE580

; Squad Label Size
.org 0x38CABC
	li 	$a0, 0xC
	
; Squad Number Move to the right text
.org 0x38CB14
	li 	$a2, -0xF0
	
; Squad Logo Move to the right text
.org 0x38CB34
	li 	$a3, -0xCD

; All Stats Label Size	
.org 0x0038CBC8
	li 	$a0, 0x13
	
; Stats Values Size
.org 0x0038CD50
	li  $a0, 0x13
	
; Stats bottom left Move X position on the left
.org 0x0038CBEC
	li  $a2, -0x11A
.org 0x0038CC0C
	li  $a2, -0x11A
.org 0x0038CC30
	li  $a2, -0x11A
.org 0x0038CC54
	li  $a2, -0x11A
.org 0x38CC78
	li 	$a2, -0x11A
	
; Parts/Abilities Label Size
.org 0x38D21C
	li 	$a0, 0xC
	
; Parts Values Size
.org 0x38D280
	li 	$a0, 0x13
	
; Abilities Values Size
.org 0x38d33c
	li 	$a0, 0x13

; Parts Label X Position	
.org 0x38D240
	li 	$a2, 0x28
	
; Abilities Label X position
.org 0x38D260
	li	$a2, 0xC6
	
.close