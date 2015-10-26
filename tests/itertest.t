local std = require "util/std"

terra asdf()
        var a = [std.Vector(int)].salloc()
        a:insert(2)
        a:insert(3)
        var i = a:start()
        while i ~= a:stop() do
                std.printf("%i\n", @i:get())
                i:inc()
        end
end

asdf()
