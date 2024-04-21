ASFLAGS = -march=rv64im

# The ROM image of every program, which the instruction memory loads
IMAGES = $(patsubst %.s,hex/%.hex,$(wildcard *.s))

.PRECIOUS: %.o

all: $(IMAGES)

%.o: %.s
	as $(ASFLAGS) -o $@ $<

hex/%.hex: %.o
	objdump -d $< | awk -f makerom.awk > $@

clean:
	rm -f *.o

.PHONY: all clean
