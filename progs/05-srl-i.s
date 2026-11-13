# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

main:
    li a1, 32
    srli a0, a1, 2
    unimp  # a0 should be 8
