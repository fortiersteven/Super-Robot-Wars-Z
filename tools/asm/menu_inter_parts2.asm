.ps2
.open __SLPS_PATH__, 0x00FE580

; Size for Parts Name
.org 0x2B21D0
	li  $a0, 0x0C
	
; Size for Parts Name in Red
.org 0x2B2314
	li  $a0, 0x13
	
; Size for Parts Name in the black rectangle
.org 0x2B22E8
	li  $a0, 0x13
	
; Size for 3 labels for Mech
.org 0x2B23E8
	li 	$a0, 0x13
	
; Size for Mech names
.org 0x2B2524
	li 	$a0, 0x13
.close