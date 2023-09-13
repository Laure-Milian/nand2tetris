
// push constant 7
@7
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 8
@8
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
