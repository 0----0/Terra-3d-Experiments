local expression = function(P)

return {
        name = "cpplang";
        entrypoints = {"cpp"};

        keywords = {"let"};

        expression = function(self, lex)
        end

        statement = function(self, lex)
        end

        localstatement = function(self, lex)
        end
}
