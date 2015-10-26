local std = require "std"

terra main()
        var x: int
        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then
                std.scanf("%d", &x)
                defer std.printf("lol\n")
                if x == 4 then
                        return 0
                end
                defer std.printf("no\n")
        end
        std.printf("ay\n")
        defer std.printf("%d\n", 4)
        return 0
end

-- terralib.saveobj("tests/defertest.ll", {main=main})
main()
