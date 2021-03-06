
run:
	make -C ethanol
	qemu-system-riscv64 \
		-M virt \
		-m 512M \
		-nographic \
		-bios misc/opensbi-0.9/build/platform/generic/firmware/fw_jump.bin \
		-kernel ethanol/goto/goto.bin \
		-append "ethanol arg1 arg2 GODEBUG=schedtrace=0,scheddetail=0 env2=abc" \
		-device loader,file=ethanol/ethanol,addr=0x80201000,force-raw=on $(EXTRA_FLAGS)

.PHONY: env run qemu clean allclean debug
debug:
	$(shell misc/mkgdbrc.sh > /tmp/gdbrc)
	riscv64-linux-gnu-gdb -x /tmp/gdbrc -ex 'source go/src/runtime/runtime-gdb.py'

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

opensbi: stamps/opensbi-env
stamps/opensbi-env:
	cd ./misc && \
		wget https://github.com/riscv-software-src/opensbi/archive/refs/tags/v0.9.tar.gz -O opensbi-0.9.tar.gz && \
		tar xvzf opensbi-0.9.tar.gz
	cd ./misc/opensbi-0.9 && \
		CROSS_COMPILE=riscv64-buildroot-linux-musl- make PLATFORM=generic
	touch $@

env: stamps/go-env stamps/toolchain-env stamps/qemu-env

clean:
	make -C ethanol clean
	rm -fr stamps/*

allclean: clean
	rm -fr toolchain go misc/qemu* misc/opensbi* stamps/*
