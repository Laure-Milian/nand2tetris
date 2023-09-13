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


// function Sys.init 0
(Sys.init)

// push constant 4000	// test THIS and THAT context save
@4000	//
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

// push constant 5000
@5000
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

// call Sys.main 0

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
@Sys.main
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Sys.init$ReturnAddress.1)


// pop temp 1
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@R6
M=D // RAM[Rx] = D (RAM[SP])

// label LOOP
(Sys.init$LOOP)

// goto LOOP
@Sys.init$LOOP
0;JMP

// function Sys.main 5
(Sys.main)

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

@0 // push constant 0 x times (where x is num_locals)
D=A
@SP
A=M // Go to RAM[SP]
M=D // RAM[SP] = 0
@SP
M=M+1

// push constant 4001
@4001
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

// push constant 5001
@5001
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

// push constant 200
@200
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop local 1
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@LCL
A=M // Go to where is stored the segment value
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push constant 40
@40
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop local 2
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@LCL
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push constant 6
@6
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// pop local 3
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@LCL
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
A=A+1 
M=D // RAM[segment] = D (RAM[SP])

// push constant 123
@123
D=A 
@SP 
A=M 
M=D 
@SP 
M=M+1 

// call Sys.add12 1

// ******** push returnAddress
@Sys.main$ReturnAddress.2
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
@Sys.add12
0;JMP

// ******** (returnAddress) - declares a label for the return address
(Sys.main$ReturnAddress.2)


// pop temp 0
@SP 
M=M-1 
@SP 
A=M // Go to RAM[SP]
D=M // D = RAM[SP]
@R5
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

// push local 2
@LCL
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// push local 3
@LCL
A=M // Go to where is stored the segment value
A=A+1 
A=A+1 
A=A+1 
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// push local 4
@LCL
A=M // Go to where is stored the segment value
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

// function Sys.add12 0
(Sys.add12)

// push constant 4002
@4002
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

// push constant 5002
@5002
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

// push argument 0
@ARG
A=M // Go to where is stored the segment value
D=M // D = RAM[segment]
@SP 
A=M // Go to RAM[SP]
M=D // RAM[SP] = RAM[segment]
@SP 
M=M+1 

// push constant 12
@12
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
