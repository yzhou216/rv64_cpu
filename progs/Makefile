ASFLAGS = -march=rv64im
OBJDUMP ?= objdump

# The ROM image of every program, which the instruction memory loads
IMAGES = $(patsubst %.s,hex/%.hex,$(wildcard *.s))

.PRECIOUS: %.o

all: $(IMAGES)

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

hex/%.hex: %.o
	$(OBJDUMP) -d $< | awk -f makerom.awk > $@

clean:
	rm -f *.o

.PHONY: all clean
