local std = terralib.includec("stdio.h")

expr = macro(function()
        local exprs = terralib.newlist {`1, `2}
        local q = quote in exprs end
        return `unpacktuple(q)
end)

local terra twoargs(x: int, y: int)
        std.printf("%d %d\n", x, y)
end

local terra test()
        var x, y = expr()
        twoargs(expr())
end
-- test()
