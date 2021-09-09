/*
 * goto.s
 *
 *      Go binary's .text does not start with the real entry, so this
 *	small code "goto" the real entry point.
 *
 *      OpenSBI switch to S mode and goes to 0x80200000 in jump mode
 *	by default, which lies this goto binary.  Hoddarla kernel ELF
 *	will be loaded at 0x80201000.  This is a trick to aligned the
 *	lower part of the address, no matter in PA or VA.  See below,
 *
 *	PA				VA
 *	+-------------+ 0x80200000
 *	| goto        |
 *	+-------------+ 0x80201000	+------------+ 0xffffffc0_00001000
 *	| hoddarla    |			| ELF        |
 *	| kernel ELF  |          	| Header     |
 *	+     ---     + 0x80202000	+------------+ 0xffffffc0_00002000
 *	| hoddarla    |			| ELF        |
 *	| kernel code |          	| .text      |
 *
 *                         ...
 *
 *      So a normal build/boot sequence will be
 *
 *              0. prepare OpenSBI jump.bin and hoddarla
 *              1. parse hoddarla ELF and patch goto (this binary)
 *              2. qemu loads OpenSBI as firmware (-bios)
 *		3. qemu uses loader devices for goto and hoddarla
 *              4. OpenSBI --0x80200000--> goto --0x802xxxxx--> hoddarla
 */

.text
.global _start
_start:
        auipc   t6, 0x00000
        addi    t6, t6, 0x000
        jr      t6
