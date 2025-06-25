.ps2
.open "SLPS_258.87", 0x00FE580

; Map Data 
; Rectangle Width
.org 0x00353C88
	addiu t1, zero, 0x50
	
; Map Data 
; +5% Coord_X Move
.org 0x00354154
	addiu s4,s6, 0x8A
	

	
.close