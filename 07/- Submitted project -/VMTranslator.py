
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
            return self.current_line
        elif self.is_return_command:
            return self.current_line
        else:
            return self.current_line.split(" ")[1]

    @property
    def arg_2(self):
        if self.is_push_command or self.is_pop_command or self.is_function_command or self.is_call_command:
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
        return self.current_line in arithmetic_commands

    @property
    def is_label_command(self):
        #todo project 8
        return False

    @property
    def is_goto_command(self):
        #todo project 8
        return False

    @property
    def is_if_command(self):
        #todo project 8
        return False

    @property
    def is_function_command(self):
        #todo project 8
        return False

    @property
    def is_return_command(self):
        #todo project 8
        return False

    @property
    def is_call_command(self):
        #todo project 8
        return False


################################### CODE WRITER ###################################

class CodeWriter(object):

    def __init__(self, vm_filename):
        asm_filename = vm_filename.replace(".vm", ".asm")
        self.filename_for_static = vm_filename.replace(".vm", "").split('/')[-1]
        self.asm_file = open(asm_filename, "w")
        self.utility_counter = 0

    def wr(self, txt):
        self.asm_file.write(txt)

    def write_comment(self, comment):
        self.wr("\n")
        self.wr("// ")
        self.wr(comment)

    def write_arithmetic(self, command):
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

        if command == "eq" or command == "gt" or command == "lt": # Format 3
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
                segment_symbol = self.filename_for_static + "." + index

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

       
    def close(self):
        self.asm_file.close()

################################### MAIN ###################################

class Main(object):
    
    def __init__(self, file_path):
        print("Main init")
        self.code_writer = CodeWriter(file_path)
        self.parser = Parser(file_path)

    def loop_on_vm_file(self):

        while self.parser.has_more_commands:
            
            if not self.parser.current_line.startswith('//') and self.parser.current_line != "":
                self.code_writer.write_comment(self.parser.current_line)
                if self.parser.is_push_command or self.parser.is_pop_command:
                    self.code_writer.write_push_pop(self.parser.command_type, self.parser.arg_1, self.parser.arg_2)
                else:
                    self.code_writer.write_arithmetic(self.parser.arg_1)

            self.parser.advance()
    
    def close(self):
        self.code_writer.close()


if __name__ == '__main__':
    import sys

    file_path = sys.argv[1]
    main = Main(file_path)
    main.loop_on_vm_file()
    main.close()