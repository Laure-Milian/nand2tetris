
################################### PARSER ###################################

class Parser(object):

    def __init__(self, vm_filename):
        print("PARSER INIT - Opening file : ", vm_filename)
        self.vm_file = open(vm_filename, 'r')
        self.all_lines = self.vm_file.readlines()
        self.nb_of_lines = len(self.all_lines)
        self.max_line_index = self.nb_of_lines - 1
        self.current_line_index = 0

    def advance(self):
        self.current_line_index += 1

    @property
    def has_more_commands(self):
        return self.current_line_index <= self.max_line_index

    @property
    def command_type(self):
        if self.is_push_command:
            return "C_PUSH"
        elif self.is_pop_command:
            return "C_POP"
        elif self.is_arithmetic_command:
            return "C_ARITHMETIC"
        elif self.is_label_command:
            return "C_LABEL"
        elif self.is_goto_command:
            return "C_GOTO"
        elif self.is_if_command:
            return "C_IF"
        elif self.is_function_command:
            return "C_FUNCTION"
        elif self.is_return_command:
            return "C_RETURN"
        elif self.is_call_command:
            return "C_CALL"
        else:
            return "ERROR"

    @property
    def arg_1(self):
        if self.is_arithmetic_command:
            return self.current_line.split(" ")[0]
        elif self.is_return_command:
            return self.current_line
        else:
            return self.current_line.split(" ")[1]

    @property
    def arg_2(self):
        if self.is_push_command or self.is_pop_command or self.is_function_command or self.is_call_command :
            return self.current_line.split(" ")[2]
        else:
            return ""

    @property
    def current_line(self):
        return self.all_lines[self.current_line_index].strip()

    @property
    def is_push_command(self): 
        return self.current_line.startswith("push")


    @property
    def is_pop_command(self): 
        return self.current_line.startswith("pop")

    @property
    def is_arithmetic_command(self):
        arithmetic_commands = ["add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not"]
        return self.current_line.split(" ")[0] in arithmetic_commands

    @property
    def is_label_command(self):
        return self.current_line.startswith("label")

    @property
    def is_goto_command(self):
        return self.current_line.startswith("goto")

    @property
    def is_if_command(self):
        return self.current_line.startswith("if-goto")

    @property
    def is_function_command(self):
        return self.current_line.startswith("function")

    @property
    def is_return_command(self):
        return self.current_line.startswith("return")

    @property
    def is_call_command(self):
        return self.current_line.startswith("call")


################################### CODE WRITER ###################################

class CodeWriter(object):

    def __init__(self, vm_filename_or_dirname):
        self.utility_counter = 0
        self.current_file_name = ""
        self.function_name = "init"

        # HANDLING SINGLE FILE
        if (vm_filename_or_dirname.endswith(".vm")) :
            asm_filename = vm_filename_or_dirname.replace(".vm", ".asm")
            self.asm_file = open(asm_filename, "w")  
        # HANDLING DIRECTORY
        else:
            new_file_name = vm_filename_or_dirname.split('\\')[-1] + ".asm"
            asm_filename = vm_filename_or_dirname + "/" + new_file_name
            self.asm_file = open(asm_filename, "w")
            self.write_bootstrap_code()


    def set_current_file_name(self, current_file_name):
        self.current_file_name = current_file_name.split('\\')[-1].replace(".vm", "").split('/')[-1]

    def wr(self, txt):
        self.asm_file.write(txt)

    def write_bootstrap_code(self):
        self.wr("// BOOTSTRAP CODE \n")
        self.wr("@256\n")
        self.wr("D=A\n")
        self.wr("@SP\n")
        self.wr("M=D // SP = 256\n")
        self.write_call("Sys.init", "0") # Call Sys.init

    def write_comment(self, comment):
        self.wr("\n")
        self.wr("// ")
        self.wr(comment)


    def write_arithmetic(self, command):

        print("COMMAND = " + command)
        self.wr("\n")
        self.wr("@SP\n")
        self.wr("M=M-1 // SP = 257\n")
        self.wr("@SP\n")
        self.wr("A=M // Go to 257\n")

        if command == "add" or command == "sub" or command == "and" or command == "or": # Format 1
            self.wr("D=M // D = RAM[257]\n")
            self.wr("@SP\n")
            self.wr("M=M-1 // SP = 256\n")
            self.wr("@SP\n")
            self.wr("A=M // Go to 256\n")

            if command == "add":
                self.wr("M=M+D // RAM[256] = RAM[256] + D(RAM[257])\n")

            elif command == "sub":
                self.wr("M=M-D // RAM[256] = RAM[256] - D(RAM[257])\n")

            elif command == "and":
                self.wr("M=M&D // RAM[256] = RAM[256] & D(RAM[257])\n")

            elif command == "or":
                self.wr("M=M|D // RAM[256] = RAM[256] | D(RAM[257])\n")
            
            self.wr("@SP\n")
            self.wr("M=M+1 // SP = 257\n")

        elif command == "neg" or command == "not": # Format 2

            if command == "neg":
                self.wr("M=-M // RAM[257] = -RAM[257]\n")

            elif command == "not":
                self.wr("M=!M // RAM[257] = !RAM[257]\n")

            self.wr("@SP\n")
            self.wr("M=M+1 // SP = 257\n")

        elif command == "eq" or command == "gt" or command == "lt": # Format 3
            self.wr("D=M // D = RAM[257]\n")
            self.wr("@SP\n")
            self.wr("M=M-1 // SP = 256\n")
            self.wr("@SP\n")
            self.wr("A=M // Go to 256\n")
            self.wr("D=M-D // RAM[256] = RAM[256] - D(RAM[257])\n")
            self.wr("M=0 // Set false  by default\n")
            self.wr("@CODEIFTRUE" + str(self.utility_counter) + "\n")

            if command == "eq":
                self.wr("D;JEQ \n") # if D == 0 => M == D

            elif command == "gt":
                self.wr("D;JGT \n") # if D > 0 => M > D

            elif command == "lt":
                self.wr("D;JLT \n") # if D < 0 => M < D

            self.wr("@END" + str(self.utility_counter) + "\n")
            self.wr("0;JMP\n")
            self.wr("(CODEIFTRUE" + str(self.utility_counter) + ")\n")
            self.wr("   @SP\n")
            self.wr("   A=M // Go to 256\n")
            self.wr("   M=-1 // Set to true\n")
            self.wr("(END" + str(self.utility_counter) + ")\n")
            self.wr("   @SP\n")
            self.wr("   M=M+1 // SP = 257\n")
            self.utility_counter += 1


    def write_push_pop(self, command, segment, index):
        self.wr("\n")
        
        if segment == "constant":
            self.wr("@" + index + "\n")
            self.wr("D=A \n")
            self.wr("@SP \n")
            self.wr("A=M \n")
            self.wr("M=D \n")
            self.wr("@SP \n")
            self.wr("M=M+1 \n")

        elif segment == "local" or segment == "argument" or segment == "this" or segment == "that":

            segment_symbol = {
                "local": "LCL",
                "argument": "ARG",
                "this": "THIS",
                "that": "THAT"
            }

            if command == "C_PUSH":
                self.wr("@" + segment_symbol[segment] + "\n")
                self.wr("A=M // Go to where is stored the segment value\n")
                for x in range(0, int(index)):
                    self.wr("A=A+1 \n")
                self.wr("D=M // D = RAM[segment]\n")
                self.wr("@SP \n")
                self.wr("A=M // Go to RAM[SP]\n")
                self.wr("M=D // RAM[SP] = RAM[segment]\n")
                self.wr("@SP \n")
                self.wr("M=M+1 \n")

            else:
                self.wr("@SP \n")
                self.wr("M=M-1 \n")
                self.wr("@SP \n")
                self.wr("A=M // Go to RAM[SP]\n")
                self.wr("D=M // D = RAM[SP]\n")
                self.wr("@" + segment_symbol[segment] + "\n")
                self.wr("A=M // Go to where is stored the segment value\n")
                for x in range(0, int(index)):
                    self.wr("A=A+1 \n")
                self.wr("M=D // RAM[segment] = D (RAM[SP])\n")
        
        else: #temp, pointer, static

            segment_symbol = ""

            if segment == "temp":
                segment_symbol = "R" + str(5 + int(index))
            elif segment == "pointer":
                segment_symbol = "THIS" if index == "0" else "THAT"
            else: #static
                segment_symbol = self.current_file_name + "." + index

            if command == "C_PUSH":
                self.wr("@" + segment_symbol + "\n")
                self.wr("D=M // D = RAM[Rx]\n")
                self.wr("@SP \n")
                self.wr("A=M // Go to RAM[SP]\n")
                self.wr("M=D // RAM[SP] = RAM[Rx]\n")
                self.wr("@SP \n")
                self.wr("M=M+1 \n")

            else:
                self.wr("@SP \n")
                self.wr("M=M-1 \n")
                self.wr("@SP \n")
                self.wr("A=M // Go to RAM[SP]\n")
                self.wr("D=M // D = RAM[SP]\n")
                self.wr("@" + segment_symbol + "\n")
                self.wr("M=D // RAM[Rx] = D (RAM[SP])\n")

    def write_label(self, label):
        self.wr("\n")
        self.wr("(" + self.function_name + "$" + label + ")\n")

    def write_go_to(self, label):
        self.wr("\n")
        self.wr("@" + self.function_name + "$" + label + "\n")
        self.wr("0;JMP\n")

    def write_if(self, label):
        self.wr("\n")
        self.wr("@SP\n")
        self.wr("M=M-1\n")
        self.wr("@SP\n")
        self.wr("A=M // Go to RAM[SP]\n")
        self.wr("D=M // D = RAM[SP]\n")        
        self.wr("@" + self.function_name + "$" + label + "\n")
        self.wr("D;JNE\n")
    
    def write_function(self, function_name, num_locals):
        self.wr("\n")
        self.function_name = function_name
        self.wr("("+self.function_name+")\n")
        for _ in range(0, int(num_locals)):
            self.wr("\n")
            self.wr("@0 // push constant 0 x times (where x is num_locals)\n")
            self.wr("D=A\n")
            self.wr("@SP\n")
            self.wr("A=M // Go to RAM[SP]\n")
            self.wr("M=D // RAM[SP] = 0\n")        
            self.wr("@SP\n")
            self.wr("M=M+1\n")

    def write_call(self, function_name, num_args):
        returnAddressLabel = self.function_name + "$ReturnAddress." + str(self.utility_counter)
        self.utility_counter += 1
        self.wr("\n")
        self.wr("\n// ******** push returnAddress\n")
        self.wr("@"+returnAddressLabel+"\n")
        self.wr("D=A\n")
        self.wr("@SP\n")
        self.wr("A=M\n")
        self.wr("M=D // RAM[SP] = returnAddressLabel\n")
        self.wr("@SP\n")
        self.wr("M=M+1\n")
        self.wr("\n")
        self.wr("\n// ******** push LCL - saves LCL of the caller\n")
        self.wr("@LCL\n")
        self.wr("D=M\n")
        self.wr("@SP\n")
        self.wr("A=M\n")
        self.wr("M=D // RAM[SP] = LCL\n")
        self.wr("@SP\n")
        self.wr("M=M+1\n")
        self.wr("\n")
        self.wr("\n// ******** push ARG - saves ARG of the caller\n")
        self.wr("@ARG\n")
        self.wr("D=M\n")
        self.wr("@SP\n")
        self.wr("A=M\n")
        self.wr("M=D // RAM[SP] = ARG\n")
        self.wr("@SP\n")
        self.wr("M=M+1\n")
        self.wr("\n// ******** push THIS - saves THIS of the caller\n")
        self.wr("@THIS\n")
        self.wr("D=M\n")
        self.wr("@SP\n")
        self.wr("A=M\n")
        self.wr("M=D // RAM[SP] = THIS\n")
        self.wr("@SP\n")
        self.wr("M=M+1\n")
        self.wr("\n")
        self.wr("\n// ******** push THAT - saves THAT of the caller\n")
        self.wr("@THAT\n")
        self.wr("D=M\n")
        self.wr("@SP\n")
        self.wr("A=M\n")
        self.wr("M=D // RAM[SP] = THAT\n")
        self.wr("@SP\n")
        self.wr("M=M+1\n")
        self.wr("\n")
        self.wr("\n// ******** ARG = SP - 5 - nArgs -> Repositions ARG\n")
        self.wr("@5\n")
        self.wr("D=A\n")
        self.wr("@"+str(num_args)+"\n")
        self.wr("D=D+A\n")
        self.wr("@SP\n")
        self.wr("D=M-D\n")
        self.wr("@ARG\n")
        self.wr("M=D\n")
        self.wr("\n")
        self.wr("\n// ******** LCL = SP -> Repositions LCL\n")
        self.wr("@SP\n")
        self.wr("D=M\n")
        self.wr("@LCL\n")
        self.wr("M=D\n")
        self.wr("\n")
        self.wr("\n// ******** goto functionName - transfers control to the called function\n")
        self.wr("@"+ function_name + "\n")
        self.wr("0;JMP")
        self.wr("\n")
        self.wr("\n// ******** (returnAddress) - declares a label for the return address\n")
        self.wr("("+returnAddressLabel+")\n")
        self.wr("\n")

    def write_return(self):
        self.wr("\n")
        self.wr("\n// ******** endFrame = LCL\n")
        self.wr("@LCL\n")
        self.wr("D=M\n")
        self.wr("@endFrame\n")
        self.wr("M=D // LCL stored in temp variable 'endFrame'\n")
        self.wr("\n// ******** retAddr = *(endFrame - 5)\n")
        self.wr("@endFrame\n")
        self.wr("D=M\n")
        self.wr("@5\n")
        self.wr("A=D-A // go to LCL-5 to get the stored return address\n")
        self.wr("D=M\n")
        self.wr("@retAddr\n")
        self.wr("M=D // LCL-5 stored in temp variable 'retAddr'\n")
        self.wr("\n// ******** ARG = pop()\n")
        self.wr("@SP \n")
        self.wr("A=M-1 \n")
        self.wr("D=M // D = RAM[SP]\n")
        self.wr("@ARG\n")
        self.wr("A=M // Go to RAM[ARG]\n")
        self.wr("M=D // RAM[ARG] = D\n")
        self.wr("\n// ******** SP = ARG + 1\n")
        self.wr("@ARG\n")
        self.wr("D=M+1\n")
        self.wr("@SP \n")
        self.wr("M=D // RAM[ARG] = D\n")
        self.wr("\n// ******** THAT = *(endFrame - 1)\n")
        self.wr("@endFrame\n")
        self.wr("A=M-1\n")
        self.wr("D=M\n")
        self.wr("@THAT\n")
        self.wr("M=D\n")
        self.wr("\n// ******** THIS = *(endFrame - 2)\n")
        self.wr("@endFrame\n")
        self.wr("D=M\n")
        self.wr("@2\n")
        self.wr("A=D-A // go to endFrame-2 to get the stored value\n")
        self.wr("D=M\n")
        self.wr("@THIS\n")
        self.wr("M=D\n")
        self.wr("\n// ******** ARG = *(endFrame - 3)\n")
        self.wr("@endFrame\n")
        self.wr("D=M\n")
        self.wr("@3\n")
        self.wr("A=D-A // go to endFrame-3 to get the stored value\n")
        self.wr("D=M\n")
        self.wr("@ARG\n")
        self.wr("M=D\n")
        self.wr("\n// ******** LCL = *(endFrame - 4)\n")
        self.wr("@endFrame\n")
        self.wr("D=M\n")
        self.wr("@4\n")
        self.wr("A=D-A // go to endFrame-4 to get the stored value\n")
        self.wr("D=M\n")
        self.wr("@LCL\n")
        self.wr("M=D\n")
        self.wr("\n")
        self.wr("@retAddr\n")
        self.wr("A=M\n")
        self.wr("0;JMP\n")

    def close(self):
        self.asm_file.close()

################################### MAIN ###################################

class Main(object):
    
    def __init__(self, file_or_dir_path):
        print("Main init")
        self.code_writer = CodeWriter(file_or_dir_path)

        # HANDLING SINGLE FILE
        if file_or_dir_path.endswith(".vm"):
            self.loop_on_lines_in_vm_file(file_or_dir_path)

        # HANDLING DIRECTORY
        else:
            for filename in os.listdir(file_or_dir_path):
                if filename.endswith(".vm"):
                    self.loop_on_lines_in_vm_file(os.path.join(file_or_dir_path, filename))


    def loop_on_lines_in_vm_file(self, file_path):

        self.parser = Parser(file_path)
        self.code_writer.set_current_file_name(file_path)

        while self.parser.has_more_commands:
            
            if not self.parser.current_line.startswith('//') and self.parser.current_line != "":
                self.code_writer.write_comment(self.parser.current_line)
                if self.parser.is_push_command or self.parser.is_pop_command:
                    self.code_writer.write_push_pop(self.parser.command_type, self.parser.arg_1, self.parser.arg_2)
                elif self.parser.is_arithmetic_command:
                    self.code_writer.write_arithmetic(self.parser.arg_1)
                elif self.parser.is_label_command:
                    self.code_writer.write_label(self.parser.arg_1)
                elif self.parser.is_goto_command:
                    self.code_writer.write_go_to(self.parser.arg_1)
                elif self.parser.is_if_command:
                    self.code_writer.write_if(self.parser.arg_1)
                elif self.parser.is_function_command:
                    self.code_writer.write_function(self.parser.arg_1, self.parser.arg_2)
                elif self.parser.is_call_command:
                    self.code_writer.write_call(self.parser.arg_1, self.parser.arg_2)
                elif self.parser.is_return_command:
                    self.code_writer.write_return()

            self.parser.advance()

    
    def close(self):
        self.code_writer.close()


if __name__ == '__main__':
    import sys
    import os

    file_or_dir_path = sys.argv[1]
    main = Main(file_or_dir_path)
    main.close()