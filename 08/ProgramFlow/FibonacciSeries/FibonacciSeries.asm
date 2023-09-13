
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

// pop pointer 1           // that = argument[1]
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THAT
M=D // RAM[Rx] = D (RAM[SP])

// push constant 0
@0
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop that 0              // first element in the series = 0
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THAT
A=M // Go to where is stored the segment value
M=D // RAM[segment] = D (RAM[SP])

// push constant 1
@1
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop that 1              // second element in the series = 1
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@THAT
A=M // Go to where is stored the segment value
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push argument 0
@ARG
A=M // Go to where is stored the segment value
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// push constant 2
@2
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

// pop argument 0          // num_of_elements -= 2 (first 2 elements are set)
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@ARG
A=M // Go to where is stored the segment value
M=D // RAM[segment] = D (RAM[SP])

// label MAIN_LOOP_START
(FibonacciSeries.MAIN_LOOP_START)
   
   //    push argument 0   
   @ARG
   A=M // Go to where is stored the segment value
   D=M // D = RAM[segment]
   @SP 
   A=M // Go to RAM[SP]
   M=D // RAM[SP] = RAM[segment]
   @SP 
   M=M+1 
   
   //    if-goto COMPUTE_ELEMENT // if num_of_elements > 0, goto COMPUTE_ELEMENT   
   @SP
   M=M-1
   @SP
   A=M // Go to RAM[SP]
   D=M // D = RAM[SP]
   @FibonacciSeries.COMPUTE_ELEMENT
   D;JNE
   
   //    goto END_PROGRAM        // otherwise, goto END_PROGRAM   
   @FibonacciSeries.END_PROGRAM
   0;JMP
   
   //    label COMPUTE_ELEMENT   
   (FibonacciSeries.COMPUTE_ELEMENT)
   
   //    push that 0   
   @THAT
   A=M // Go to where is stored the segment value
   D=M // D = RAM[segment]
   @SP 
   A=M // Go to RAM[SP]
   M=D // RAM[SP] = RAM[segment]
   @SP 
   M=M+1 
   
   //    push that 1   
   @THAT
   A=M // Go to where is stored the segment value
   A=A+1 
   D=M // D = RAM[segment]
   @SP 
   A=M // Go to RAM[SP]
   M=D // RAM[SP] = RAM[segment]
   @SP 
   M=M+1 
   
   //    add   
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
   
   //    pop that 2              // that[2] = that[0] + that[1]   
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
   
   //    push pointer 1   
   @THAT
   D=M // D = RAM[Rx]
   @SP 
   A=M // Go to RAM[SP]
   M=D // RAM[SP] = RAM[Rx]
   @SP 
   M=M+1 
   
   //    push constant 1   
   @1
   D=A 
   @SP 
   A=M 
   M=D 
   @SP 
   M=M+1 
   
   //    add   
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
   
   //    pop pointer 1           // that += 1   
   @SP 
   M=M-1 
   @SP 
   A=M // Go to RAM[SP]
   D=M // D = RAM[SP]
   @THAT
   M=D // RAM[Rx] = D (RAM[SP])
   
   //    push argument 0   
   @ARG
   A=M // Go to where is stored the segment value
   D=M // D = RAM[segment]
   @SP 
   A=M // Go to RAM[SP]
   M=D // RAM[SP] = RAM[segment]
   @SP 
   M=M+1 
   
   //    push constant 1   
   @1
   D=A 
   @SP 
   A=M 
   M=D 
   @SP 
   M=M+1 
   
   //    sub   
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
   
   //    pop argument 0          // num_of_elements--   
   @SP 
   M=M-1 
   @SP 
   A=M // Go to RAM[SP]
   D=M // D = RAM[SP]
   @ARG
   A=M // Go to where is stored the segment value
   M=D // RAM[segment] = D (RAM[SP])
   
   //    goto MAIN_LOOP_START   
   @FibonacciSeries.MAIN_LOOP_START
   0;JMP
   
   //    label END_PROGRAM   
   (FibonacciSeries.END_PROGRAM)
