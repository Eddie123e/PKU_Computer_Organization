    .data
Success_Output:
    .asciiz
    "\nSuccess!\nLocation:\t"
Fail_Output:
    .asciiz
    "\nFail!\n"
Ending:
    .asciiz "\r\n"
Buffer:
    .space 128

    .text
    .globl Main
Main:
    la $a0, Buffer      # Address of Buffer
    la $a1, 128         # Maximum of Characters
    li $v0, 8           # Fetch string
    syscall
Character_Input:
    li $v0, 12          # Read character
    syscall
    addi $t7, $0, 63    # Distinguish question mark
    sub $t6, $t7, $v0
    beq $t6, $0, Exit
    add $t0, $0, $0
    la $s1, Buffer
Scan:
    lb $s0, 0($s1)
    sub $t1, $v0, $s0
    beq $t1, $0, Success
    addi $t0, $t0, 1
    slt $t3, $t0, $a1
    beq $t3, $0, Fail
    addi $s1 $s1, 1
    j Scan
Success:
    la $a0, Success_Output
    li $v0, 4           # Output when success
    syscall
    addi $a0, $t0, 1
    li $v0, 1           # Tell the place
    syscall
    la $a0, Ending
    li $v0, 4
    syscall
    j Character_Input
Fail:
    la $a0, Fail_Output
    li $v0, 4           # Output when fail
    syscall
    j Character_Input
Exit:
    li $v0, 10          # Exit of program
    syscall
