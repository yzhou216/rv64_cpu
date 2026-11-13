# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li a0, 1
    li a1, 2
    blt a0, a1, equal
    li a0, 0
equal:
    li t0, -1
    li a1, 1
    blt t0, a0, less    # -1 is less than 1 as a signed value
    li a1, 0
less:
    li a2, 1
    blt a0, t0, done    # 1 is less than -1 only as an unsigned value
    li a2, 2
done:
    unimp  # a0 should be 1, a1 1, and a2 2
