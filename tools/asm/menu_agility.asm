.ps2
.open __SLPS_PATH__, 0x00FE580

.org 0x003A6DF8
	addiu 	$s0, s2, 0x12A

;HP/EN Regen Label
.org 0x003A6E48
	addiu 	$s6, s2, 0x1B2

.org 0x003A6F2C
	addiu 	$s6, s2, 0x16D
	
	
;Move
.org 0x003A65D8
	addiu a2, s7, 0x105
	
;Captain Effect
.org 0x003A6658
	addiu a2, s7, 0x011A
	
;Draw Blue Rectangle
;Label X pos
.org 0x003A7340
	addiu a2, s0, 0x70
	
.org 0x003A72F8
	addiu s3, s0, 0x70
	
	
.close