# Hoddarla
Hoddarla is an OS project in Golang targeting RISC-V 64-bit system.

## Quick start
```
git clone git@github.com:NonerKao/Hoddarla.git && cd Hoddarla
make env
. .hdlarc
make
```

`make env` gives you the basic development environment: 
the Golang toolchain that is patched (you can check the patches in `patch`), 
a pre-compiled RISC-V  cross-toolchain, and a wrokable QEMU. 
`. .hdlarc` just helps you export the executable.

`make` builds a hello world binary (but that doesn't work yet now),
and run it in the QEMU.
