local std = require "std"

terra main()
        var g: int
        do
                var x: int
                std.scanf("%d", &x)
                defer std.printf("%d\n", 3)
                if x == 3 then g=1 goto exit end
                std.scanf("%d", &x)
                defer std.printf("%d\n", 3)
                if x == 3 then g=2 goto exit end
                std.scanf("%d", &x)
                defer std.printf("%d\n", 3)
                if x == 3 then g=2 goto exit end
                std.scanf("%d", &x)
                defer std.printf("%d\n", 3)
                if x == 3 then g=2 goto exit end
                std.scanf("%d", &x)
                defer std.printf("%d\n", 3)
                if x == 3 then g=2 goto exit end
                std.scanf("%d", &x)
                defer std.printf("%d\n", 3)
                if x == 3 then g=2 goto exit end
                std.scanf("%d", &x)
                defer std.printf("%d\n", 3)
                if x == 3 then g=2 goto exit end
                std.scanf("%d", &x)
                defer std.printf("%d\n", 3)
                if x == 3 then g=2 goto exit end
        end
        ::exit::
end

main:disas()
terralib.saveobj("tests/defertest3.s", {main=main})
