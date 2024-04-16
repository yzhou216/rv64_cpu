main:
    li t0, 7
    lui a0, 0x28        # Bits 19 to 15 of this lui, rs1 in other formats, name t0
    unimp  # a0 should be 0x28000
