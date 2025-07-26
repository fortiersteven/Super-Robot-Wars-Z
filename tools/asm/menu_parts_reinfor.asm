.ps2
.open __SLPS_PATH__, 0x00FE580

;Stats on the right
.org 0x002B6EB4
	li a0, 13
	
;Parts name on the left
.org 0x002B6DA4
	li a0, 13

.org 0x002B69C0
	li a0, 13
	
.org 0x002B6B8C
	li a0, 13
	
.org 0x002B6B48
	li a0, 13
	
.org 0x002B6BB4
	li a0, 13
	
.org 0x002B711C
	li v0, 0x152
	
.org 0x002B6EDC
	li v0, 0x151
	
.org 0x002B6D50
	li s1,0x40

.org 0x002B6F50
	li a3, 0x56

;Logo for ships
.org 0x002B6D78
	li a2,0x20

	
;.org 0x0038D6A0
;	li a3, -0x28

;.org 0x0038D70C
;	li a3, -0x28
	
	
.close