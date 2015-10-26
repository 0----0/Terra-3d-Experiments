local std = require "std"
local glm = require "util/glm"

terra twoargs(x: int, y: int)
        std.printf("%d %d\n", x, y)
end

terra gen()
        std.printf("hi!\n")
        return glm.ivec2.create(1,2)
end

terra main()
        twoargs(gen():unpack())
end

main()
