local std = require "std"

terra main()
        var x: int
        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 0 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 1 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 2 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 3 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 4 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 5 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 6 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 7 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 8 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 9 end

        std.scanf("%d", &x)
        defer std.printf("%d\n", 3)
        if x == 3 then return 10 end

        return 11
end

terralib.saveobj("defertest2", {main=main})
