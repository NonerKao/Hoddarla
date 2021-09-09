all: ../ethanol
	./patch.sh
	riscv64-buildroot-linux-musl-as goto.s -o goto.o
	riscv64-buildroot-linux-musl-ld -T ld.script goto.o -o goto
	riscv64-buildroot-linux-musl-objcopy -O binary goto goto.bin
clean:
	rm -fr goto.* goto

