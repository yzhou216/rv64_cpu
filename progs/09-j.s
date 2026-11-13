# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li a0, 1
    j skip
    li a0, 0
skip:
    unimp  # a0 should be 1
