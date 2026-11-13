# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li a0, 1
    li a1, 2
    add a2, a0, a1
    unimp  # a2 should be 3
