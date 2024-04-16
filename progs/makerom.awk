# Writes the instructions in the output of objdump -d as a ROM image in the
# hex format of Digital, and fails on any instruction that is not 32 bits
# long, since the processor decodes no other.
#
# Usage: objdump -d <object> | awk -f makerom.awk

BEGIN {
	FS = "\t"
	print "v2.0 raw"
}

# Address of an instruction, then its encoding
$1 ~ /^ *[0-9a-f]+:$/ {
	insn = $2
	gsub(/ /, "", insn)
	if (length(insn) != 8) {
		print "not a 32-bit instruction: " $0 > "/dev/stderr"
		exit 1
	}
	print insn
}
