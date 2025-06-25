.ps2
.open __SLPS_PATH__, 0x00FE580

.org 0x0038DA40
	li a0, 13
	
.org 0x0038D9A4
	li a0, 13
	
;.org 0x0038D6A0
;	li a3, -0x28

;.org 0x0038D70C
;	li a3, -0x28
	
	
.close