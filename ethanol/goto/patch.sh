#!/bin/sh

# We need to parse the output from readelf.
# Don't let the locale setting fuck you up.
export LC_ALL=C
ADDR=$(riscv64-buildroot-linux-musl-readelf -h ../ethanol | grep Entry | awk '{print $4}')

LO12=$(echo $ADDR | sed -e 's#^0x.*\(...\)$#\1#')
HI20=$(echo $ADDR | sed -e 's#^0xffffffc0\(.\+\)...$#\1#')

# In RISC-V, the HI20 part depends on the sign of LO12
if [ $(echo $LO12 | grep '^[89abcdef]')"y" != "y" ]; then
	# yeah, you cannot use hexdecimal if it is minus
	LO12=$(printf %d $((0x$LO12-4096)))
	HI20=$(printf 0x%05x $((0x$HI20 + 1)))
else
	LO12=$(printf %d $((0x$LO12)))
	HI20=$(printf 0x%05x $((0x$HI20)))
fi

cat goto_template.s | sed -e "s#0x00000\$#$HI20#" -e "s#0x000\$#$LO12#" > goto.s
