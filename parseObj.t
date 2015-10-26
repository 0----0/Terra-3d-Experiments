local Geometry = require "Geometry"
local std = require "util/std"

local terra parseObj(filename: rawstring)
        var file = std.fopen(filename, "rb") defer std.fclose(file)

        var line: rawstring = nil defer std.free(line)
        var linebfsz: std.size_t = 0
        while true do
                var linesz = std.getline(&line, &linebfsz, file)
                if linesz == -1 then break end
                std.printC(line)
        end
end

parseObj("marisa.obj")
