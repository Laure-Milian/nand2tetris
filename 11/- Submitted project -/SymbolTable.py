class SymbolTable(object):

    def __init__(self):

        self.class_scope_kinds = ['STATIC', 'FIELD']
        self.subroutine_scope_kinds = ['ARG', 'VAR']

        self.class_variables = []
        self.subroutine_variables = []


    #Starts a new subroutine scope.
    def start_subroutine(self):
        self.subroutine_variables = []
    

    # Defines a new identifier and assigns it a running index.
    def define(self, var_name, var_type, var_kind):
        
        var_kind = var_kind.upper()
        index = self.var_count(var_kind)

        variable_info = {"name": var_name, "type":var_type, "kind": var_kind, "index": index}
        
        if var_kind in self.class_scope_kinds:
            self.class_variables.append(variable_info)
        else:
            self.subroutine_variables.append(variable_info)
    

    # Returns the number of variables of the given kind already defined in the current scope.
    def var_count(self, kind):

        count = 0
        
        if kind in self.class_scope_kinds:
            for v in self.class_variables :
                if (v["kind"] == kind):
                    count += 1
        
        else:
            for v in self.subroutine_variables :
                if (v["kind"] == kind):
                    count += 1

        return count       
    
    
    # Returns the kind of the named identifier in the current scope.
    # If unknown in the current scope = return NONE.
    def kind_of(self, name):
        result_in_subroutine_scope = ""
        result_in_class_scope = ""

        for v in self.subroutine_variables :
            if (v["name"] == name):
                result_in_subroutine_scope = v["kind"]

        for v in self.class_variables :
            if (v["name"] == name):
                result_in_class_scope = v["kind"]
        
        if result_in_subroutine_scope != "":
            return result_in_subroutine_scope
        elif result_in_class_scope != "":
            return result_in_class_scope
        else:
            return "NONE"

    
    # Returns the type of the named identifier in the current scope.
    def type_of(self, name):
        result_in_subroutine_scope = ""
        result_in_class_scope = ""

        for v in self.subroutine_variables :
            if (v["name"] == name):
                result_in_subroutine_scope = v["type"]

        for v in self.class_variables :
            if (v["name"] == name):
                result_in_class_scope = v["type"]

        if result_in_subroutine_scope != "":
            return result_in_subroutine_scope
        elif result_in_class_scope != "":
            return result_in_class_scope
        else:
            return "NONE"

    # Returns the index assigned to the named identifier.
    def index_of(self, name):
        result_in_subroutine_scope = -1
        result_in_class_scope = -1

        for v in self.subroutine_variables :
            if (v["name"] == name):
                result_in_subroutine_scope = v["index"]

        for v in self.class_variables :
            if (v["name"] == name):
                result_in_class_scope = v["index"]
        
        if result_in_subroutine_scope != -1:
            return result_in_subroutine_scope
        elif result_in_class_scope != -1:
            return result_in_class_scope
        else:
            return -1