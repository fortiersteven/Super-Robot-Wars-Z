.ps2
.open __SLPS_PATH__, 0x00FE580

;Search Screen Top
;
;Adjust size to 0x0C
.org 0x003773B0
	li	$a0, 0x0C	


;Search Screen Bottom
.org 0x003777CC
	li	$a0, 0x0C
	
.org 0x003778A4
	li	$a0, 0x0C
	
.org 0x00377900
	li	$a0, 0x0C
.close