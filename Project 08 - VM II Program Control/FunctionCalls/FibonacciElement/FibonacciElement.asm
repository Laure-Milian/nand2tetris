// BOOTSTRAP CODE 
@256
D=A
@SP
M=D // SP = 256


// ******** push returnAddress
@init$ReturnAddress.0
D=A
@SP
A=M
M=D // RAM[SP] = returnAddressLabel
@SP
M=M+1


// ******** push LCL - saves LCL of the caller
@LCL
D=M
@SP
A=M
M=D // RAM[SP] = LCL
@SP
M=M+1


// ******** push ARG - saves ARG of the caller
@ARG
D=M
@SP
A=M
M=D // RAM[SP] = ARG
@SP
M=M+1

// ******** push THIS - saves THIS of the caller
@THIS
D=M
@SP
A=M
M=D // RAM[SP] = THIS
@SP
M=M+1


// ******** push THAT - saves THAT of the caller
@THAT
D=M
@SP
A=M
M=D // RAM[SP] = THAT
@SP
M=M+1


// ******** ARG = SP - 5 - nArgs -> Repositions ARG
@5
D=A
@0
D=D+A
@SP
D=M-D
@ARG
M=D


// ******** LCL = SP -> Repositions LCL
@SP
D=M
@LCL
M=D


// ******** goto functionName - transfers control to the called function
@Sys.init
0;JMP

// ******** (returnAddress) - declares a label for the return address
(init$ReturnAddress.0)


// function Main.fibonacci 0
(Main.fibonacci)

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

// lt                     // checks if n<2
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
D;JLT 
@END1
0;JMP
(CODEIFTRUE1)
   @SP
   A=M // Go to 256
   M=-1 // Set to true
(END1)
   @SP
   M=M+1 // SP = 257

// if-goto IF_TRUE
@SP
M=M-1
@SP
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@Main.fibonacci$IF_TRUE
D;JNE

// goto IF_FALSE
@Main.fibonacci$IF_FALSE
0;JMP

// label IF_TRUE          // if n<2, return n
(Main.fibonacci$IF_TRUE)

// push argument 0
@ARG
A=M // Go to where is stored the segment value
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

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

// label IF_FALSE         // if n>=2, returns fib(n-2)+fib(n-1)
(Main.fibonacci$IF_FALSE)

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

// call Main.fibonacci 1  // computes fib(n-2)

// ******** push returnAddress
@Main.fibonacci$ReturnAddress.2
D=A
@SP
A=M
M=D // RAM[SP] = returnAddressLabel
@SP
M=M+1


// ******** push LCL - saves LCL of the caller
@LCL
D=M
@SP
A=M
M=D // RAM[SP] = LCL
@SP
M=M+1


// ******** push ARG - saves ARG of the caller
@ARG
D=M
@SP
A=M
M=D // RAM[SP] = ARG
@SP
M=M+1

// ******** push THIS - saves THIS of the caller
@THIS
D=M
@SP
A=M
M=D // RAM[SP] = THIS
@SP
M=M+1


// ******** push THAT - saves THAT of the caller
@THAT
D=M
@SP
A=M
M=D // RAM[SP] = THAT
@SP
M=M+1


// ******** ARG = SP - 5 - nArgs -> Repositions ARG
@5
D=A
@1
D=D+A
@SP
D=M-D
@ARG
M=D


// ******** LCL = SP -> Repositions LCL
@SP
D=M
@LCL
M=D


// ******** goto functionName - transfers control to the called function
@Main.fibonacci
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Main.fibonacci$ReturnAddress.2)


// push argument 0
@ARG
A=M // Go to where is stored the segment value
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// push constant 1
@1
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

// call Main.fibonacci 1  // computes fib(n-1)

// ******** push returnAddress
@Main.fibonacci$ReturnAddress.3
D=A
@SP
A=M
M=D // RAM[SP] = returnAddressLabel
@SP
M=M+1


// ******** push LCL - saves LCL of the caller
@LCL
D=M
@SP
A=M
M=D // RAM[SP] = LCL
@SP
M=M+1


// ******** push ARG - saves ARG of the caller
@ARG
D=M
@SP
A=M
M=D // RAM[SP] = ARG
@SP
M=M+1

// ******** push THIS - saves THIS of the caller
@THIS
D=M
@SP
A=M
M=D // RAM[SP] = THIS
@SP
M=M+1


// ******** push THAT - saves THAT of the caller
@THAT
D=M
@SP
A=M
M=D // RAM[SP] = THAT
@SP
M=M+1


// ******** ARG = SP - 5 - nArgs -> Repositions ARG
@5
D=A
@1
D=D+A
@SP
D=M-D
@ARG
M=D


// ******** LCL = SP -> Repositions LCL
@SP
D=M
@LCL
M=D


// ******** goto functionName - transfers control to the called function
@Main.fibonacci
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Main.fibonacci$ReturnAddress.3)


// add                    // returns fib(n-1) + fib(n-2)
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

// function Sys.init 0
(Sys.init)

// push constant 4
@4
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// call Main.fibonacci 1   // computes the 4'th fibonacci element

// ******** push returnAddress
@Sys.init$ReturnAddress.4
D=A
@SP
A=M
M=D // RAM[SP] = returnAddressLabel
@SP
M=M+1


// ******** push LCL - saves LCL of the caller
@LCL
D=M
@SP
A=M
M=D // RAM[SP] = LCL
@SP
M=M+1


// ******** push ARG - saves ARG of the caller
@ARG
D=M
@SP
A=M
M=D // RAM[SP] = ARG
@SP
M=M+1

// ******** push THIS - saves THIS of the caller
@THIS
D=M
@SP
A=M
M=D // RAM[SP] = THIS
@SP
M=M+1


// ******** push THAT - saves THAT of the caller
@THAT
D=M
@SP
A=M
M=D // RAM[SP] = THAT
@SP
M=M+1


// ******** ARG = SP - 5 - nArgs -> Repositions ARG
@5
D=A
@1
D=D+A
@SP
D=M-D
@ARG
M=D


// ******** LCL = SP -> Repositions LCL
@SP
D=M
@LCL
M=D


// ******** goto functionName - transfers control to the called function
@Main.fibonacci
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Sys.init$ReturnAddress.4)


// label WHILE
(Sys.init$WHILE)

// goto WHILE              // loops infinitely
@Sys.init$WHILE
0;JMP
