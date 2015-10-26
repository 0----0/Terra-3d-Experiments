return {
        name = "template";
        entrypoints={"template"};
        keywords = {"typename", "val"};
        expression = function(self, lex)
                lex:expect("template")
                lex:expect("<")
                local names = terralib.newlist()
                repeat
                        local typefn
                        if lex:nextif("typename") then typefn = function(x) return x:astype() end
                        elseif lex:expect("val") then typefn = function(x) return x:asvalue() end end
                        names:insert({lex:expect(lex.name).value, typefn})
                until not lex:nextif(",")
                lex:expect(">")
                local expr = lex:luaexpr()
                return function(envfn)
                        return macro(terralib.memoize(function(...)
                                local env = envfn()
                                for i,v in ipairs(names) do
                                        env[v[1]] = v[2](select(i,...))
                                end
                                return expr(env)
                        end))
                end
        end;
}
