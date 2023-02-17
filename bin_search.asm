.global main

main:
# input a sorted array of integers and its length 
	

binarysearch:
	add $sp,$sp,-0x14 #Decrement the stack pointer by 20, to create space for 5 integers
	
	#Store the value of variable registers s0,s1,s2 and temporary registers t0,t1 to be able to reuse them 
	sw $s0,0x10($sp) 
	sw $s1,0x0c($sp)
	sw $s2,0x08($sp)
	sw $t0,0x04($sp)
	sw $t1,0x00($sp)
	
	#Shift left by 2, i.e. multiply the number stored in argument register, i.e by 4
	#ARGUMENT REGISTERS ME KYA KYA HAI 
	sll $t0,$a2,0x02
	
	#
	add $t1,$a0,$t0
	
	#Load the value of 
	lw $s0,0x00($s1)
	beq $a2,$a3,jump1
	slt $t0,$a3,$a2
	beq $t0,$zero,jump3
	add $v0,$a2,$zero

jump1:
	slt $t0,$s0,$a1
	beq $t0,$zero,jump2
	addi $v0,$s0,0x01
	j end

jump2:
	add $v0,$a2,$zero
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
	add $v0,$s1,$zero1
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
