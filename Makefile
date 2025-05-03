ARCH    = riscv64-unknown-elf
CC      = $(ARCH)-gcc
FLAGS   = -nostartfiles -g
LD      = $(ARCH)-ld
OBJCOPY = $(ARCH)-objcopy
OBJDUMP = $(ARCH)-objdump

RISCV_ARCH ?= rv32ima_zicsr_zifencei
RISCV_ABI ?= ilp32

FLAGS += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI)

LDFLAGS = -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI) -m elf32lriscv

all: clean hello.img

hello.img: hello.elf
	$(OBJCOPY) hello.elf -I binary hello.img

hello.elf: hello.o link.ld Makefile
	$(LD) -T link.ld $(LDFLAGS) --no-warn-rwx-segments -o hello.elf hello.o

hello.o: hello.s
	$(CC) $(FLAGS) -c $< -o $@

clean:
	rm -f *.o hello.elf hello.img meminit.bin hello.asm memsim.hex

meminit: hello.elf dump
	$(OBJCOPY) -O binary hello.elf meminit.bin

dump:
	$(OBJDUMP) --disassemble-all hello.elf > hello.asm

# run: hello.img
# 	qemu-system-riscv64 -M virt -bios none -serial stdio -display none -kernel hello.img
run: meminit
	~/AFT-dev/aft_out/sim-verilator/Vaftx07 --tohost-address 2952790016 --virtual meminit.bin
