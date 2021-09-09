all: ethanol
clean:
	rm -fr ethanol
	make -C goto clean

ethanol:
	GOOS=opensbi GOARCH=riscv64 go build -ldflags='-R 0x1000 -T -0x3fffffe000' -o ethanol
	make -C goto
