
class CompilationEngine(object):

    def __init__(self, input_file_from_tokenizer, output_file):

        from SymbolTable import SymbolTable
        from VMWriter import VMWriter
        from xml.dom import minidom

        self.symbol_table = SymbolTable() # reset for each file/class => ok
        self.vm_writer = VMWriter(output_file)
        
        self.tokenizer_file = open(input_file_from_tokenizer, 'r')

        tokenizer_xml = minidom.parse(input_file_from_tokenizer)
        
        self.all_tokens_nodes = []

        for child_node in tokenizer_xml.getElementsByTagName('tokens')[0].childNodes :    
            if child_node.toxml().strip() != "" :
                self.all_tokens_nodes.append(child_node)

        self.current_node_index = 0

        self.if_label_counter = 0
        self.while_label_counter = 0


    ############################## ITERATION MANAGEMENT ##############################

    @property
    def current_node(self):
        return self.all_tokens_nodes[self.current_node_index]

    @property
    def current_node_name(self):
        return self.current_node.nodeName.strip()
    
    @property
    def current_node_value(self):
        return self.current_node.firstChild.nodeValue.strip()

    @property
    def previous_node(self):
        return self.current_node.previousSibling.previousSibling # why ?!

    @property
    def previous_node_name(self):
        return self.previous_node.nodeName.strip()

    @property
    def previous_node_value(self):
        return self.previous_node.firstChild.nodeValue.strip()

    @property
    def next_node(self):
        return self.current_node.nextSibling.nextSibling # why ?!

    @property
    def next_node_name(self):
        return self.next_node.nodeName.strip()

    @property
    def next_node_value(self):
        return self.next_node.firstChild.nodeValue.strip()

    @property
    def next_NEXT_node(self):
        return self.next_node.nextSibling.nextSibling # why ?!

    @property
    def next_NEXT_node_value(self):
        return self.next_NEXT_node.firstChild.nodeValue.strip()

    def advance(self):
        self.current_node_index += 1


    ############################## API ##############################

    """
    Entry point.
    Compiles a complete class.
    class : 'class' classname '{' classVarDec* subroutineDec* '}' 
    """
    def compile_class(self) :

        # 'class'
        print("CLASS")

        # classname
        self.advance()
        self.class_name = self.current_node_value

        # '{'
        self.advance()

        # classVarDec*
        # Optionnal, check next node.
        while self.next_node_name == "keyword" and (self.next_node_value == "static" or self.next_node_value == "field") :
            self.compile_class_var_dec()

        # subroutineDec*
        # Optionnal, check next node.
        while self.next_node_name == "keyword" and (self.next_node_value == "constructor" or self.next_node_value == "function" or self.next_node_value == "method") :
            self.compile_subroutine_dec()

        # '}'
        self.advance()



    
    """
    Compiles a static variable declaration, or a field declaration.
    classVarDec: ('static'|'field') type varName (',', varName)* ';'
    type: 'int'|'char'|'boolean'|className
    className: identifier
    varName: identifier
    """
    def compile_class_var_dec(self) :

        # ('static'|'field')
        self.advance()
        class_var_kind = self.current_node_value
        
        # type
        self.advance()
        class_var_type = self.current_node_value

        # varName
        self.advance()
        class_var_name = self.current_node_value

        # VM
        self.symbol_table.define(class_var_name, class_var_type, class_var_kind)

        # (',', varName)*
        # Optionnal, check next node.
        while self.next_node_name == "symbol" and self.next_node_value == ",":
            # ,
            self.advance()
            
            # varName
            self.advance()
            class_var_name = self.current_node_value
            self.symbol_table.define(class_var_name, class_var_type, class_var_kind)


        # ';'
        self.advance()
        

    
    """
    Compiles a complete method, function, or constructor.
    subroutineDec: ('constructor'|'function'|'method') ('void'|type) subroutineName '(' parameterList ')' subroutineBody
    """
    def compile_subroutine_dec(self) :

        # start
        self.symbol_table.start_subroutine()

        # ('constructor'|'function'|'method')
        self.advance()
        function_type = self.current_node_value
        if (self.current_node_value == "method"):
            self.symbol_table.define("this", self.class_name, "ARG")

        # ('void'|type)
        self.advance()

        # subroutineName
        self.advance()
        full_function_name = self.class_name + "." + self.current_node_value # fileName.subName
        
        # (
        self.advance()

        # compile_parameter_list
        self.compile_parameter_list()

        # )
        self.advance()

        # compile_subroutine_body
        self.compile_subroutine_body(function_type, full_function_name)


    """
    Compiles a (possibly empty) parameter list. Does not handle the enclosing '()'.
    parameterList: ( (type varName) (',', type varName)* )?
    """
    def compile_parameter_list(self) :
        
        while self.next_node_value != ")":

            # type
            self.advance()
            arg_type = self.current_node_value

            # varname
            self.advance()
            arg_name = self.current_node_value

            # ,
            if self.next_node_value == ",":
                self.advance()

            # VM
            self.symbol_table.define(arg_name, arg_type, "ARG")


    """
    Compiles a subroutine's body.
    subroutineBody: '{' varDec* statements '}'
    """
    def compile_subroutine_body(self, function_type, full_function_name) :

        # {
        self.advance()

        # varDec*
        # Optionnal, check next node.
        while self.next_node_name == "keyword" and self.next_node_value == "var":
            self.compile_var_dec()

        # WVM
        n_vars = self.symbol_table.var_count("VAR")
        self.vm_writer.write_function(full_function_name, n_vars)

        if function_type == "method":
            self.vm_writer.write_push('argument', 0)
            self.vm_writer.write_pop('pointer', 0)
        
        if function_type == "constructor":
            nb_class_scope_vars = self.symbol_table.var_count('FIELD')
            self.vm_writer.write_push('constant', nb_class_scope_vars)
            self.vm_writer.write_call('Memory.alloc', 1)
            self.vm_writer.write_pop('pointer', 0)

        # statements
        self.compile_statements()

        # }
        self.advance()
        


    """
    Compiles a var declaration.
    varDec: 'var' type varName (',' varName)* ';'
    """
    def compile_var_dec(self) :

        var_type = ""
        
        while self.next_node_value != ";":

            # CASE 1 : first var dec
            if (var_type == ""):
                # var
                self.advance()

                # type
                self.advance()
                var_type = self.current_node_value

                self.advance()
                var_name = self.current_node_value

            # CASE 2 : after ','
            else:
                self.advance()
                var_name = self.current_node_value

            # VM
            self.symbol_table.define(var_name, var_type, "VAR")
            
            if self.next_node_value == ",":
                self.advance()

        # ;
        self.advance()



    """
    Compiles a sequence of statements. Does not handle the enclosing '{}'.
    statements: statement*
    """
    def compile_statements(self) :

        while self.next_node_value != "}":

            cursor_should_move = True

            if self.next_node_value == "let" :
                self.compile_let()
                cursor_should_move = False

            elif self.next_node_value == "if" :
                self.compile_if()
                cursor_should_move = False

            elif self.next_node_value == "while" :
                self.compile_while()
                cursor_should_move = False

            elif self.next_node_value == "do" :
                self.compile_do()
                cursor_should_move = False

            elif self.next_node_value == "return" :
                self.compile_return()
                cursor_should_move = False

            if (cursor_should_move):
                self.advance()

            
    """
    Compiles a let statement.
    letStatement: 'let' varName ( '['expression']' )? '=' expression ';'
    """
    def compile_let(self) :

        # let
        self.advance()

        # varName
        self.advance()
        var_name = self.current_node_value
        var_kind = self.symbol_table.kind_of(var_name)
        var_index = self.symbol_table.index_of(var_name)

        is_array = False

        # '['expression']'
        if self.next_node_value == "[" :

            is_array = True
            
            self.advance() # [
            self.compile_expression() # expression
            self.advance() # ]

            self.vm_writer.write_push(var_kind, var_index)
            self.vm_writer.write_arithmetic('ADD')

        # =
        self.advance()

        # expression
        self.compile_expression()

        # ;
        self.advance()

        # WVM
        if is_array:
            self.vm_writer.write_pop("temp", 0)
            self.vm_writer.write_pop("pointer", 1)
            self.vm_writer.write_push("temp", 0)
            self.vm_writer.write_pop("that", 0)
        else:
            self.vm_writer.write_pop(var_kind, var_index)

    """
    Compiles a if statement, possibly with a trailing else clause.
    ifStatement: 'if' '('expression')' '{'statements'}' ('else''{'statements'}')?
    """
    def compile_if(self):

        # if
        self.advance()

        # (
        self.advance()

        # expression
        self.compile_expression()

        # not
        # self.vm_writer.write_arithmetic("not")
        self.if_label_counter = self.if_label_counter + 1

        # WVM
        label_if_true = "IF_TRUE_" + str(self.if_label_counter)
        label_if_false = "IF_FALSE_" + str(self.if_label_counter)
        label_if_end = "IF_END_" + str(self.if_label_counter)
        self.vm_writer.write_if(label_if_true)
        self.vm_writer.write_go_to(label_if_false)
        self.vm_writer.write_label(label_if_true)

        # )
        self.advance()

        # {
        self.advance()

        # statements
        self.compile_statements()

        # }
        self.advance()

        if self.next_node_value == "else":

            self.vm_writer.write_go_to(label_if_end)
            self.vm_writer.write_label(label_if_false)

            # else
            self.advance()

            # {
            self.advance()

            self.compile_statements()

            # }
            self.advance()

            self.vm_writer.write_label(label_if_end)

        else:
            self.vm_writer.write_label(label_if_false)




    """
    Compiles a while statement.
    whileStatement: 'while' '('expression')''{'statements'}'
    """
    def compile_while(self) :

        self.while_label_counter = self.while_label_counter + 1

        # WVM
        label_while_exp = "WHILE_EXP_" + str(self.while_label_counter)
        label_while_end = "WHILE_END_" + str(self.while_label_counter)

        # while
        self.advance()
        self.vm_writer.write_label(label_while_exp)

        # (
        self.advance()

        # expression
        self.compile_expression()
        self.vm_writer.write_arithmetic("not")
        self.vm_writer.write_if(label_while_end)

        # )
        self.advance()

        # {
        self.advance()

        self.compile_statements()

        # WVM
        self.vm_writer.write_go_to(label_while_exp)
        self.vm_writer.write_label(label_while_end)

        # }
        self.advance()



    """
    Compiles a do statement.
    doStatement: 'do' subroutineCall ';'
    subroutineCall: subroutineName'('expressionList')' | (className|varName)'.'subroutineName '('expressionList')'
    """ 
    def compile_do(self):
        
        # do
        self.advance()

        # subroutineName | (className|varName)
        self.advance()

        full_function_name = ""
        n_args = 0

        # if (
        if self.next_node_value == "(" : # subroutineName'('expressionList')'
            
            # subroutineName
            subroutine_name = self.current_node_value
            full_function_name = self.class_name + "." + subroutine_name
            self.vm_writer.write_push('pointer', 0)
            n_args = n_args + 1
        
        else : # else = '.' => (className|varName)'.'subroutineName '('expressionList')'
            
            first_part_of_full_function_name = ""

            # (className|varName)
            class_or_var_name = self.current_node_value
            
            # ClassName case
            if class_or_var_name[0].isupper():
                first_part_of_full_function_name = class_or_var_name
            # varName case
            else :
                var_type = self.symbol_table.type_of(class_or_var_name)
                first_part_of_full_function_name = var_type
                n_args = n_args + 1
                self.vm_writer.write_push(self.symbol_table.kind_of(class_or_var_name), self.symbol_table.index_of(class_or_var_name))

            # .
            self.advance()

            # subroutineName
            self.advance()
            subroutine_name = self.current_node_value

            full_function_name = first_part_of_full_function_name + "." + subroutine_name


        # (
        self.advance()

        # expressionList
        n_args = n_args + self.compile_expression_list()

        # )
        self.advance()

        # ;
        self.advance()

        # WVM
        self.vm_writer.write_call(full_function_name, n_args)
        self.vm_writer.write_pop('temp', 0)


    """
    Compiles a return statement.
    returnStatement: 'return' expression? ';'
    """
    def compile_return(self) :

        # return
        self.advance()

        if self.next_node_value != ";" :
            self.compile_expression()
        else :
            self.vm_writer.write_push("constant", 0)

        # WVM
        self.vm_writer.write_return()

        # ;
        self.advance()


    """
    Compiles an expression.
    expression: term (op term)*
    """
    def compile_expression(self) :

        # term
        self.compile_term()

        # (op term)*
        op_list = ["+", "-", "*", "/", "&", "|", "<", ">", "=", "&lt;", "&gt;", "&amp;"]

        while self.next_node_value in op_list :

            #op
            self.advance()
            operator = self.current_node_value

            # term
            self.compile_term()
             
            if operator == "+":
                self.vm_writer.write_arithmetic("ADD")

            elif operator == "-":
                self.vm_writer.write_arithmetic("SUB")

            elif operator == "*":
                self.vm_writer.write_call("Math.multiply", 2)

            elif operator == "/":
                self.vm_writer.write_call("Math.divide", 2)

            elif operator == "&" or operator == "&amp;":
                self.vm_writer.write_arithmetic("AND")

            elif operator == "|":
                self.vm_writer.write_arithmetic("OR")

            elif operator == "<" or operator == "&lt;":
                self.vm_writer.write_arithmetic("LT")

            elif operator == ">" or operator == "&gt;":
                self.vm_writer.write_arithmetic("GT")

            elif operator == "=":
                self.vm_writer.write_arithmetic("EQ")


    """
    Compiles a term.
    If the current token is an identifier, the routine must distinguish between :
    - a variable
    - an array entry
    - a subroutine call
    A single look-ahead token, which may be [, ( or . suffices.
    Any other token should not be advanced over.
    term : integerConstant | stringConstant | keywordConstant | varName | varName['expression'] | subroutineCall | '('expression')' | unaryOp term
    subroutineCall: subroutineName'('expressionList')' | (className|varName)'.'subroutineName '('expressionList')' - only case 2 here
    """
    def compile_term(self) :

        """print("________________________")

        print(self.current_node_value)
        print(self.current_node_name)
        print(self.next_node_value)
        print(self.next_node_name)"""
        op_list = ["+", "-", "*", "/", "&", "|", "<", ">", "=", "&lt;", "&gt;", "&amp;"]
        unary_op_list = ["-", "~"]


        # CASE 1 = '('expression')'
        if self.next_node_value == "(":

            #print("case 1")
            # (
            self.advance()

            # expression
            self.compile_expression()

            # )
            self.advance()

        # CASE 2 = term (op term)* -> recursive
        elif self.next_node_value in op_list or self.next_node_value in unary_op_list:

            #print("case 2")
            # op
            self.advance()

            unary_op_term = "ERROR"
            if self.current_node_value == "-":
                unary_op_term = "neg"
            elif self.current_node_value == "~":
                unary_op_term = "not"

            #self.advance()
            if self.next_node_value == "(":
                self.compile_expression()
                self.vm_writer.write_arithmetic(unary_op_term)
            else:
                self.advance()
                self.compile_constant()
                self.vm_writer.write_arithmetic(unary_op_term)


        # CASE 3 = varName['expression']
        elif self.next_NEXT_node_value == "[":

            #print("case 3")

            # varName
            self.advance()
            array_name = self.current_node_value
            array_kind = self.symbol_table.kind_of(array_name)
            array_index = self.symbol_table.index_of(array_name)

            # [
            self.advance()

            # expression
            self.compile_expression()

            self.vm_writer.write_push(array_kind, array_index)
            self.vm_writer.write_arithmetic('ADD')

            # ]
            self.advance()

            self.vm_writer.write_pop('pointer', 1)
            self.vm_writer.write_push('that', 0)

        # CASE 4 subroutineCall = (className|varName)'.'subroutineName '('expressionList')'
        elif self.next_NEXT_node_value == ".": 
            #print("case 4")

            full_function_name = ""
            n_args = 0

            first_part_of_full_function_name = ""

            # (className|varName)
            self.advance()
            class_or_var_name = self.current_node_value

            # ClassName case
            if class_or_var_name[0].isupper():
                first_part_of_full_function_name = class_or_var_name
            # varName case
            else :
                var_type = self.symbol_table.type_of(class_or_var_name)
                first_part_of_full_function_name = var_type
                n_args = n_args + 1
                self.vm_writer.write_push(self.symbol_table.kind_of(class_or_var_name), self.symbol_table.index_of(class_or_var_name))

            # .
            self.advance()

            # subroutineName
            self.advance()
            subroutine_name = self.current_node_value

            full_function_name = first_part_of_full_function_name + "." + subroutine_name
            
            # (
            self.advance()

            # expressionList
            n_args = n_args + self.compile_expression_list()

            # )
            self.advance()

            # WVM
            self.vm_writer.write_call(full_function_name, n_args)


        # CASE 5 (default) = integerConstant | stringConstant | keywordConstant | unaryOp term | varName
        else :

            #print("case 5")

            self.advance()
            self.compile_constant()


    """
    Helper
    To help manage constant logic with unaryOp
    """
    def compile_constant(self):
        
        if self.current_node_name == "integerConstant":
            self.vm_writer.write_push("constant", self.current_node_value)
        
        elif self.current_node_name == "stringConstant":
            self.vm_writer.write_push("constant", len(self.current_node_value))
            self.vm_writer.write_call("String.new", 1)
            for char in self.current_node_value:
                self.vm_writer.write_push('constant', ord(char))
                self.vm_writer.write_call('String.appendChar', 2)

        elif self.current_node_name == "keyword":
            if self.current_node_value == "null":
               self.vm_writer.write_push("constant", 0)
            elif self.current_node_value == "false":
               self.vm_writer.write_push("constant", 0)
            elif self.current_node_value == "true":
               self.vm_writer.write_push("constant", 0)
               self.vm_writer.write_arithmetic("not")
            elif self.current_node_value == "this":
                self.vm_writer.write_push("pointer", 0)

        elif self.current_node_name == "identifier":
            var_name = self.current_node_value
            var_kind = self.symbol_table.kind_of(var_name)
            var_index = self.symbol_table.index_of(var_name)
            self.vm_writer.write_push(var_kind, var_index)


    """
    Compiles a (possibly empty) comma-separated list of expressions.
    expressionList: ( expression (','expression)* )?
    """
    def compile_expression_list(self) :
        
        n_args = 0
        
        while self.next_node_value != ")":
            if (self.next_node_value == ",") :
                # ,
                self.advance()
            else :
                # expression
                self.compile_expression()
                n_args = n_args + 1

        return n_args



    ############################## XML FILE MANAGEMENT ##############################

    def open_compilation_engine_xml_file(self, jack_file_path) :
        self.xml_output_filename = jack_file_path.replace(".jack", ".xml")
        self.xml_output_file = open(self.xml_output_filename, "w")  

    def close_files(self) :
        self.vm_writer.vm_output_file.close()
        self.xml_output_file.close()

    def wr(self, txt):
        self.xml_output_file.write(txt)
        self.xml_output_file.write("\n")
