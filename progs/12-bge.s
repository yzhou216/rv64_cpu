# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li a0, 2
    li a1, 1
    bge a0, a1, equal
    li a0, 0
equal:
    li t0, -1
    li a1, 1
    bge a0, t0, greater # 2 is greater than -1 as a signed value
    li a1, 0
greater:
    li a2, 1
    bge t0, a0, done    # -1 is at least 2 only as an unsigned value
    li a2, 2
done:
    unimp  # a0 should be 2, a1 1, and a2 2
