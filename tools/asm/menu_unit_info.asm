.ps2
.open __SLPS_PATH__, 0x00FE580

; Unit Info, Pilot Info size ...
.org 0x0038A404
	li  a0, 0xC
	
.org 0x0038A94C
	li  a0, 0xC
	
.org 0x0038B314
	li  a0, 0x13
	
	
.org 0x0038A4DC
	addiu v1,v1,-0xD8
	
.org 0x0038A9F8
	li 	$a2, -0xA9
	
.org 0x0038AA18
	li 	$a2, -0xA9
	
.org 0x0038AA3C
	li  $a2, -0x5F
	
.org 0x0038AA60
	li  $a2, -0x5F
	
.org 0x0038AA84
	li  $a2, 0xB
	
.org 0x0038AAA8
	li  $a2, 0xB
	
;Adjust Skills / Abilities / Parts displaying

;Adjust size to 0xC
.org 0x0038B44C
	li	$a0, 0xC

;Adjust Skills Y Coord
.org 0x0038B474
	li 	$a3, -0x41
	
;Adjust Y spacing for Skills on the right
.org 0x0038B580
	addiu	$s2, $s2, 0x8
	
;Adjust Y starting offset
.org 0x0038B4E8
	addiu 	$s2, zero, -0x38
	
.org 0x0038B880
	addiu 	$s2, $s2, 0x8
	
	
.org 0x0038B844
	addiu 	$s2, $v0, 0x15

;Moving Stats name 0x20 to the left
;.org 0x003A6DF8
;	addiu	s0, s2, 0x10A			
	
;.org 0x003A6E48
;	addiu	s6, s2, 0x198		
	

	
;Moving Stats value 0x20 to the left
;.org 0x003A6F2C
;	addiu	s6, s2, 0x152			;Removing 0x20
	
;.org 0x003A6F80
;	addiu	s2, s2, 0x210	
	
; Reduce 6 Stats size
.org 0x0038A9DC
	li	a0, 0x13
	
; Reduce 4 Stats size
.org 0x0038B06C
	li	a0, 0x13
	
.org 0x0038AC18
	li	a0, 0x13
	
	
.org 0x0038BA94
	li	$a3, 0x0
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