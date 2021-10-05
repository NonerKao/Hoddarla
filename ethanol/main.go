package main

import (
	"fmt"
	"os"
	"runtime"
	"runtime/ethanol"
)

func writeb(addr, offset uintptr, val uint8)
func readb(addr, offset uintptr) uint8
func writew(addr, offset uintptr, val uint32)
func readw(addr, offset uintptr) uint32

type device struct {
	va uintptr
	pa uintptr
}

type uart struct {
	device
}

type plic struct {
	device
}

func (u uart) write(off, val uintptr) {
	writeb(u.va, off, uint8(val))
}

func (p plic) write(off, val uintptr) {
	writew(p.va, off, uint32(val))
}

func (u uart) read(off uintptr) uintptr {
	ret := readb(u.va, off)
	return uintptr(ret)
}

func (p plic) read(off uintptr) uintptr {
	ret := readw(p.va, off)
	return uintptr(ret)
}

type driver interface {
	deviceInit()
	write(off, val uintptr)
	read(off uintptr) uintptr
}

func (u uart) deviceInit() {
	ethanol.MemoryMap(u.va, u.pa, 0x1000)
	// Setup IER
	u.write(uintptr(0x1), uintptr(1))
}

func (p plic) deviceInit() {
	// Setup mapping
	ethanol.MemoryMap(p.va, p.pa, 0x200000)
	ethanol.MemoryMap(p.va+0x200000, p.pa+0x200000, 0x200000)
	// Priority of UART (10)
	p.write(uintptr(0x28), uintptr(1))
	// Priority threshold of context 1
	p.write(uintptr(0x201000), uintptr(0))
	// Enable bit of UART (10) for context 1
	p.write(uintptr(0x2080), uintptr(0x400))
}

var plic0 plic
var uart0 uart

func eisr(c uintptr) {
	pp := uint32(plic0.read(uintptr(0x201004)))
	up := uint8(uart0.read(uintptr(0x0)))
	os.UartChannel <- byte(up)
	uart0.write(uintptr(0x0), uintptr(up))
	plic0.write(uintptr(0x201004), uintptr(pp))
}

func main() {
	uart0 = uart{device{0xfffffff000000000, 0x10000000}}
	plic0 = plic{device{0xfffffff000200000, 0xc000000}}

	alld := make([]driver, 2)
	alld[0] = uart0
	alld[1] = plic0

	os.UartChannel = make(chan byte, 1)

	for _, d := range alld {
		d.deviceInit()
	}

	go func() {
		for {
			runtime.Gosched()
		}
	}()

	fmt.Printf("hdla > ")
	for {
		var s string
		fmt.Scanf("%s", &s)
		fmt.Printf("\n")
		if s == "exit" {
			os.Exit(0)
		} else if s == "cheers" {
			fmt.Println("Hoddarla!")
			fmt.Println("Hoddarla is a OS project powered by RISC-V and Golang.")
		}
		fmt.Printf("hdla > ")
	}
}
