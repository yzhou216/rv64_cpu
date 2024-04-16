# Writes the image of the decoder ROM from a file of control words, one
# binary literal per line, such as decode.bin.  The image goes to stdout in
# the hex format of Digital.
#
# Usage: awk -f mkdecoderom.awk decode.bin

BEGIN {
	print "v2.0 raw"
}

NF == 0 {
	next
}

!/^0b[01]+$/ {
	print "not a binary literal: " $0 > "/dev/stderr"
	exit 1
}

{
	word = 0
	for (i = 3; i <= length($0); i++)
		word = word * 2 + substr($0, i, 1)
	printf "%x\n", word
}
