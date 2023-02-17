.text
main:   
    # Input taken 
    li $v0, 0x08       
    li $a1, 0100    # Creating space for string
    syscall         
    
    # Storing input string to heap
    move $s0, $v0    # copy address of input string to $s0
    li $v0, 0x09      
    li $a0, 0100     # Creating space for string
    syscall        
    sw $s0, 0x00($v0)   # store input string at base address i.e. return address
    
    # Printing input string
    li $v0, 0x04      
    move $a0, $s0    # copy address of input string to $a0
    syscall         
    
    # exit program
    li $v0, 0x0A      
    syscall         
