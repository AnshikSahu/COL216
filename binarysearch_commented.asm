# Iterative binary search in MIPS assembly

.data
arr: .word 0:100                                        # array to search
n: .word 0                                              # length of the array
key: .word 0                                            # key to search
found_msg: .asciiz "Yes at index "                      # message to print when key is found
not_found_msg: .asciiz "Not found"                      # message to print when key is not found
input_prompt: .asciiz "Enter the length of the array: " # prompt for array length input
arr_prompt: .asciiz "Enter the elements of the array: " # prompt for array elements input
key_prompt: .asciiz "Enter the key to search: "         # prompt for user input

.text
.globl main
main:
    # Prompt for array length and read n
    li $v0, 4                            # syscall to print a string
    la $a0, input_prompt                 # load address of input prompt
    syscall                              # execute the syscall

    li $v0, 5                            # syscall to read integer
    syscall                              # execute the syscall
    sw $v0, n                            # store the input in memory

    # Prompt for array elements and read array
    li $v0, 4                            # syscall to print a string
    la $a0, arr_prompt                   # load address of array prompt
    syscall                              # execute the syscall

    la $t0, arr                          # load base address of arr
    lw $t1, n                            # load n into register t1
    li $t2, 0                            # initialize t2 to 0

    loop1:
        beq $t2, $t1, exit1              # if t2 == t1, jump to exit1

        li $v0, 5                        # syscall to read integer
        syscall                          # execute the syscall
        sw $v0, ($t0)                    # store the input in memory

        addi $t2, $t2, 1                 # increment value stored in t2 by 1
        addi $t0, $t0, 4                 # increment memory address by 4 bytes

        j loop1                          # jump to loop1

    exit1:

    # Prompt for key and read key
    li $v0, 4                            # syscall to print a string
    la $a0, key_prompt                   # load address of key prompt in register a0
    syscall                              # execute the syscall

    li $v0, 5                            # syscall to read integer
    syscall                              # execute the syscall
    sw $v0, key                          # store the input key in register v0

    # Load array address, length, and key
    la $t0, arr                          # load base address of arr in register t0
    lw $t1, n                            # load n into register t1
    lw $t2, key                          # load key into register t2
    li $t3, 0                            # initialize t3(left index) to 0
    addi $t4, $t1, -1                    # initialize t4(right index) to n-1

loop:
    # Exit loop if left index >= right index
    sle $t6,$t3, $t4        # Store 1 in t6 if value in t3 <= value in t4, else store 0 in t6
    beq $t6, $zero, exit2   # If value in t6 is zero i.e. if value in t3 > value in t4 then jump to exit2. 

    # Calculate middle index and load value at middle index
    add $t5, $t3, $t4               # Calculate middle index by adding left index and right index
    srl $t7, $t5, 1                 # Shift middle index right by 1 bit (divide by 2)
    sll $t5, $t7, 2                 # Shift middle index left by 2 bits (multiply by 4 to get offset, i.e. amount of shift required in bytes)
    add $t8, $t5, $t0               # Add offset to array base address to get the memory location of middle index
    lw $a0,0($t8)                   # Load the value at middle index into a0

    # Compare middle value to key
    bne $a0, $t2, check              # If middle value i.e. value stored in a0 is not equal to key (stored in t2), jump to check

    # Print message and exit if key is found
    li $v0, 4                        # Load system call for printing a string (4) into $v0
    la $a0, found_msg                # Load address of found message into $a0
    syscall                          # Call the system call to print the message

    li $v0, 1                        # Load system call for printing an integer (1) into $v0
    add $a0,$t7,$zero                # Copy the value of t7 in argument register a0
    syscall                          # Call the system call to print the key

    j exit                           # Jump to exit

check:
    # If key is in left half, search left
    ble $t2, $a0, left               # If value stored in left index (t2) is less than or equal to value stored in middle index (a0), jump to left
    addi $t3, $t7, 1                 # Increment left index to be the index right after the middle index
    j loop                           # Jump to loop to continue the binary search

left:
    # If key is in right half, search right
    addi $t4, $t7, -1                # Decrement right index to be the index right before the middle index
    j loop                           # Jump to loop to continue the binary search

exit2:
    # Print message and exit if key is not found
    li $v0, 4                        # Load system call for printing a string (4) into $v0
    la $a0, not_found_msg            # Load address of not found message into $a0        
    syscall                          # Call the system call to print the message
    j exit                           # Jump to exit

exit:
    li $v0, 10                       # Load system call for exiting the program (10) into $v0
    syscall                          # Call the system call to exit the program
