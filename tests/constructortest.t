local std = require "util/std"

local function dumptable(tbl) for k,v in pairs(tbl) do print(k,v) end end


local struct vec3 {
        asdf: int
        jkl: int
}

vec3.metamethods.__cast = macro(function(from, to, exp)
        dumptable(from)
        dumptable(exp)
        error("Cast failed.")
end)

terra main()
        var asdf = vec3 {2,3,4}
        std.print(asdf.asdf)
end

print(vec3.convertible)

main()
