local C = terralib.includecstring [[
#include <time.h>
#include <stdlib.h>
]]

local math = {}

math.UUID = uint64

local seeded = terralib.global(false)
terra math.generateUUID(): math.UUID
        if not seeded then
                C.srand(C.time(nil))
                seeded = true
        end
        return math.UUID(C.rand()) or math.UUID(C.rand()) << 32
end

return math
