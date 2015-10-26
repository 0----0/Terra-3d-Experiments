local std = require "std"

local struct myStruct {
        boop: int
}

terra main()
        var boop = myStruct {3}
        std.printf("Hello, world! %d\n", boop.boop)
end

terralib.saveobj("hellowin.exe", {main=main}, terralib.newtarget{triple="i686-pc-win64"})
