
// push constant 17
@17
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 17
@17
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// eq
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE0
D;JEQ 
@END0
0;JMP
(CODEIFTRUE0)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END0)
   @SP
   M=M+1 // SP = 257

// push constant 17
@17
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 16
@16
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// eq
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE1
D;JEQ 
@END1
0;JMP
(CODEIFTRUE1)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END1)
   @SP
   M=M+1 // SP = 257

// push constant 16
@16
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 17
@17
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// eq
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE2
D;JEQ 
@END2
0;JMP
(CODEIFTRUE2)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END2)
   @SP
   M=M+1 // SP = 257

// push constant 892
@892
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 891
@891
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// lt
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE3
D;JLT 
@END3
0;JMP
(CODEIFTRUE3)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END3)
   @SP
   M=M+1 // SP = 257

// push constant 891
@891
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 892
@892
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// lt
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE4
D;JLT 
@END4
0;JMP
(CODEIFTRUE4)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END4)
   @SP
   M=M+1 // SP = 257

// push constant 891
@891
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 891
@891
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// lt
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE5
D;JLT 
@END5
0;JMP
(CODEIFTRUE5)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END5)
   @SP
   M=M+1 // SP = 257

// push constant 32767
@32767
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 32766
@32766
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// gt
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE6
D;JGT 
@END6
0;JMP
(CODEIFTRUE6)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END6)
   @SP
   M=M+1 // SP = 257

// push constant 32766
@32766
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 32767
@32767
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// gt
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE7
D;JGT 
@END7
0;JMP
(CODEIFTRUE7)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END7)
   @SP
   M=M+1 // SP = 257

// push constant 32766
@32766
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 32766
@32766
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// gt
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
D=M-D // RAM[256] = RAM[256] - D(RAM[257])
M=0 // Set false  by default
@CODEIFTRUE8
D;JGT 
@END8
0;JMP
(CODEIFTRUE8)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END8)
   @SP
   M=M+1 // SP = 257

// push constant 57
@57
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 31
@31
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 53
@53
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// add
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
M=M+D // RAM[256] = RAM[256] + D(RAM[257])
@SP
M=M+1 // SP = 257

// push constant 112
@112
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// sub
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
M=M-D // RAM[256] = RAM[256] - D(RAM[257])
@SP
M=M+1 // SP = 257

// neg
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
M=-M // RAM[257] = -RAM[257]
@SP
M=M+1 // SP = 257

// and
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
M=M&D // RAM[256] = RAM[256] & D(RAM[257])
@SP
M=M+1 // SP = 257

// push constant 82
@82
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// or
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
D=M // D = RAM[257]
@SP
M=M-1 // SP = 256
@SP
A=M // Go to 256
M=M|D // RAM[256] = RAM[256] | D(RAM[257])
@SP
M=M+1 // SP = 257

// not
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
M=!M // RAM[257] = !RAM[257]
@SP
M=M+1 // SP = 257
