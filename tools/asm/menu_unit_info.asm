.ps2
.open __SLPS_PATH__, 0x00FE580

; Unit Info, Pilot Info size ...
.org 0x38A404
	li  $a0, 0xC

; Unit Info, Pilot Info, X position offset
;.org 0x0038A4DC
;	addiu v1,v1,-0xD8
	
; Pilot Name size
.org 0x38AAC8
	li 	$a0, 0xC
	
; Mech Name size
.org 0x38AFC4
	li	$a0, 0xC 
	
; LV / Will / SP Label
.org 0x38A94C
	li  $a0, 0xC
	
; LV / Will / SP Values
.org 0x38AB54
	li  $a0, 0xC
	

	
; Reduce 4 Stats Label size
.org 0x38B06C
	li	$a0, 0x13
	
; Reduce 4 Stats Values 
.org 0x38B118
	li 	$a0, 0x0C
	
.org 0x38AF3C
	li 	$a0, 0x13
	

;Adjust 6 Stats positions

; Reduce 6 Stats Label
.org 0x38A9DC
	li	$a0, 0x13

; Reduce 6 Stats Values
.org 0x38AC18
	li	$a0, 0x13
	
	
; Adjust first 2 labels	
.org 0x0038A9F8
	li 	$a2, -0xAC
	
.org 0x0038AA18
	li 	$a2, -0xAC
	
; Adjust 2 next labels
.org 0x0038AA3C
	li  $a2, -0x4E
	
.org 0x0038AA60
	li  $a2, -0x4E

; Last 2 labels	
.org 0x0038AA84
	li  $a2, 0x8
	
.org 0x0038AAA8
	li  $a2, 0x8
	
;Adjust Skills / Abilities / Parts displaying
;0xBDBD44 for size of the rectangle
;0xBDBD40 for X position

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

; Skills displayed size
.org 0x38B4D4
	li	$a0, 0x13
	
; Skills Start X
.org 0x38B568
	li	$a3, 0x8A
	
; Parts / Abilities displayed size
.org 0x38B74C
	li 	$a0, 0x13

; Abilities Start Y
.org 0x38B76C
	li 	$s2, 0x18
	
; Adjust Abilities Start X
.org 0x38B7BC
	li 	$a3, 0x8A
	
.org 0x38B854
	li 	$a1, 0x8A
	
	
; Space between Abilities
.org 0x38B7F4
	addiu	$s2, $s2, 0x8
	
; Adjust the code so that the ------ line for Abilities Y coord 
; is calculated using 8 instead of 10
.org 0x38B838
	sll		$v0, $v1, 3
	nop
	nop

; Parts Start X
.org 0x38B8C0
	li	$a3, 0x8A

; Parts Start Y
.org 0x38B89C
	li 	$s2, 0x45
	
; Space between Parts
.org 0x38B8D8
	addiu	$s2, $s2, 0x8
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
	

	

	

	
	
.org 0x0038BA94
	li	$a3, 0x0

	
	
.close