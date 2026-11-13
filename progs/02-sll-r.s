# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li a1, 1
    li a2, 66           # Shifts by 66 mod 64
    sll a0, a1, a2
    unimp  # a0 should be 4
