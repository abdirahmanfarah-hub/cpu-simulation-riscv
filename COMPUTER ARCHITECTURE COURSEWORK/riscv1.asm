.data
msg1: .string "Enter first number:\n"
msg2: .string "Enter second number:\n"
outmessage: .string "Sorted high to low: "
nl: .string "\n"

.text
.globl main
main:
    # read s0
    addi a7, zero, 4
    la   a0, msg1
    ecall
    addi a7, zero, 5
    ecall
    add  s0, a0, zero

    # read s1
    addi a7, zero, 4
    la   a0, msg2
    ecall
    addi a7, zero, 5
    ecall
    add  s1, a0, zero

    # swap-if-needed 
    slt  t1, s0, s1          
    beq  t1, zero, sorted    # if already sorted, skip swap

    add  s2, s0, zero
    add  s0, s1, zero
    add  s1, s2, zero

sorted:
    # output message
    addi a7, zero, 4
    la   a0, outmessage
    ecall

    # print s0
    addi a7, zero, 1
    add  a0, s0, zero
    ecall

    # print separator as single character (space)
    addi a7, zero, 11
    addi a0, zero, 32
    ecall

    # print s1
    addi a7, zero, 1
    add  a0, s1, zero
    ecall

    # newline
    addi a7, zero, 4
    la   a0, nl
    ecall

    # exit
    addi a7, zero, 10
    ecall

