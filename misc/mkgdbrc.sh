#!/bin/bash

PREFIX=riscv64-buildroot-linux-musl-
KERNEL=ethanol/ethanol

echo target remote :1234
echo b *0x802$("$PREFIX"objdump -d "$KERNEL" | grep satp | sed -e "s/^.*\([0-9a-f]\{5\}\):.*$/\1/")
echo c
echo d 1
echo si
echo set \$pc=\$stvec
echo file $KERNEL
