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


// function Class1.set 0
(Class1.set)

// push argument 0
@ARG
A=M // Go to where is stored the segment value
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// pop static 0
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@Class1.0
M=D // RAM[Rx] = D (RAM[SP])

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

// pop static 1
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@Class1.1
M=D // RAM[Rx] = D (RAM[SP])

// push constant 0
@0
D=A 
@SP 
A=M 
M=D 
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

// function Class1.get 0
(Class1.get)

// push static 0
@Class1.0
D=M // D = RAM[Rx]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[Rx]
@SP 
M=M+1 

// push static 1
@Class1.1
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

// function Class2.set 0
(Class2.set)

// push argument 0
@ARG
A=M // Go to where is stored the segment value
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// pop static 0
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@Class2.0
M=D // RAM[Rx] = D (RAM[SP])

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

// pop static 1
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@Class2.1
M=D // RAM[Rx] = D (RAM[SP])

// push constant 0
@0
D=A 
@SP 
A=M 
M=D 
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

// function Class2.get 0
(Class2.get)

// push static 0
@Class2.0
D=M // D = RAM[Rx]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[Rx]
@SP 
M=M+1 

// push static 1
@Class2.1
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

// push constant 6
@6
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

// call Class1.set 2

// ******** push returnAddress
@Sys.init$ReturnAddress.1
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
@2
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
@Class1.set
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Sys.init$ReturnAddress.1)


// pop temp 0 // Dumps the return value
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@R5
M=D // RAM[Rx] = D (RAM[SP])

// push constant 23
@23
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// push constant 15
@15
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// call Class2.set 2

// ******** push returnAddress
@Sys.init$ReturnAddress.2
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
@2
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
@Class2.set
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Sys.init$ReturnAddress.2)


// pop temp 0 // Dumps the return value
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@R5
M=D // RAM[Rx] = D (RAM[SP])

// call Class1.get 0

// ******** push returnAddress
@Sys.init$ReturnAddress.3
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
@Class1.get
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Sys.init$ReturnAddress.3)


// call Class2.get 0

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
@Class2.get
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Sys.init$ReturnAddress.4)


// label WHILE
(Sys.init$WHILE)

// goto WHILE
@Sys.init$WHILE
0;JMP
