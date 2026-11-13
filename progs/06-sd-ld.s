# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li sp, 128
    addi sp, sp, -8
    li a0, 0
    li t0, 99
    sd t0, 0(sp)
    ld a0, 0(sp)
    unimp  # a0 should be 99

