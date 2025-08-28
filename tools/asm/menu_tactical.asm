.ps2
.open __SLPS_PATH__, 0x00FE580

;Adjust size to 0x0C
.org 0x0037CC3C
	li	$a0, 0x0C

.org 0x0037CE78
	li 	$A0, 0x0C
	
.close