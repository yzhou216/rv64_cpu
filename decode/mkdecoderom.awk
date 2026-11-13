# SPDX-FileCopyrightText: 2024 Yiyu Zhou <yiyu@yiyuzhou.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Writes the image of the decoder ROM from the table of control words.
#
# Every row of the table is an instruction, in the order of the inputs of
# the priority encoder, and its control word packs the fields of the row
# from WDsel in the top bit down to PCsel.  The image goes to stdout in the
# hex format of Digital.
#
# Usage: awk -f mkdecoderom.awk rom.csv

function fail(msg) {
	print msg > "/dev/stderr"
	exit 1
}

BEGIN {
	FS = ","
	nfields = split("WDsel RFW BrOp ALUSrcB ALUSrcA ALUOp m2r LD ST SZ PCsel", fields, " ")
	print "v2.0 raw"
}

# Column of every field, by the name in the header
NR == 1 {
	for (i = 1; i <= NF; i++)
		column[$i] = i
	for (i = 1; i <= nfields; i++)
		if (!(fields[i] in column))
			fail("no column " fields[i])
	next
}

{
	if ($column["inum"] != NR - 2)
		fail("row " NR - 2 " has inum " $column["inum"])
	word = 0
	for (i = 1; i <= nfields; i++) {
		bits = $column[fields[i]]
		if (bits !~ /^[01]+$/)
			fail("row " NR - 2 " has " fields[i] " " bits)
		for (j = 1; j <= length(bits); j++)
			word = word * 2 + substr(bits, j, 1)
	}
	printf "%x\n", word
}
