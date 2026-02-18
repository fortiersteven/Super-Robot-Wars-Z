.ps2
.open __SLPS_PATH__, 0x00FE580

; Size for Mech Name
.org 0x2AF644
	li  $a0, 0x0C
	
; Size for Parts Name on the Left
.org 0x2AF6EC
	li 	$a0, 0x13
	
	
; Size for Available / Total parts
.org 0x2B0C98
	li	$a0, 0x13
	
; Size for Blue text with < >
.org 0x2B0D44
	li	$a0, 0x13
	
; Size for Red text
.org 0x2B0910
	li 	$a0, 0x0C
	
; Size of white lines for Parts on the right
.org 0x2B0B0C
	li 	$a0, 0x13
	
; Size of Parts name on the right
.org 0x2B099C
	li 	$a0, 0x13

; Size of Parts Effect on the right	
.org 0x2B0F38
	li 	$a0, 0x13
	
; X Coord for the effect
.org 0x2B0F6C
	li 	$a2, 0x146
	
; Space between lines
.org 0x2B0F84
	addiu $s3, $s3, 0x9
	
; Remove 3 white lines from screen
.org 0x425D68
	.byte 0xF0
	
.org 0x425C98
	.byte 0xF0
	
.org 0x425E30
	.byte 0xF0
	
; Rectangles size increase
.org 0x525C7C
	.byte 0x1D
	
; Rectangle Coord X
.org 0x425C76
	.byte 0x12
	
.close