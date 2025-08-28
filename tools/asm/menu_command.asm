.ps2
.open __SLPS_PATH__, 0x00FE580

; Bottom text size
.org 0x00351EE4
	li  a0, 0x0C

; Top text size
;.org 0x003522B0
;	li	t0, 0xC
	
;Your game will be saved size
.org 0x003580dc
	li v1, 0x13
	
.close