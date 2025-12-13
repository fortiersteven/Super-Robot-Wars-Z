.ps2
.open __SLPS_PATH__, 0x00FE580

; Stats CQB / SKL sizes 
.org 0x0038DA40
	li 	$a0, 0x13
	
; CQB / SKL Value size
.org 0x0038DB2C
	li	$a0, 0x13
	
; Stats / Captain Effect size
.org 0x0038D9A4
	li 	$a0, 0x0C
	
; LV / Will / SP Label size
.org 0x0038D644
	li	$a0, 0x0C
	
; LV / Will / SP Value size 
.org 0x0038D7E0
	li	$a0, 0x0C
	
; Next Level Label size
.org 0x0038D728
	li	$a0, 0x0C
	
; Pilot name size
.org 0x0038D758
	li	$a0, 0x0C
	
	
;Ability Label positions
.org 0x0038d9c8
	li	$a2, 0x48

.org 0x0038D9CC
	li	$a3, 0x8
;Stats label and value
.org 0x0038DA40
	li	$a0, 0x13
	

	
;Terrain type
.org 0x0038DDC4
	li 	$a0, 0x13
	
.org 0x0038DE34
	li 	$a0, 0x13
	
;Captain Effect Y pos
.org 0x0038DE50
	li	$s4, 0x4B
	
; Skill Label Size
.org 0x0038DE9C
	li 	$a0, 0x0C
	
; Skill Label X position
.org 0x0038DEC0
	li	$a2, -0xEA
	
; Skill Label Values
.org 0x0038DEDC
	li 	$a0, 0x13
	
.org 0x0038DEF0
	li 	$s4, 0x16
	
;Label Spirit/CMD
.org 0x0038DFA8
	li 	$a0, 0x0C
	
;Spirit Command Size
.org 0x0038DFE8
	li 	$a0, 0x13
	
; Spirit Command Adjust (  ) X Position
.org 0x38E090
	li 	$a1, -0xC
	
; Spirit Command Adjust Y Position
.org 0x0038DFF8
	li 	$s3, 0x16
	
; Skills Adjust Y Position 

.org 0x38DEF0
	li 	$s4, 0x16
;.org 0x0038D6A0
;	li a3, -0x28

;.org 0x0038D70C
;	li a3, -0x28
	
	
.close