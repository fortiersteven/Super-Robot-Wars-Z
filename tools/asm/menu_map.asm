.ps2
.open __SLPS_PATH__, 0x00FE580

;Adjust size to 0x0C
.org 0x003540F0
	li	$a0, 0x0C	
	
.org 0x003541DC
	li	$a0, 0x0C			
	
.org 0x0035414C
	li	$a0, 0x0C	

	
.close