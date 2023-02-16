.global main

main:
		addi $a0,$zero,0x02
		addi $a1,$zero,0x05

binaryinsertionsort:
		addi $sp,$sp,-0x10
		sw $t0,0x0c($sp)
		sw $t1,0x08($sp)
		sw $s0,0x04($sp)
		sw $s1,0x00($sp)
		sw $s1,0x0($sp)
		slt $t0,$a2,$a1
		beq $t0,$zero,jumpl
		addi $sp,$sp,-0x0c
		sw $a1,0x08($sp)
		sw $a2,0x04($sp)
		sw $ra,0x00($sp)
		addi $a3,$a2,-0x01
		sll $t0,$a2,0x02
		add $t1,$a0,$t0
		lw $s0,0x00($t1)
		mv $a1,$s0
		mv $a2,$zero
		jal binarysearch
		lw $a1,0x08($sp)
		lw $a2,0x04($sp)
		lw $ra,0x00($sp)
		addi $sp,$sp,0x0c
		j loop

loop:
		slt $t0,$a3,$v0
		beq $t0,$zero,jumpe
		addi $t0,$a3,0x01
		sll $t1,$t0,0x02
		add $t0,$t1,$a0
		lw $s0,0x00($t0)
		j main
		
jumpe:
		sll $t0,$a3,0x02
		addi $a3,$a3,0x01
		sll $t1,$a3,0x02
		addi $a3,$a3,-0x02
		add $t0,$a0,$t0
		add $t1,$a0,$t1
		lw $s1,0x00($t0)
		sw $s1,0x00($t1)
		j loop

jumpl:
		mv $v0,$a0
		mv $v1,$a1
		lw $t0,0x0c($sp)
		lw $t1,0x08($sp)
		lw $s0,0x04($sp)
		lw $s1,0x00($sp)
		jr $ra

binarysearch:
		add $sp,$sp,-0x14
		sw $s0,0x10($sp)
		sw $s1,0x0c($sp)
		sw $s2,0x08($sp)
		sw $t0,0x04($sp)
		sw $t1,0x00($sp)
		sll $t0,$a2,0x02
		add $t1,$a0,$t0
		lw $s0,0x00($s1)
		beq $a2,$a3,jump1
		slt $t0,$a3,$a2
		beq $t0,$zero,jump3
		mv $v0,$a2

jump1:
		slt $t0,$s0,$a1
		beq $t0,$zero,jump2
		addi $v0,$s0,0x01
		j end

jump2:
		mv $v0,$a2
		j end

jump3:		
		add $t0,$a2,$a3
		srl $s1,$t0,0x01
		sll $t0,$s1,0x02
		add $t1,$a0,$t0
		lw $s2,0x00($t1)
		slt $t0,$s2,$a1
		beq $t0,$zero,jump4
		addi $a2,$s1,0x01
		j jumpr
		j end

jump4:
		slt $t0,$a1,$s2
		beq $t0,$zero,jump5
		addi $a3,$s1,-0x01
		j jumpr
		j end

jump5:
		mv $v0,$s1
		j end

jumpr:
		addi $sp,$sp,-0x04
		sw $ra,0x00($sp)
		jal binarysearch
		lw $ra,0x00($sp)
		addi $sp,$sp,0x04
		j $ra	
		
end:
		lw $s0,0x10($sp)
		lw $s1,0x0c($sp)
		lw $s2,0x08($sp)
		lw $t0,0x04($sp)
		lw $t1,0x00($sp)
		add $sp,$sp,0x14
		jr $ra