# SPDX-FileCopyrightText: 2026 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Jumps and taken branches, after which the pipeline drops the two
# instructions that it has fetched since
main:
    li a0, 0
    li a1, 0
    li a2, 0
    j over
    li a0, 1            # dropped
    li a1, 1            # dropped
over:
    addi a0, a0, 2      # 2
    beq a0, a0, taken   # taken, with a0 from MEM
    li a1, 1            # dropped
    li a2, 1            # dropped
taken:
    li t0, 5
    bne t0, t0, wrong   # not taken, so nothing is dropped
    addi a1, a1, 3      # 3
    jal ra, func
    addi a2, a2, 7      # 11, after func returns
    unimp  # a0 should be 2, a1 3, and a2 11
func:
    li a2, 4
    ret
wrong:
    li a1, 0
    unimp
