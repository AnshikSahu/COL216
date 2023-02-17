.data
input: .space 256     # allocate space for input string
heap:      .space 256     # allocate space for heap
nl:        .asciiz "\n"   # null-terminated string for newline

.text
main:
    # Read the input string
    li $v0, 8         # system call for read string
    la $a0, input.    # load the address of input_str
    li $a1, 256       # maximum number of characters to read
    syscall

    # Store the string in the heap
    la $t0, input_str  # load the address of input_str
    la $t1, heap       # load the address of heap
    la $t2, nl         # load the address of nl
loop:
    lbu $t3, ($t0)     # load a byte from input_str
    beq $t3, 0, print  # if the byte is null, jump to print
    sb $t3, ($t1)      # store the byte in the heap
    addi $t0, $t0, 1   # increment the input_str pointer
    addi $t1, $t1, 1   # increment the heap pointer
    j loop             # repeat the loop
print:
    li $v0, 4         # system call for print string
    la $a0, heap      # load the address of heap
    syscall

    li $v0, 4         # system call for print string
    la $a0, nl        # load the address of new line
    syscall

    # Exit the program
    li $v0, 10        # system call for exit
    syscall
