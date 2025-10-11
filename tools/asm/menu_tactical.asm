.ps2
.open __SLPS_PATH__, 0x00FE580

;Adjust size to 0x0C
.org 0x0037CC3C
	li	$a0, 0x0C

.org 0x0037CE78
	li 	$a0, 0x0C
	
;Shift all 6 text labels to right align everything
.org 0x0037CC88
	li 	$a2, -0xE2
	
.org 0x0037CCB0
	li 	$a2, -0xF0
	
.org 0x0037CCE0
	li 	$a2, -0xE5
	
.org 0x0037CD0C
	li 	$a2, -0xEA
	
.org 0x0037CD38
	li 	$a2, -0xCE
	
.org 0x0037CD64
	li 	$a2, -0xD6
	
	
	

;Shift all values to the right to have more space
;for the first 6 regular stats
.org 0x0037CF04
	li 	$a1, -0xA

.org 0x0037CF28
	li 	$a1, -0xA

.org 0x0037CF4C
	li 	$a1, -0xA
	
.org 0x0037CF68
	li 	$a1, -0xA
	
.org 0x0037CF8C
	li 	$a1, -0xA
	
.org 0x0037CFB0
	li 	$a1, -0xA
	
;Shift 2 other stats to the right
.org 0x0037CFEC
	li 	$a1, -0x2A
	
	
.org 0x0037CD88
	li  $a2, -0xF1
	
.org 0x0037D014
	li 	$a1, -0x94
	
.org 0x0037D030
	li 	$a1, -0x94
	
;Total Kills
.org 0x0037CE08
	li 	$a2, -0xD8
	
.org 0x0037CE60
	li 	$a2, -0xDC
	

	
;Total Loss	

.close