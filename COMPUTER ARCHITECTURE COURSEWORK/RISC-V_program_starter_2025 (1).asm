.data
msg1: .asciiz "Enter first number:\n"
msg2: .asciiz "Enter second number:\n"
outmessage: .asciiz "Sorted high to low: "
nl:   .asciiz "\n"

.text
.globl main
main:
    # read s0
    li   a7, 4
    la   a0, msg1
    ecall
    li   a7, 5
    ecall
    add  s0, a0, zero

    # read s1
    li   a7, 4
    la   a0, msg2
    ecall
    li   a7, 5
    ecall
    add  s1, a0, zero

    # swap-if-needed 
    sgt  t1, s0, s1
    bnez t1, sorted

    add  s2, s0, zero
    add  s0, s1, zero
    add  s1, s2, zero

sorted:
    # output message
    li   a7, 4
    la   a0, outmessage
    ecall

    # print s0
    li   a7, 1
    add  a0, s0, zero
    ecall

    # print separator as a single character (space)
    li   a7, 11
    li   a0, 32
    ecall

    # print s1
    li   a7, 1
    add  a0, s1, zero
    ecall

    # newline
    li   a7, 4
    la   a0, nl
    ecall

    # exit
    li   a7, 10
    ecall

