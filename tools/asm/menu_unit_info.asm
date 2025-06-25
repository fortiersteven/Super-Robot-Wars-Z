.ps2
.open __SLPS_PATH__, 0x00FE580

; Unit Info, Pilot Info size ...
.org 0x0038A404
	li  a0, 0xC
	
.org 0x0038A4DC
	addiu v1,v1,-0xD8
	
; Reduce 6 Stats size
.org 0x0038A9DC
	li	a0, 0x13
	
; Reduce 4 Stats size
.org 0x0038B06C
	li	a0, 0x13
	
.org 0x0038AC18
	li	a0, 0x13
	
; Pilot Face Size
;.org 0x0038A8AC
;	addiu t2, zero, 0x28

; Pilot X Coord	
;.org 0x0038A9F8
;	addiu a3,zero,-0x110

; Stats Color
;.org 0x0038A8AC
;	addiu a0,zero,0x9
	
;.org 0x0038AA18
;	li a2, -0xB8
	
	
.close