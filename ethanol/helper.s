// Copyright 2015 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//go:build opensbi
// +build opensbi

#include "textflag.h"

// func readb(addr, offset uintptr) uint8
TEXT main·readb(SB), NOSPLIT|NOFRAME, $0-17
	MOV	addr+0(FP), A0
	MOV	offset+8(FP), A1
	ADD	A0, A1, A0
	MOVBU	0(A0), A1
	MOVB	A1, ret+16(FP)
	RET

// func readw(addr, offset uintptr) uint32
TEXT main·readw(SB), NOSPLIT|NOFRAME, $0-20
	MOV	addr+0(FP), A0
	MOV	offset+8(FP), A1
	ADD	A0, A1, A0
	MOVWU	0(A0), A1
	MOVW	A1, ret+16(FP)
	RET

// func writeb(addr, offset uintptr, val uint8)
TEXT main·writeb(SB), NOSPLIT|NOFRAME, $0-17
	MOV	addr+0(FP), A0
	MOV	offset+8(FP), A1
	MOVBU	val+16(FP), A2
	ADD	A0, A1, A0
	MOVB	A2, 0(A0)
	RET

// func writew(addr, offset uintptr, val uint32)
TEXT main·writew(SB), NOSPLIT|NOFRAME, $0-20
	MOV	addr+0(FP), A0
	MOV	offset+8(FP), A1
	MOVWU	val+16(FP), A2
	ADD	A0, A1, A0
	MOVW	A2, 0(A0)
	RET
