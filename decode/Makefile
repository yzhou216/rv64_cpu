# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

decode.hex: rom.csv mkdecoderom.awk
	awk -f mkdecoderom.awk rom.csv > $@

clean:
	rm -f decode.hex

.PHONY: clean
