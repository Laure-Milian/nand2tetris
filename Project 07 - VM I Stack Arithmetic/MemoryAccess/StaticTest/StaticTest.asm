
// push constant 111
@111
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 333
@333
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 888
@888
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop static 8
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@StaticTest.8
M=D // RAM[Rx] = D (RAM[SP])

// pop static 3
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@StaticTest.3
M=D // RAM[Rx] = D (RAM[SP])

// pop static 1
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@StaticTest.1
M=D // RAM[Rx] = D (RAM[SP])

// push static 3
@StaticTest.3
D=M // D = RAM[Rx]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[Rx]
@SP 
M=M+1 

// push static 1
@StaticTest.1
D=M // D = RAM[Rx]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[Rx]
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

// push static 8
@StaticTest.8
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
