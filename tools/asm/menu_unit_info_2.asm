.ps2
.open __SLPS_PATH__, 0x00FE580

;LV, SP, ... Size
.org 0x0038BB24
	li 	$a0, 0x0C
	
.org 0x0038BB90
	li 	$a0, 0x0C
	
.org 0x0038BCB4
	li 	$a0, 0x0C
	
	

	
;Captain Effect Label
.org 0x0038BBc0
	li 	$a0, 0x0C
	
;Captain Effect Value
.org 0x0038BD54
	li 	$a0, 0x13
	
;Mech Name
.org 0x0038BDCC
	li 	$a0, 0x0C
	
;Pilot Name
.org 0x0038BC28
	li 	$a0, 0x0C
	
;Bottom Left Stats
.org 0x0038BD54
	li 	$a0, 0x13
	
.org 0x0038BF20
	li 	$a0, 0x0C
	
;Stats Quadrant
.org 0x0038C254
	li 	$a0, 0x13
	
.org 0x0038C364
	li 	$a0, 0x0C
	
.org 0x0038C5FC
	li 	$a0, 0x0C
	
;Abilities spacing
.org 0x0038C770
	addiu	$s5, $s5, 0x8
	
.org 0x0038C734
	addiu 	$s5, $v0, 0x15
	
	
;4 Bottom Stats Label Coord X to the Left

.org 0x38BE74
	li 	$a0, 0x13

.org 0x0038BE98
	li 	$a2, -0x128
	
.org 0x0038BEB8
	li 	$a2, -0x128
	
.org 0x0038BEDC
	li 	$a2, -0x128

.org 0x0038BF00
	li 	$a2, -0x128
	
	
; Spider Web with Stats
; ACC
.org 0x38C28C
	li 	$a2, 0xCA
	
.org 0x38C290
	li 	$a3, -0x42
; RNG
.org 0x38C2AC
	li 	$a2, 0x106

.org 0x38C2B0
	li 	$a3, -0x36
	
; EVA
.org 0x38C2D0
	li 	$a2, 0x106
	
; SKL 
.org 0x38C2F4
	li 	$a2, 0xCA
	
.org 0x38C2F8
	li 	$a3, -0xC

; DEF
.org 0x38C318
	li $a2, 0x8F

; CQB
.org 0x38C33C
	li 	$a2, 0x8F
	
.org 0x38C340
	li 	$a3, -0x36
	
; Abilities Section

; Abilities Size
.org 0x38C63C
	li 	$a0, 0x13
	
.org 0x38C6AC
	li	$a3, 0x8A
	
.org 0x38C744
	li 	$a1, 0x8A
	
; Adjust spacing between lines
.org 0x38C728
	sll		$v0, $v1, 3
	nop
	nop
	
.org 0x38C7E8
	li 	$a3, 0x8A
	
.org 0x38C7B4
	li 	$a2, 0x72
.close