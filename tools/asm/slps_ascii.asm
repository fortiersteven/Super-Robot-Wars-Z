.ps2
.open __SLPS_PATH__, 0x00FE580

; Character spacing test
;.org 0x0013AAE8
;	addiu 	v0, v0, 0x14
	
;.org 0x0013C654
;	addiu	a2, a1, 0x14


.org 0x0013A968
	
	addiu	s4, s4, -1
	ori     v0,zero,0x989f
    slt     v0,v1,v0
    bne     v0,zero,call_func					; v0 < 0x989F, call our function
	nop
	j		0x0013A898							; Else branch of the If condition
	nop
call_func:
	j		computeIndex
	nop
	
; Create the new function to handle ascii characters
.org 0x0043B334		

computeIndex:		
	; a0 = first_byte
	; a1 = address to 2nd byte if needed
	li      t0, 0x7F          					; Load 0x7F into $t0
	ble     a0, t0, isASCII  					; If a0 <= 0x7F, branch to isASCII
	nop

	
	; Handle regular branch with Kanji
	li 		t0, -0x89
	lbu      t1, (s4)
	addiu	s4, s4, 0x1
	addu	a0, a0, t0
	sll 	v1, a0, 0x1
	addu	v1, v1, a0
	sll 	v1, v1, 0x6
	addiu	v1, v1, 0x5C0
	addu 	t2, t1, v1							; t2 is the index
	
	lui     at, 0x7000
	sh      t2, 0x62(at)						; Store the index at the right place
	
	j       0x13A990     						; Return from the function
	nop
	
	isASCII:
		li      t0, 'a'           				; Load 'a' into $t0
		li      t1, 'z'           				; Load 'z' into $t1
		
		;Spacing
		;li      v0, 0x5
		;lui     at, 0x0047
		;sh		v0, -0x1C94(at)
        
		;Size
		;li		v0, 0x10
		;sh		v0, -0x1C98(at)
		;sh      v0, 0x18(s1)
		;sh      v0, 0x38(at)                
        ;sh      zero,0x48(s1)
		blt     a0, t0, notLowercase  		; If bVar1 < 'a', it's not lowercase
		nop

		; Handle Lowercase here
		li		t1, 0x82
		li		t2, -0x180
		subu    $t3, $a0, $t0         		; index = char - 'a'
		addiu   $t3, $t3, 0x1A    
		addiu	a0, a0, 0x20
		j       final
		nop
		
	notLowercase:
		li      t0, 'A'           				; Load 'A' into $t0
		li      t1, 'Z'           				; Load 'Z' into $t1
		blt     a0, t0, notUppercase  			; If bVar1 < 'A', it's not uppercase
		nop
		bgt     a0, t1, notUppercase  			; If bVar1 > 'Z', it's not uppercase
		nop
		
		; Handle Uppercase here
		li		t1, 0x82
		li		t2, -0x180
		subu    $t3, $a0, $t0
		addiu	a0, a0, 0x1F

		j       final
		nop
		
	notUppercase:
		li      v0, 0x34            				; Print integer syscall
		move    a0, a0           					; Print the character (ASCII value in $a0)
		
		; For other type of characters
	
	final:
		lui     at, 0x7000                       
        sll     t1,t1,0x8
        andi    t1,t1,0xffff
        or      v0,t1,a0							; Create two bytes values
        addiu   v0, v0, -0x8000  
        addu    v0,v0,t2
		sh      v0, 0x62(at)						; Store the index at the right place
		
		;Index for Width
		li      t7, 0x4               				
		multu   t3, t7
		mflo    t8                   				; t8 = index * 4
		addu    t8, t8, a1         					; add size index (0,1,2)
		
		;Store the value
		lui     t0, 0x0043
		ori     t0, t0, 0xB590 
		addu    t9, t0, t8         					; final address = base + offset
		lbu     v0, 0x0(t9)           				; load width byte
		sh 		v0, 0x38(at)			
		
		;lw      v0, 0x30(at)           				; load width byte
		;subu	v0, v0, v1
		;sh 		v0, 0x30(at)
	
	skip:
		j       0x13A990     						; Return from the function
		nop

	skip_jump:
	

.org 0x0013A990
	    lui     at,0x7000
        lhu     v0, 0x62(at)

.org 0x0043B590
	.incbin __PROP_PATH__


.close