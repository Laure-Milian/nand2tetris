################################### JACK TOKENIZER ###################################

class JackTokenizer(object):

    ############################## INIT / SETTERS ##############################

    def __init__(self, jack_filename):
        
        self.keywords_dictionnary = ["class", "constructor", "function", "method", "field", "static", "var", "int", "char", "boolean", "void", "true", "false", "null", "this", "let", "do", "if", "else", "while", "return"]
        self.symbols_dictionnary = ["{", "}", "(", ")", "[", "]", ".", ",", ";", "+", "-", "*", "/", "&", "|", "<", ">", "=", "~"]

        self.jack_file = open(jack_filename, 'r')
        
        self.all_tokens = []
        self.set_all_tokens()
        
        self.current_token_index = -1
        self.max_token_index = len(self.all_tokens) -1


    def set_all_tokens(self) :

        multiline_comment_is_on = False

        for line_before_strip in self.jack_file.readlines() :

            line = line_before_strip.strip()

            if line == "": # ligne vide
                continue
            
            if line.startswith('//') : # commentaire 1 ligne
                continue
            
            elif line.startswith('/*') or line.startswith('/**') : # commentaire multilignes
                if not line.endswith("*/") :
                    multiline_comment_is_on = True
                continue
            
            elif multiline_comment_is_on and not line.endswith("*/") : # on saute les lignes d'un com multilignes
                continue

            elif multiline_comment_is_on and line.endswith("*/") : # fin du com multilignes
                multiline_comment_is_on = False
                continue

            else :
                if "//" in line : # manage inline comment
                    line = line.split("//")[0]

                elif "/*" in line: # manage inline comment bis
                    line = line.split("/*")[0]

                elif "/**" in line: # manage inline comment ter
                    line = line.split("/*")[0]

                tokensForLine = self.get_set_of_tokens_from_line(line)
                self.all_tokens = self.all_tokens + tokensForLine


    def get_set_of_tokens_from_line(self, line):
        
        tokens = []
        chars_count = len(line)

        token_currently_in_construction = ""
        is_in_quotes = False

        for current_index in range(chars_count):
            
            char = line[current_index]
            
            if is_in_quotes and char != '"' :
                token_currently_in_construction += char

            elif char == '"' :
                token_currently_in_construction += char
                is_in_quotes = not is_in_quotes

            elif char.strip() == "" : # whitespace = fin du token en cours
                if token_currently_in_construction.strip() != "" :
                    tokens.append(token_currently_in_construction)
                token_currently_in_construction = ""

            elif char in self.symbols_dictionnary : # symbole = fin du token en cours + ajout du symbole comme token
                if token_currently_in_construction.strip() != "" :
                    tokens.append(token_currently_in_construction)
                tokens.append(char)
                token_currently_in_construction = ""

            else :
                token_currently_in_construction += char
        
        return tokens


    ############################## ITERATION MANAGEMENT ##############################

    def advance(self):
        self.current_token_index += 1

    @property
    def has_more_tokens(self):
        return self.current_token_index < self.max_token_index

    @property
    def current_token(self):
        return self.all_tokens[self.current_token_index]


    ############################## TOKENS TYPES ##############################

    @property
    def token_type(self):
        
        if self.current_token in self.keywords_dictionnary :
            return "KEYWORD"

        elif self.current_token in self.symbols_dictionnary :
            return "SYMBOL"

        elif self.current_token.isnumeric() :
            return "INT_CONST"

        elif self.current_token.startswith('"') :
            return "STRING_CONST"

        else :
            return "IDENTIFIER"

    @property
    def current_token_is_keyword(self): 
        return self.token_type == "KEYWORD"
    
    @property
    def current_token_is_symbol(self): 
        return self.token_type == "SYMBOL"
    
    @property
    def current_token_is_int_const(self): 
        return self.token_type == "INT_CONST"
    
    @property
    def current_token_is_string_const(self): 
        return self.token_type == "STRING_CONST"
    
    @property
    def current_token_is_identifier(self): 
        return self.token_type == "IDENTIFIER"

    ############################## TOKENS VALUES ##############################
    
    @property
    def token_value(self) :
        if self.current_token_is_keyword :
            return self.keyword
        
        elif self.current_token_is_symbol :
            return self.symbol

        elif self.current_token_is_int_const :
            return self.int_val

        elif self.current_token_is_string_const :
            return self.string_val

        elif self.current_token_is_identifier :
            return self.identifier

        else :
            return "ERROR IN GET TOKEN VALUE"

    @property
    def keyword(self):
        if not self.current_token_is_keyword :
            return "ERROR"
        return self.current_token

    @property
    def symbol(self):
        if not self.current_token_is_symbol :
            return "ERROR"
        return self.current_token

    @property
    def int_val(self):
        if not self.current_token_is_int_const :
            return "ERROR"
        return self.current_token

    @property
    def string_val(self):
        if not self.current_token_is_string_const :
            return "ERROR"
        str_value_after_removing_quotes = self.current_token[1:-1]
        return str_value_after_removing_quotes

    @property
    def identifier(self):
        if not self.current_token_is_identifier :
            return "ERROR"
        return self.current_token

    

    ############################## XML FILE MANAGEMENT ##############################

    def open_tokenizer_xml_file(self, jack_file_path) :
        self.xml_output_filename = jack_file_path.replace(".jack", "-tokenizer.xml")
        self.xml_output_file = open(self.xml_output_filename, "w")  

    def close_tokenizer_xml_file(self) :
        self.xml_output_file.close()

    def wr(self, txt):
        self.xml_output_file.write(txt)

    def write_tokens_start(self) :
        self.wr("<tokens>")

    def write_tokens_end(self) :
        self.wr("\n")
        self.wr("</tokens>")

    def write_token(self, token_type, token_value) :

        # Manage special rules on type
        if token_type == "STRING_CONST":
            token_type = "stringConstant"
        elif token_type == "INT_CONST":
            token_type = "integerConstant"
        else :
            token_type = token_type.lower()

        # Manage special rules on value
        if token_type == "symbol" :
            if token_value == "<":
                token_value = "&lt;"
            elif token_value == ">":
                token_value = "&gt;"
            elif token_value == '"':
                token_value = "&quot;"
            elif token_value == "&":
                token_value = "&amp;"

        self.wr("\n")
        self.wr("<")
        self.wr(token_type)
        self.wr("> ")
        self.wr(token_value)
        self.wr(" </")
        self.wr(token_type)
        self.wr(">")