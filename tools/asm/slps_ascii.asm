.ps2
.open __SLPS_PATH__, 0x00FE580


	
.org 0x0013A968
	addiu	$s4, $s4, -2
	ori     $v0,$zero,0x989f
    slt     $v0,$v1,$v0
    bne     $v0,$zero,call_func					; $v0 < 0x989F, call our function
	nop
	j		0x0013A898							; Else branch of the If condition
	nop
call_func:
	jal		computeIndex
	move 	$a0, $s4
	
return_index:
	move	$s4, $a0
	
; Create the new function to handle ascii characters
.org 0x003F5820	

computeIndex:		
	; $a0 = address of the string
	lbu		$t4, ($a0)							; Read first byte
	li      $t0, 0x7F          					; Load 0x7F into $t0
	ble     $t4, $t0, isASCII  					; If $t4 <= 0x7F, branch to isASCII
	nop

	
	; Handle regular branch with Kanji
	li 		$t0, -0x89
	addiu	$a0, $a0, 0x1
	lbu     $t1, ($a0)
	addu	$t4, $t4, $t0
	sll 	$t3, $t4, 0x1
	addu	$t3, $t3, $t4
	sll 	$t3, $t3, 0x6
	addiu	$t3, $t3, 0x5C0
	addu 	$t2, $t1, $t3							; $t2 is the index
	
	lui     $at, 0x7000
	sh      $t2, 0x62($at)						; Store the index $at the right place
	addiu	$a0, $a0, 0x1
	
	j       skip       						; Return from the function
	nop
	
	isASCII:
		
		
		li	$t0, 0x2A
		bne   	$t4 ,$t0 ,regular
		nop
		
		;We read the next character and we continue on the regular branch
		addiu	$a0, $a0, 0x1
		lbu		$t4, ($a0)
			
		regular:	
			li 		$t0, 0x20	
			li		$t2, 0xBF
			subu    $v0, $t4, $t0							; index = char - 0x20
			li		$t1, 'Z'
			blt     $t4, $t1, upper_case
			nop
		
		lower_case:
			addiu	$v0, $v0, 0x1
		
		upper_case:
			addu    $v0,$v0,$t2
			lui     $at, 0x7000 
			sh      $v0, 0x62($at)						; Store the index $at the right place
			
			;Store the value
			jal		get_ascii_width
			nop
			lui     $at, 0x7000 
			sh 		$v0, 0x38($at)
	
	skip:
		
		
		j 	return_index    						; Return from the function
		nop

	skip_jump:
		
		j 	return_index


;Take a 1 byte char th$at is ASCII and compute the size based on the font style
;and a table used to stored VWF values
;It supports the new control code 0x3F for unsupported ASCII character in the 0x20-0x3F range
;$a0 = pointer to string
get_ascii_width:

	
	lbu		$t1, ($a0)
	;Test for the new control byte for ascii
	addiu 	$t0, $zero, 0x3F
	bne   	$t1 ,$t0 ,regular_ascii

	not_supported_ascii:
		
		;We read the next character and we continue on the regular branch
		addiu	$a0, $a0, 0x1
		lbu		$t1, ($a0)
	
	regular_ascii:
		;Compute the character index
		li 		$t0, 0x20
		subu    $t3, $t1, $t0							; index = char - 0x20
		li      $t2, 0x4               				
		multu   $t3, $t2
		
		move 	$at, $ra
		jal		get_font_style							; $v0 = font style 
		mflo    $t8                   					; $t8 = index * 4
		addu    $t8, $t8, $v0        					; add font style (0,1,2,3)
		
		;Compute the final offset into the table
		lui     $t0, 0x0043
		ori     $t0, $t0, 0xB590 
		addu    $t2, $t0, $t8         					; final address = base + offset
		lbu     $v0, 0x0($t2)           				; load width byte
	
	move $ra, $at
	jr	$ra
	
get_font_style:
	lbu		$t4, -0x75b8($gp)
	li      $v0, 0x3              
    li      $t1, 0x13
    beq     $t4, $t1, L_case1
	nop
    li      $t1, 0x0C
    beq     $t4, $t1, L_case2
	nop
    beqz    $t4, L_case3        
	nop
    b       L_end             
	nop

	;if font=0x13
	L_case1:
		li      $v0, 0x0
		b       L_end
		nop

	;if font=0x0C
	L_case2:
		li      $v0, 0x1
		b       L_end
		nop
	;if font=0x00
	L_case3:
		li      $v0, 0x2

	;else other font
	L_end:
		jr $ra
		nop

 adjust_width:
	
	li      $t0, 0x7F          					; Load 0x7F into $t0
	ble     $t3, $t0, b1_isASCII 
	
		
	;Regular shift-jis width
	sll   	t3 ,t3 ,0x8
    lbu     $t0 ,0x1 (a0)
    andi    t2 ,t3 ,0xffff
    lui     at ,0x47
    lh      t3 ,-0x1c88 (at)
    or      $t0 ,t2 ,$t0
    addiu   a0 ,a0 ,0x2
	j	0x00139C04
	
	b1_isASCII:
		move 	$t3, $v0
		jal	get_ascii_width
		nop
		
		addu	$t3, $t3, $v0  
		move 	$v0, $t3
		j		0x00139b78
 
	

;Adjust Get_String_Len to use our ASCII width	
;.org 0x00139BE8
;	j	adjust_width
	
.org 0x00139bc4
	li  $t0, 0x34
	
.org 0x00139b9c
	li	$t1, 0x32
		
.org 0x00139b88
	li	$t2, 0x31
	
.org 0x0013A990
	    lui     $at,0x7000
        lhu     $v0, 0x62($at)

.org 0x0043B590
	.incbin __PROP_PATH__


.close