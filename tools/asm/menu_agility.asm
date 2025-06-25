.ps2
.open __SLPS_PATH__, 0x00FE580

;Moving Stats name 0x20 to the left
.org 0x003A6DF8
	addiu	s0, s2, 0x10A			
	
.org 0x003A6E48
	addiu	s6, s2, 0x198		
	

	
;Moving Stats value 0x20 to the left
.org 0x003A6F2C
	addiu	s6, s2, 0x152			;Removing 0x20
	
.org 0x003A6F80
	addiu	s2, s2, 0x210	
	
	
;Move
.org 0x003A65D8
	addiu a2, s7, 0x105
	
;Captain Effect
.org 0x003A6658
	addiu a2, s7, 0xF6
	
;Draw Blue Rectangle
;EN
.org 0x003A7340
	addiu a2, s0, 0x80
	
	
.close