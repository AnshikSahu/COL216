# Iterative binary search in MIPS assembly

.data
arr: .word 0:100                      # array to search
n: .word 0                            # length of the array
key: .word 0                          # key to search
found_msg: .asciiz "Found key: "      # message to print when key is found
not_found_msg: .asciiz "Key not found" # message to print when key is not found
input_prompt: .asciiz "Enter the length of the array: " # prompt for array length input
arr_prompt: .asciiz "Enter the elements of the array: " # prompt for array elements input
key_prompt: .asciiz "Enter the key to search: " # prompt for user input

.text
.globl main
main:
    # Prompt for array length and read n
    li $v0, 4
    la $a0, input_prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, n

    # Prompt for array elements and read arr
    li $v0, 4
    la $a0, arr_prompt
    syscall

    la $t0, arr
    lw $t1, n
    li $t2, 0

    loop1:
        beq $t2, $t1, exit1

        li $v0, 5
        syscall
        sw $v0, ($t0)

        addi $t2, $t2, 1
        addi $t0, $t0, 4

        j loop1

    exit1:

    # Prompt for key and read key
    li $v0, 4
    la $a0, key_prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, key

    # Load array address, length, and key
    la $t0, arr
    lw $t1, n
    lw $t2, key
    li $t3, 0
    addi $t4, $t1, -1

loop:
    # Exit loop if left index >= right index
    sle $t6,$t3, $t4
    beq $t6, $zero, exit2

    # Calculate middle index and load value at middle index
    add $t5, $t3, $t4
    srl $t7, $t5, 1
    sll $t5, $t7, 2
    add $t8, $t5, $t0
    lw $a0,0($t8)

    # Compare middle value to key
    bne $a0, $t2, check

    # Print message and exit if key is found
    li $v0, 4
    la $a0, found_msg
    syscall

    li $v0, 1
    add $a0,$t7,$zero
    syscall

    j exit

check:
    # If key is in left half, search left
    ble $t2, $a0, left
    addi $t3, $t7, 1
    j loop

left:
    # If key is in right half, search right
    addi $t4, $t7, -1
    j loop

exit2:
    # Print message and exit if key is not found
    li $v0, 4
    la $a0, not_found_msg
    syscall
    j exit

exit:
    li $v0, 10
    syscall
