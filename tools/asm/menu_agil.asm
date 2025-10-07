.ps2
.open __SLPS_PATH__, 0x00FE580

;Adjust size to 0x0C
.org 0x003A65B0
	li	$a0, 0x0C

.org 0x003A65FC
	li	$a0, 0x0C
	
.org 0x003A6B80
	li	$a0, 0x13
	
;4 stats Defense, Evasion, HP, EN ...
;Header Size
.org 0x003A6DAC
	li 	$a0, 0x13
	
;Value size
.org 0x003A6F20
	li 	$a0, 0x13
	
;Move headers X Coord on the left for the first 2
.org 0x003A6DF4
	addiu	$s1, $s3, 0x59
	
;Move values X Coord on the left for the first 2 stats
.org 0x003A6F2C
	addiu 	$s6, $s2, 0x150
	
;Move second set of headers X Coord on the left
.org 0x003A6E48
	addiu 	$s6, $s2, 0x1B6
		
.org 0x003A6F80
	
;Robot Name
.org 0x003A6684	
	li	$a0, 0x13
	
;Truc en haut avec les crochets []
.org 0x003A66CC
	li	$a0, 0x0C
	
.org 0x003A6924
	li	$a0, 0x0C

;Unknown
.org 0x003A67E4
	li	$a0, 0x0C
	
	
;Draw_Agility_Stats Function
;Stats Text size
.org 0x003A6DAC
	li	$a0, 0x0C
	
.org 0x003A6F20
	li	$a0, 0x0C
	
.org 0x003A6EA4
	li	$a0, 0x0C
	
;Blue Rectangle

.org 0x003A72D4
	li 	$a0, 0x0C
	
.org 0x003A736C
	li	$a0, 0x13

.close