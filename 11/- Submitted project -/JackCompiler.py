class Main(object):
    
    def __init__(self, file_or_dir_path):

        files_to_compile = [] 

        if file_or_dir_path.endswith(".jack"): # HANDLING SINGLE FILE
            files_to_compile.append(file_or_dir_path)

        else: # HANDLING DIRECTORY
            for filename in os.listdir(file_or_dir_path):
                if filename.endswith(".jack"):
                    files_to_compile.append(filename)


        for filename in files_to_compile :
            jack_file_path = os.path.join(file_or_dir_path, filename)
            tokenizer_output_filename = self.tokenizer_magic(jack_file_path)
            vm_output_file = jack_file_path.replace(".jack", ".vm")
            self.compilation_engine_magic(jack_file_path, tokenizer_output_filename, vm_output_file)

    
    def tokenizer_magic(self, jack_file_path):

        tokenizer = JackTokenizer(jack_file_path)

        tokenizer.open_tokenizer_xml_file(jack_file_path)
        tokenizer.write_tokens_start()

        while tokenizer.has_more_tokens:
            tokenizer.advance()
            tokenizer.write_token(tokenizer.token_type, tokenizer.token_value)

        tokenizer.write_tokens_end()
        tokenizer.close_tokenizer_xml_file()

        return tokenizer.xml_output_filename

    
    def compilation_engine_magic(self, jack_file_path, tokenizer_output_filename, vm_output_file):

        compilation_engine = CompilationEngine(tokenizer_output_filename, vm_output_file)

        compilation_engine.open_compilation_engine_xml_file(jack_file_path)
        compilation_engine.compile_class()
        compilation_engine.close_files()



if __name__ == '__main__':
    import sys
    import os

    from CompilationEngine import CompilationEngine
    from JackTokenizer import JackTokenizer

    file_or_dir_path = sys.argv[1]
    main = Main(file_or_dir_path)