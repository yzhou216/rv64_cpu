# SPDX-FileCopyrightText: 2026 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Results that the pipeline forwards to EX from MEM and WB
main:
    li a0, 1
    li a0, 2            # newer than the a0 above, and in MEM for the add
    add a1, a0, a0      # 4, with both operands from MEM rather than 2 from WB
    add a2, a1, a0      # 6, with a1 from MEM and a0 from WB
    li zero, 5          # x0 stays zero, so there is nothing to forward
    add a0, zero, a2    # 6, which a forwarded 5 would make 11
    sub a2, a2, a1      # 2, with both operands from the register file
    unimp  # a0 should be 6, a1 4, and a2 2
