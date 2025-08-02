.ps2
.open __SLPS_PATH__, 0x00FE580

; Reduce size
.org 0x0037CC3C
	li  a0, 0x13
	
.org 0x0037CE7C
	li  a0, 0x13
	
.close