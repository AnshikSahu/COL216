.text
main:   
    # read input string from user
    li $v0, 0x08       # system call code for reading string
    li $a1, 0100    # allocate 256 bytes for the string
    syscall         # execute system call
    
    # save input string to heap
    move $s0, $v0    # move address of input string to $s0
    li $v0, 0x09       # system call code for sbrk
    li $a0, 0100     # allocate 256 bytes for the string
    syscall         # execute system call
    sw $s0, 0x00($v0)   # store input string at allocated address
    
    # print input string
    li $v0, 0x04       # system call code for printing string
    move $a0, $s0    # move address of input string to $a0
    syscall         # execute system call
    
    # exit program
    li $v0, 0x0A      # system call code for exiting program
    syscall         # execute system call
