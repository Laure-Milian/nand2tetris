
// push constant 3030
@3030
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop pointer 0
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THIS
M=D // RAM[Rx] = D (RAM[SP])

// push constant 3040
@3040
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop pointer 1
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THAT
M=D // RAM[Rx] = D (RAM[SP])

// push constant 32
@32
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop this 2
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THIS
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push constant 46
@46
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop that 6
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
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push pointer 0
@THIS
D=M // D = RAM[Rx]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[Rx]
@SP 
M=M+1 

// push pointer 1
@THAT
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

// push this 2
@THIS
A=M // Go to where is stored the segment value
A=A+1 
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

// push that 6
@THAT
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
