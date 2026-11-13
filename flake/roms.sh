#!/bin/sh
# SPDX-FileCopyrightText: 2026 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Rebuilds the ROM images of the test programs and of the control words in
# a copy of the repository, and fails unless they match the images in
# progs/hex and the ROMs that the circuits hold.
#
# Usage: roms.sh <repository> <as> <objdump>

set -eu
repo=$1 as=$2 objdump=$3
work=$(mktemp -d)
cp -R "$repo/." "$work"
chmod -R u+w "$work"
# Without the images, make has to write every one of them
rm -f "$work"/progs/hex/*
make -s -C "$work/progs" AS="$as" OBJDUMP="$objdump"
make -s -C "$work/decode"

status=0
fail() {
	echo "$1"
	status=1
}

# Words on stdin, separated by commas or lines, one per line in lower case
# without leading zeros, less the zeros at the end, which a ROM holds anyway
words() {
	tr ',' '\n' | awk '
		{
			w = tolower($1)
			sub(/^0x/, "", w)
			sub(/^0+/, "", w)
			word[NR] = w == "" ? "0" : w
		}
		END {
			n = NR
			while (n > 0 && word[n] == "0")
				n--
			for (i = 1; i <= n; i++)
				print word[i]
		}'
}

# Words of an image in the hex format of Digital
image() {
	{
		read -r header && [ "$header" = 'v2.0 raw' ] && words
	} <"$1"
}

# Label and data of every ROM of a circuit, one ROM per line, as label|data
roms() {
	awk '
		function text(s) {
			sub(/^[^>]*>/, "", s)
			sub(/<.*/, "", s)
			return s
		}
		/<visualElement>/ { name = label = data = expect = "" }
		/<elementName>/ { name = text($0) }
		/<entry>/ { expect = "key" }
		/<string>/ && expect == "key" { key = text($0); expect = "value"; next }
		/<string>/ && expect == "value" && key == "Label" { label = text($0) }
		/<\/entry>/ { expect = "" }
		/<data>/ { indata = 1; sub(/.*<data>/, "") }
		indata {
			done = sub(/<\/data>.*/, "")
			data = data $0
			if (done)
				indata = 0
		}
		/<\/visualElement>/ && name == "ROM" { print label "|" data }
	' "$1"
}

for name in $({
	ls "$work/progs/hex"
	ls "$repo/progs/hex"
} | sort -u); do
	if [ ! -e "$repo/progs/hex/$name" ]; then
		fail "progs/hex/$name is missing"
	elif [ ! -e "$work/progs/hex/$name" ]; then
		fail "progs/hex/$name has no program"
	elif ! cmp -s "$work/progs/hex/$name" "$repo/progs/hex/$name"; then
		fail "progs/hex/$name differs from what make writes"
	fi
done

roms "$work/src/inst-mem.dig" >"$work/roms"
while IFS='|' read -r label data; do
	if [ "$(printf '%s\n' "$data" | words)" != "$(image "$work/progs/hex/$label.hex")" ]; then
		fail "the ROM $label differs from progs/hex/$label.hex"
	fi
done <"$work/roms"

decoder=$(roms "$work/src/inst-decoder.dig")
if [ "$(printf '%s\n' "${decoder#*|}" | words)" != "$(image "$work/decode/decode.hex")" ]; then
	fail 'the ROM of the decoder differs from what make writes'
fi

if [ "$status" -eq 0 ]; then
	echo 'The ROMs match their sources'
fi
exit "$status"
