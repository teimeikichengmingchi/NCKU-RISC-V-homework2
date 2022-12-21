.PHONY: clean

include ../mk/toolchain.mk

ASFLAGS = -march=rv32i -mabi=ilp32
LDFLAGS = --oformat=elf32-littleriscv

%.o: %.S
	$(CROSS_COMPILE)as -R $(ASFLAGS) -o $@ $<

all: linked_list_cycle.elf

linked_list_cycle.elf: linked_list_cycle.o
	 $(CROSS_COMPILE)ld -o $@ -T linked_list_cycle.ld $(LDFLAGS) $<

clean:
	$(RM) linked_list_cycle.elf linked_list_cycle.o
