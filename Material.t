local std = require "util/std"
local glm = require "util/glm"

local struct Material(std.Object) {
        color: glm.vec3
}

terra Material.methods.create()
        return Material {
                color = glm.vec3.create(0, 0, 0)
        }
end

terra Material:getColor()
        return self.color
end

terra Material:setColor(col: glm.vec3)
        self.color = col
end

return Material
