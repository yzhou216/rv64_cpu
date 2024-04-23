decode.hex: rom.csv mkdecoderom.awk
	awk -f mkdecoderom.awk rom.csv > $@

clean:
	rm -f decode.hex

.PHONY: clean
