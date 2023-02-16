.global main

main:
#take two integers as input and store in $a0 and $a1 then call exponentation
    li $v0,5
    syscall
    mv $a0,$v0
    li $v0,5
    syscall
    mv $a1,$v0
    addi $sp,$sp,-0x04
    sw $ra,0x00($sp)   
    jal exponentiation
    lw $ra,0x00($sp)
        

exponentation:	
		addi $sp,$sp,-0x08
		sw $t0,0x04($sp)
		sw $s0,0x00($sp)
		beq $a1,$zero,jumpd
		andi $t0,$a1,0x01
		srl $a1,$a1,0x01
		mv $s0,$a0
		mul $a0,$a0,$a0
		addi $sp,$sp,-0x04
		sw $ra,0x00($sp)
		jal exponentiation
		lw $ra,0x00($sp)
		addi $sp,$sp,0x04
		beq $t0,$zero,jumpend
		mul $v0,$v0,$s0
		j jumpend

jumpend:		
		lw $t0,0x04($sp)
		lw $s0,0x00($sp)
		addi $sp,$sp,0x08
		j $ra

jumpd:
		mvi	$v0,0x01
		j	jumpend