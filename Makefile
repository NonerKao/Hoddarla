
run:
	make -C ethanol
	qemu-system-riscv64 \
		-smp 4 \
		-M virt \
		-m 512M \
		-nographic \
		-kernel ethanol/goto/goto.bin \
		-append "ethanol arg1 arg2 env1=1 env2=abc" \
		-device loader,file=ethanol/ethanol,addr=0x80201000,force-raw=on $(EXTRA_FLAGS)

.PHONY: env run qemu clean allclean debug
debug:
	$(shell misc/mkgdbrc.sh > /tmp/gdbrc)
	riscv64-linux-gnu-gdb -x /tmp/gdbrc

patch: stamps/patch
stamps/patch: ./go
	./misc/go.sh patch
	touch $@

apply: stamps/apply
stamps/apply: patch/*
	./misc/go.sh apply
	touch $@

stamps/go-env: stamps/apply ./go
	cd ./go/src && \
		GOOS=linux GOARCH=amd64 ./make.bash
	touch $@

qemu: stamps/qemu-env
stamps/qemu-env: toolchain
	cd ./misc && \
		wget https://download.qemu.org/qemu-6.1.0.tar.xz && \
		tar xvJf qemu-6.1.0.tar.xz
	cd ./misc/qemu-6.1.0 && \
		./configure --audio-drv-list= --target-list=riscv64-softmmu --disable-sdl --disable-vnc --disable-gtk --disable-vte --disable-brlapi --disable-opengl --disable-virglrenderer --prefix=$(shell pwd)/toolchain && \
		make -j8 && \
		make install
	touch $@

toolchain: stamps/toolchain-env
stamps/toolchain-env:
	cd ./misc && \
	wget https://toolchains.bootlin.com/downloads/releases/toolchains/riscv64/tarballs/riscv64--musl--bleeding-edge-2020.08-1.tar.bz2 && \
	tar xvjf riscv64--musl--bleeding-edge-2020.08-1.tar.bz2 && \
	rm -fr ../toolchain* && \
	mv riscv64--musl--bleeding-edge-2020.08-1 ../toolchain && \
	rm -fr riscv64--musl--bleeding-edge-2020.08-1.tar.bz2
	touch $@

env: stamps/go-env stamps/toolchain-env stamps/qemu-env

clean:
	make -C ethanol clean
	rm -fr stamps/*

allclean: clean
	rm -fr toolchain go misc/qemu* stamps/*
