main:
    li a0, 1
    addi a2, a0, 2
    slli a0, a0, 32
    addiw a0, a0, 5     # Drops the bits above 31
    li a1, 1
    slli a1, a1, 31
    addi a1, a1, -1
    addiw a1, a1, 1     # Sign-extends bit 31 of the sum
    unimp  # a0 should be 5, a1 0xFFFFFFFF80000000, and a2 3
