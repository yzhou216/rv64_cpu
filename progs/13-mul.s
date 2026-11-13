# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li a0, 3
    li a1, 3
    mul a0, a0, a1
    li a1, -3
    li a2, 5
    mul a1, a1, a2      # Needs the upper halves of the operands
    li a2, 1
    slli a2, a2, 32
    li t0, 3
    mul a2, a2, t0      # Needs the bits above 31
    unimp  # a0 should be 9, a1 -15, and a2 0x300000000
