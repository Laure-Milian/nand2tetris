// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(KBDLISTENER)

	@SCREEN
	D = A
	@currentpixel
	M = D // currentpixel=16384 (screen start)

	@8192 // number of pixels
	D=A
	@nbofpixels
	M=D

	@i
	M = 0 // i = 0

	@KBD
	D = M

	@WHITELOOP
	D;JEQ // If keyboard == 0 goto WHITELOOP

	@BLACKLOOP
	0;JMP // else goto BLACKLOOP


(WHITELOOP)

	@i
	D = M

	@nbofpixels
	D = M - D // D = nbofpixels - i

	@KBDLISTENER
	D;JEQ // If (nbofpixels - i) == 0 goto KBDLISTENER

	@i
	D = M

	@currentpixel
	A = M + D // A = currentpixel + i
	M = 0 // RAM[A]=1111111111111..

	@i
	M = M + 1 // i = i + 1
	
	@WHITELOOP
	0;JMP


(BLACKLOOP)

	@i
	D = M

	@nbofpixels
	D = M - D // D = nbofpixels - i

	@KBDLISTENER
	D;JEQ // If (nbofpixels - i) == 0 goto KBDLISTENER

	@i
	D = M

	@currentpixel
	A = M + D // A = currentpixel + i
	M = -1 // RAM[A]=1111111111111..

	@i
	M = M + 1 // i = i + 1
	
	@BLACKLOOP
	0;JMP