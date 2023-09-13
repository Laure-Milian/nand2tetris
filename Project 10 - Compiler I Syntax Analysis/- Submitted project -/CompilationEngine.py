class CompilationEngine(object):

    def __init__(self, input_file_from_tokenizer):
        
        self.tokenizer_file = open(input_file_from_tokenizer, 'r')

        from xml.dom import minidom
        tokenizer_xml = minidom.parse(input_file_from_tokenizer)
        
        self.all_tokens_nodes = []

        for child_node in tokenizer_xml.getElementsByTagName('tokens')[0].childNodes :    
            if child_node.toxml().strip() != "" :
                self.all_tokens_nodes.append(child_node)

        self.current_node_index = 0

    ############################## ITERATION MANAGEMENT ##############################

    @property
    def current_node(self):
        return self.all_tokens_nodes[self.current_node_index]

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

        # start
        self.wr("<class>")

        # 'class'
        self.wr(self.current_node.toxml()) # <keyword> class </keyword>

        # classname
        self.advance()
        self.wr(self.current_node.toxml()) # <identifier> XXX </identifier>

        # '{'
        self.advance()
        self.wr(self.current_node.toxml()) # <symbol> { </symbol>

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
        self.wr(self.current_node.toxml()) # <symbol> } </symbol>

        # end
        self.wr("</class>")

    
    """
    Compiles a static variable declaration, or a field declaration.
    classVarDec: ('static'|'field') type varName (',', varName)* ';'
    type: 'int'|'char'|'boolean'|className
    className: identifier
    varName: identifier
    """
    def compile_class_var_dec(self) :

        # start
        self.wr("<classVarDec>")        

        # ('static'|'field')
        self.advance()
        self.wr(self.current_node.toxml()) # <keyword> static|field </keyword>
        
        # type
        self.advance()
        self.wr(self.current_node.toxml()) # <keyword> 'int'|'char'|'boolean'|className </keyword>
        
        # varName
        self.advance()
        self.wr(self.current_node.toxml()) # <identifier> XXX </identifier>

        # (',', varName)*
        # Optionnal, check next node.
        while self.next_node_name == "symbol" and self.next_node_value == ",":
            # ,
            self.advance()
            self.wr(self.current_node.toxml()) # <symbol> , </symbol>
            # varName
            self.advance()
            self.wr(self.current_node.toxml()) # <identifier> XXX </identifier>

        # ';'
        self.advance()
        self.wr(self.current_node.toxml()) # <symbol> ; </symbol>
        
        # end
        self.wr("</classVarDec>")

    
    """
    Compiles a complete method, function, or constructor.
    subroutineDec: ('constructor'|'function'|'method') ('void'|type) subroutineName '(' parameterList ')' subroutineBody
    """
    def compile_subroutine_dec(self) :

        # start
        self.wr("<subroutineDec>")

        # ('constructor'|'function'|'method')
        self.advance()
        self.wr(self.current_node.toxml()) # <keyword> constructor|function|method </keyword>

        # ('void'|type)
        self.advance()
        self.wr(self.current_node.toxml())

        # subroutineName
        self.advance()
        self.wr(self.current_node.toxml())

        # (
        self.advance()
        self.wr(self.current_node.toxml())

        # compile_parameter_list
        self.compile_parameter_list()

        # )
        self.advance()
        self.wr(self.current_node.toxml())

        # compile_subroutine_body
        self.compile_subroutine_body()
        
        # end
        self.wr("</subroutineDec>")


    """
    Compiles a (possibly empty) parameter list. Does not handle the enclosing '()'.
    parameterList: ( (type varName) (',', type varName)* )?
    """
    def compile_parameter_list(self) :
        
        # start
        self.wr("<parameterList>")

        while self.next_node_value != ")":
            self.advance()
            self.wr(self.current_node.toxml())

        # end
        self.wr("</parameterList>")


    """
    Compiles a subroutine's body.
    subroutineBody: '{' varDec* statements '}'
    """
    def compile_subroutine_body(self) :

        # start
        self.wr("<subroutineBody>")

        # {
        self.advance()
        self.wr(self.current_node.toxml())

        # varDec*
        # Optionnal, check next node.
        while self.next_node_name == "keyword" and self.next_node_value == "var":
            self.compile_var_dec()

        # statements
        self.compile_statements()

        # }
        self.advance()
        self.wr(self.current_node.toxml())
        
        # end
        self.wr("</subroutineBody>")


    """
    Compiles a var declaration.
    varDec: 'var' type varName (',' varName)* ';'
    """
    def compile_var_dec(self) :

        # start
        self.wr("<varDec>")

        while self.next_node_value != ";":
            self.advance()
            self.wr(self.current_node.toxml())

        # ;
        self.advance()
        self.wr(self.current_node.toxml())

        # end
        self.wr("</varDec>")


    """
    Compiles a sequence of statements. Does not handle the enclosing '{}'.
    statements: statement*
    """
    def compile_statements(self) :

        # start
        self.wr("<statements>")

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

        # end
        self.wr("</statements>")
            
    """
    Compiles a let statement.
    letStatement: 'let' varName ( '['expression']' )? '=' expression ';'
    """
    def compile_let(self) :
        # start
        self.wr("<letStatement>")

        # let
        self.advance()
        self.wr(self.current_node.toxml())

        # varName
        self.advance()
        self.wr(self.current_node.toxml())

        # '['expression']'
        if self.next_node_value == "[" :
            self.advance()
            self.wr(self.current_node.toxml()) # [
            self.compile_expression() # expression
            self.advance()
            self.wr(self.current_node.toxml()) # ]

        # =
        self.advance()
        self.wr(self.current_node.toxml())

        # expression
        self.compile_expression()

        # ;
        self.advance()
        self.wr(self.current_node.toxml())

        # end
        self.wr("</letStatement>")

    """
    Compiles a if statement, possibly with a trailing else clause.
    ifStatement: 'if' '('expression')' '{'statements'}' ('else''{'statements'}')?
    """
    def compile_if(self) : #TODO
        
        # start
        self.wr("<ifStatement>")

        # if
        self.advance()
        self.wr(self.current_node.toxml())

        # (
        self.advance()
        self.wr(self.current_node.toxml())

        # expression
        self.compile_expression()

        # )
        self.advance()
        self.wr(self.current_node.toxml())

        # {
        self.advance()
        self.wr(self.current_node.toxml())

        self.compile_statements()

        # }
        self.advance()
        self.wr(self.current_node.toxml())

        if self.next_node_value == "else":

            # else
            self.advance()
            self.wr(self.current_node.toxml())

            # {
            self.advance()
            self.wr(self.current_node.toxml())

            self.compile_statements()

            # }
            self.advance()
            self.wr(self.current_node.toxml())


        # end
        self.wr("</ifStatement>")

    """
    Compiles a while statement.
    whileStatement: 'while' '('expression')''{'statements'}'
    """
    def compile_while(self) :

        # start
        self.wr("<whileStatement>")

        # while
        self.advance()
        self.wr(self.current_node.toxml())

        # (
        self.advance()
        self.wr(self.current_node.toxml())

        # expression
        self.compile_expression()

        # )
        self.advance()
        self.wr(self.current_node.toxml())

        # {
        self.advance()
        self.wr(self.current_node.toxml())

        self.compile_statements()

        # }
        self.advance()
        self.wr(self.current_node.toxml())

        # end
        self.wr("</whileStatement>")


    """
    Compiles a do statement.
    doStatement: 'do' subroutineCall ';'
    subroutineCall: subroutineName'('expressionList')' | (className|varName)'.'subroutineName '('expressionList')'
    """ 
    def compile_do(self):
        
        # start
        self.wr("<doStatement>")

        # do
        self.advance()
        self.wr(self.current_node.toxml())

        # subroutineName | (className|varName)
        self.advance()
        self.wr(self.current_node.toxml())

        # if (
        if self.next_node_value == "(" :
            self.compile_subroutine_call_format_1()
        else : # else = '.'
            self.compile_subroutine_call_format_2()

        # ;
        self.advance()
        self.wr(self.current_node.toxml())

        # end
        self.wr("</doStatement>")

    """
    Compiles a return statement.
    returnStatement: 'return' expression? ';'
    """
    def compile_return(self) :
        
        # start
        self.wr("<returnStatement>")

        # do
        self.advance()
        self.wr(self.current_node.toxml())

        if self.next_node_value != ";" :
            self.compile_expression()

        # ;
        self.advance()
        self.wr(self.current_node.toxml())

        # end
        self.wr("</returnStatement>")

    """
    Compiles an expression.
    expression: term (op term)*
    """
    def compile_expression(self) :

        # start
        self.wr("<expression>")
        
        # term
        self.compile_term()

        # (op term)*
        op_list = ["+", "-", "*", "/", "&", "|", "<", ">", "=", "&lt;", "&gt;", "&amp;"]
        while self.next_node_value in op_list :

            #op
            self.advance()
            self.wr(self.current_node.toxml())
            
            # term
            self.compile_term()

        # end
        self.wr("</expression>")


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

        # start
        self.wr("<term>")

        # (op term)*
        op_list = ["+", "-", "*", "/", "&", "|", "<", ">", "=", "&lt;", "&gt;", "&amp;"]
        unary_op_list = ["-", "~"]

        # CASE 1 = '('expression')'
        if self.next_node_value == "(":

            # (
            self.advance()
            self.wr(self.current_node.toxml())

            # expression
            self.compile_expression()

            # )
            self.advance()
            self.wr(self.current_node.toxml())

        # CASE ? = term (op term)* -> recursive
        elif self.next_node_value in op_list or self.next_node_value in unary_op_list:

            # op
            self.advance()
            self.wr(self.current_node.toxml())

            # expression
            self.compile_term()

        # CASE 2 = varName['expression']
        elif self.next_NEXT_node_value == "[":

            # varName
            self.advance()
            self.wr(self.current_node.toxml())

            # [
            self.advance()
            self.wr(self.current_node.toxml())

            # expression
            self.compile_expression()

            # ]
            self.advance()
            self.wr(self.current_node.toxml())

        # CASE 3 subroutineCall = (className|varName)'.'subroutineName '('expressionList')'
        elif self.next_NEXT_node_value == ".": 
    
            # (className|varName)
            self.advance()
            self.wr(self.current_node.toxml())

            # '.'subroutineName '('expressionList')'
            self.compile_subroutine_call_format_2()

        # CASE 4 (default) = integerConstant | stringConstant | keywordConstant | unaryOp term | varName
        else :

            self.advance()
            self.wr(self.current_node.toxml())

        
        # end
        self.wr("</term>")


    """
    Compiles a (possibly empty) comma-separated list of expressions.
    expressionList: ( expression (','expression)* )?
    """
    def compile_expression_list(self) :
        
        # start
        self.wr("<expressionList>")

        while self.next_node_value != ")":
            if (self.next_node_value == ",") :
                # ,
                self.advance()
                self.wr(self.current_node.toxml())
            else :
                # expression
                self.compile_expression()


        # end
        self.wr("</expressionList>")

    """
    Helper
    subroutineCall: subroutineName'('expressionList')'
    """
    def compile_subroutine_call_format_1(self):

        # (
        self.advance()
        self.wr(self.current_node.toxml())

        # expressionList
        self.compile_expression_list()

        # )
        self.advance()
        self.wr(self.current_node.toxml())


    """
    Helper
    subroutineCall: (className|varName)'.'subroutineName '('expressionList')'
    """
    def compile_subroutine_call_format_2(self):
    
        # .
        self.advance()
        self.wr(self.current_node.toxml())

        # subroutineName
        self.advance()
        self.wr(self.current_node.toxml())

        # (
        self.advance()
        self.wr(self.current_node.toxml())

        # expressionList
        self.compile_expression_list()

        # )
        self.advance()
        self.wr(self.current_node.toxml())


    ############################## XML FILE MANAGEMENT ##############################

    def open_compilation_engine_xml_file(self, jack_file_path) :
        self.xml_output_filename = jack_file_path.replace(".jack", ".xml")
        self.xml_output_file = open(self.xml_output_filename, "w")  

    def close_compilation_engine_xml_file(self) :
        self.xml_output_file.close()

    def wr(self, txt):
        self.xml_output_file.write(txt)
        self.xml_output_file.write("\n")
