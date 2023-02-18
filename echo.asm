.data
input: .space 0100     # space to store input string
heap:  .space 0100    # space for heap

.text
main:
    # Input from user is read 
    li $v0, 0x08        # this instruction reads input from user
    la $a0, input    # load address of input string in register a0
    syscall

    # Storing string in heap
    la $t0, input  # load the address of input string in register t0
    la $t1, heap       # load the address of heap in register t1

#Byte by byte reading and storing of input because we know that for storing one byte, pointer has to be incremented by 1
loop:
    lbu $t3, ($t0)     # load a byte from input string in register t3
    beq $t3, 0x00, print  # if the byte stored in t3 is null, jump to print
    sb $t3, ($t1)      # store the byte in t3 in the heap
    addi $t0, $t0, 0x01   # increment the address of string to be loaded, i.e. increment the value stored in t0
    addi $t1, $t1, 0x01   # increment the address of heap where the string has to be stored, i.e. increment the value stored in t1
    j loop             
print:
    li $v0, 0x04         # system call for print string
    la $a0, heap      # load the address of heap in register a0 for printing 
    syscall

    # Exit the program
    li $v0, 0x0a    
    syscall
    
