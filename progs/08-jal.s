main:
    li a0, 1
    li a1, 2
    jal first_s
    jal t0, odd         # t0 = odd
odd:
    jalr zero, 13(t0)   # odd + 13 with bit 0 cleared, the jal below
    li a0, 0
    li a0, 0
    jal a2, link        # a2 = odd + 16, unless pc kept bit 0 set
link:
    sub a2, a2, t0
    unimp  # a0 should be 3 and a2 16
first_s:
    add a0, a0, a1
    ret
