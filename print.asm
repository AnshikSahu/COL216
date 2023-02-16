.text
main:   
    # read input string from user
    li $v0, 8       # system call code for reading string
    li $a1, 256     # allocate 256 bytes for the string
    syscall         # execute system call
    
    # save input string to heap
    move $s0, $v0    # move address of input string to $s0
    li $v0, 9       # system call code for sbrk
    li $a0, 256     # allocate 256 bytes for the string
    syscall         # execute system call
    sw $s0, 0($v0)   # store input string at allocated address
    
    # print input string
    li $v0, 4       # system call code for printing string
    move $a0, $s0    # move address of input string to $a0
    syscall         # execute system call
    
    # exit program
    li $v0, 10      # system call code for exiting program
    syscall         # execute system call

    
