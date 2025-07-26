.ps2
.open __SLPS_PATH__, 0x00FE580

; Unit Info, Pilot Info size ...
.org 0x0039285C
	li  a0, 0x13
	
.close