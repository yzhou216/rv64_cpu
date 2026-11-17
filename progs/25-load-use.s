# SPDX-FileCopyrightText: 2026 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Instructions that need the result of the load just before them, which
# stall the pipeline for a cycle
main:
    li sp, 512
    li t0, 7
    sd t0, 0(sp)        # stores the 7 from MEM
    ld t1, 0(sp)
    addi a0, t1, 1      # 8
    ld t2, 0(sp)
    sd t2, 8(sp)        # stores the loaded 7
    ld a1, 8(sp)        # 7
    lb t3, 0(sp)
    bne t3, t0, wrong   # not taken, unless the loaded byte arrives late
    jal t4, here        # t4 = here
here:
    addi t4, t4, 20     # here + 20, the li a2, 3 below
    sd t4, 16(sp)
    ld t5, 16(sp)
    jalr zero, 0(t5)    # jumps to the loaded address
    li a2, 0
    li a2, 3
    unimp  # a0 should be 8, a1 7, and a2 3
wrong:
    li a2, 0
    unimp
