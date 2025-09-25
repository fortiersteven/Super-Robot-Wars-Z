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
	li 	$a0, 0x0C
	
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
	addiu 	$s5, $v0, 0x16
	
	
;Adjust Bottom Stats Label Coord X to the Left
.org 0x0038BE98
	li 	$a2, 0x128
	
.org 0x0038BEB8
	li 	$a2, 0x128
	
.org 0x0038BEDC
	li 	$a2, 0x128

.org 0x0038BF00
	li 	$a2, 0x128
	
.close