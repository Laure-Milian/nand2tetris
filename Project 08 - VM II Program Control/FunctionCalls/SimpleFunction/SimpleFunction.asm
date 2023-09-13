
// function SimpleFunction.test 2

(SimpleFunction.test)

@0 // push constant 0 x times (where x is num_locals)
D=A
@SP
A=M // Go to RAM[SP]
M=D // RAM[SP] = 0
@SP
M=M+1

@0 // push constant 0 x times (where x is num_locals)
D=A
@SP
A=M // Go to RAM[SP]
M=D // RAM[SP] = 0
@SP
M=M+1

// push local 0
@LCL
A=M // Go to where is stored the segment value
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// push local 1
@LCL
A=M // Go to where is stored the segment value
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

// not
@SP
M=M-1 // SP = 257
@SP
A=M // Go to 257
M=!M // RAM[257] = !RAM[257]
@SP
M=M+1 // SP = 257

// push argument 0
@ARG
A=M // Go to where is stored the segment value
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

// return

// ******** endFrame = LCL
@LCL
D=M
@endFrame
M=D // LCL stored in temp variable 'endFrame'

// ******** retAddr = *(endFrame - 5)
@endFrame
D=M
@5
A=D-A // go to LCL-5 to get the stored return address
D=M
@retAddr
M=D // LCL-5 stored in temp variable 'retAddr'

// ******** ARG = pop()
@SP 
A=M-1 
D=M // D = RAM[SP]
@ARG
A=M // Go to RAM[ARG]
M=D // RAM[ARG] = D

// ******** SP = ARG + 1
@ARG
D=M+1
@SP 
M=D // RAM[ARG] = D

// ******** THAT = *(endFrame - 1)
@endFrame
A=M-1
D=M
@THAT
M=D

// ******** THIS = *(endFrame - 2)
@endFrame
D=M
@2
A=D-A // go to endFrame-2 to get the stored value
D=M
@THIS
M=D

// ******** ARG = *(endFrame - 3)
@endFrame
D=M
@3
A=D-A // go to endFrame-3 to get the stored value
D=M
@ARG
M=D

// ******** LCL = *(endFrame - 4)
@endFrame
D=M
@4
A=D-A // go to endFrame-4 to get the stored value
D=M
@LCL
M=D

@retAddr
A=M
0;JMP
