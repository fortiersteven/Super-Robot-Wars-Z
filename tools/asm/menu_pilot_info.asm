.ps2
.open __SLPS_PATH__, 0x00FE580

.org 0x0038DA40
	li 	$a0, 0x13
	
.org 0x0038D9A4
	li 	$a0, 0x13
	
.org 0x0038D644
	li	$a0, 0x0C
	
;Left Stats value
.org 0x0038D7E0
	li	$a0, 0x0C
	
.org 0x0038D728
	li	$a0, 0x0C
	
.org 0x0038D758
	li	$a0, 0x0C
	
.org 0x0038D9A4	
	li	$a0, 0x13
	
	
;Ability Label positions
.org 0x0038d9c8
	li	$a2, 0x48

.org 0x0038D9CC
	li	$a3, 0x8
;Stats label and value
.org 0x0038DA40
	li	$a0, 0x13
	
.org 0x0038DB2C
	li	$a0, 0x13
	
;Terrain type
.org 0x0038DDC4
	li 	$a0, 0x13
	
.org 0x0038DE34
	li 	$a0, 0x13
	
;Captain Effect Y pos
.org 0x0038DE50
	li	$s4, 0x4B
	
;Label Skills
.org 0x0038DE9C
	li 	$a0, 0x0C
	
.org 0x0038DEC0
	li	$a2, -0xEE
;Skill Values
.org 0x0038DEDC
	li 	$a0, 0x13
	
.org 0x0038DEF0
	li 	$s4, 0x16
	
;Label Spirit/CMD
.org 0x0038DFA8
	li 	$a0, 0x0C
	
;Spirit Values
.org 0x0038DFE8
	li 	$a0, 0x13
	
.org 0x0038DFF8
	li 	$s3, 0x16
;.org 0x0038D6A0
;	li a3, -0x28

;.org 0x0038D70C
;	li a3, -0x28
	
	
.close