.text
.globl main

main:
    #Taking the first integer as Input, which is x in x^n
    li $v0,5	
    syscall
    #Storing this input in an argument register
    add $a0,$v0,$zero
    
    #Taking the second integer as input, which is n in x^n
    li $v0,5
    syscall
    #Storing this input in an argument register
    add $a1,$v0,$zero
    
    #Decreasing the stack pointer by 4 to create room for the value of return address which is an integer
    addi $sp,$sp,-0x04
    #Storing the value of return address in the memory, before overwriting
    sw $ra,0x00($sp)   
    
    #Jump and link to the Label exponentiation so the return address of exponentiation becomes the program counter here
    jal exponentiation
    
    #Load the previously stored value of return address
    lw $ra,0x00($sp)
    
    #Store the value stored in v0 in argument register to return output 
    add $a0,$v0,$zero
    
    #Printing the output integer on console
    li $v0,1
    syscall
    li $v0,10
    syscall  

exponentiation:	
	#Decrement the stack pointer by 8 to store 2 integer values
	addi $sp,$sp,-0x04
    	#Storing the value of variable register s0 in the memory, before overwriting	
	sw $s0,0x00($sp)
	
	#If the power =0, go to the label jumpd
	beq $a1,$zero,jumpd
	
	#If least significant bit of a1 i.e. of n=0, then t0 stores 0 else 1. Thus this andi operation gives the least significant bit of a1
	andi $t0,$a1,0x01
	#Right shift the value in a1 by 1 bit, equivalent to division by 2
	srl $a1,$a1,0x01
	#Copy the value of a0, i.e. x in s0 
	add $s0,$a0,$zero
	
    #Multiplication of two 32 bit values yields a 64 bit integer
    mult $a0,$a0
    #Here we take the lower 32 bits of the integer, and store it in register a0
    mflo $a0
    
    #Decrement the stack pointer by 4, to create space for an integer i.e. return address before overwriting 
    addi $sp,$sp,-0x04
    #Store the value of return address in the memory
    sw $ra,0x00($sp)
    
    #Jump and link to the Label exponentiation so the return address of exponentiation becomes the program counter here
    jal exponentiation
    
    #Load the previously stored value of return address
    lw $ra,0x00($sp)
    
    #Increment the stack pointer by 4 to get it to its initial position as we have loaded the stored value back 
    addi $sp,$sp,0x04
    
    #t0 had the least significatnt bit of n, thus if value in t0=0 then n is an even number, then we jump to label jumpend
    beq $t0,$zero,jumpend
    
    #Multiplying the value stoed in v0 by the value stored in s0 i.e. x
    mult $v0,$s0
    mflo $v0
    
    #jump to label jumpend
    j jumpend

jumpend:
    #load the previously stored value of s0 from the memory
    lw $s0,0x00($sp)
    
    #Increment the stack pointer by 8, to leave the memory stack in its initial state 
    addi $sp,$sp,0x04
    
    #Jump to the return address
    j $ra

jumpd:
    #We come here if n=0, just store 1 in the register v0 and go to label jempend to manage the stack pointer
    addi $v0,$zero,0x01
    j	jumpend
