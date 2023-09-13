class VMWriter(object):
    
    # Creates a nex output .vm file and prepares it for writing
    def __init__(self, output_file):
        print("init vmwriter")
        self.vm_output_file = open(output_file, "w")  

    # Writes a VM push command.
    # segment = CONST, ARG, LOCAL, STATIC, THIS, THAT, POINTER, TEMP
    # index = int
    def write_push(self, segment, index):
        if segment == "VAR":
            segment = "local"
        if segment == "ARG":
            segment = "argument"
        if segment == "FIELD":
            segment = "this"
        self.wr("push " + segment.lower() + " " + str(index))

    # Writes a VM pop command.
    # segment = ARG, LOCAL, STATIC, THIS, THAT, POINTER, TEMP
    # index = int
    def write_pop(self, segment, index):
        if segment == "VAR":
            segment = "local"
        if segment == "ARG":
            segment = "argument"
        if segment == "FIELD":
            segment = "this"
        self.wr("pop " + segment.lower() + " " + str(index))

    # Writes a VM arithmetic-logical command.
    # command = ADD, SUB, NEG, EQ, GT, LT, AND, OR, NOT
    def write_arithmetic(self, command):
        self.wr(command.lower())

    # Writes a VM label command
    def write_label(self, label):
        self.wr("label " + label)

    # Writes a VM goto command
    def write_go_to(self, label):
        self.wr("goto " + label)

    # Writes a VM if-goto command
    def write_if(self, label):
        self.wr("if-goto " + label)

    # Writes a VM call command
    # name: String, n_args: int
    def write_call(self, name, n_args):
        self.wr("call " + name + " " + str(n_args))

    # Writes a VM function command
    # name: String, n_locals: int
    def write_function(self, name, n_locals):
        self.wr("function " + name + " " + str(n_locals))

    # Writes a VM return command
    def write_return(self):
        self.wr("return")

    def wr(self, txt):
        self.vm_output_file.write(txt)
        self.vm_output_file.write("\n")

    # Closes the output file
    def close(self):
        self.vm_output_file.close()