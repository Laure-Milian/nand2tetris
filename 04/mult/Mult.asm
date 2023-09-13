// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.

// R2 = R0 * R1

// 2 * 4 = 2 + 2 + 2 + 2
// R0 * R1 = R0 + R0 + R0 ... (n fois, où n = R1)
// var total = 0
// for (i = 0; i <= R1; i++) {
// 	total += R0
// }

@R0
D = M
@base
M = D // base = R0

@R1
D = M
@multiplier
M = D // multiplier = R1

@R2
M = 0

@i
M = 0 // i = 0

@sum
M = 0 // sum = 0

(LOOP)

	@i
	D = M

	@multiplier
	D = M - D // D = multiplier - i

	@STOP
	D;JEQ // If (multiplier - i) == 0 goto STOP

	@base
	D = M

	@sum
	M = M + D

	@i
	M = M + 1 // i = i + 1

	@LOOP
	0;JMP

(STOP)
	@sum
	D=M
	@R2
	M=D // RAM[2] = sum

(END)
	@END
	0;JMP