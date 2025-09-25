.ps2
.open __SLPS_PATH__, 0x00FE580

;Adjust size to 0x0C
.org 0x003A65B0
	li	$a0, 0x0C

.org 0x003A65FC
	li	$a0, 0x0C
	
.org 0x003A6B80
	li	$a0, 0x13
		
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