# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li a1, 8
    li a2, 65           # Shifts by 65 mod 64
    srl a0, a1, a2
    unimp  # a0 should be 4
