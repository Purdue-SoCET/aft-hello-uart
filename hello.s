.section .text
.global _start

_start: # Program starts here
    csrr    t1, mstatus
    li      t2, 0xFFFFE7FF        # clear MPP bits
    and     t1, t1, t2
    li      t2, 0x00000800        # set MPP to S-mode for mret
    or      t1, t1, t2
    csrw    mstatus, t1

    la      t0, _sstart
    csrw    mepc, t0

    mret

_sstart: # S-mode (or not)
    # prepare for the loop
    lui     s1, 0xB0000          # UART output register
    la      s2, hello            # load string start addr into s2
    addi    s3, s2, 13           # set up string end addr in s3

loop:
    lb      s4, 0(s2)            # load next byte at s2 into s4
    sb      s4, 0(s1)            # write byte to UART register
    fence.i                      # ensure I/O order
    addi    s2, s2, 1            # increase s2
    blt     s2, s3, loop         # loop until s2 == s3

forever:
    j       forever              # halt here

.section .data

hello:
    .string "hello world!\n"