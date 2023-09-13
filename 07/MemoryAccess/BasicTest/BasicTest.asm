
// push constant 10
@10
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop local 0
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@LCL
A=M // Go to where is stored the segment value
M=D // RAM[segment] = D (RAM[SP])

// push constant 21
@21
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 22
@22
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop argument 2
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@ARG
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// pop argument 1
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@ARG
A=M // Go to where is stored the segment value
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push constant 36
@36
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop this 6
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THIS
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
A=A+1 
A=A+1 
A=A+1 
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push constant 42
@42
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 45
@45
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop that 5
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THAT
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
A=A+1 
A=A+1 
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// pop that 2
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THAT
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push constant 510
@510
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop temp 6
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@R11
M=D // RAM[Rx] = D (RAM[SP])

// push local 0
@LCL
A=M // Go to where is stored the segment value
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// push that 5
@THAT
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
A=A+1 
A=A+1 
A=A+1 
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
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

// push argument 1
@ARG
A=M // Go to where is stored the segment value
A=A+1 
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
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

// push this 6
@THIS
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
A=A+1 
A=A+1 
A=A+1 
A=A+1 
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// push this 6
@THIS
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
A=A+1 
A=A+1 
A=A+1 
A=A+1 
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
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

// push temp 6
@R11
D=M // D = RAM[Rx]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[Rx]
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
