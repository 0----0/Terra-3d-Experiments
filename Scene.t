local std = require "util/std"
local glm = require "util/glm"
local RBTree = require "util/RBTree"
local Mesh = require "Mesh"

local struct Scene(std.Object) {
        backgroundColor: glm.vec4
        objects: std.Vector(&Mesh)
}

terra Scene.methods.create()
        return Scene {
                backgroundColor = glm.vec4.create(0.0, 0.0, 0.0, 0.0);
                objects = [std.Vector(&Mesh)].create();
        }
end

terra Scene:setBackgroundColor(col: glm.vec4): {}
        self.backgroundColor = col
end

terra Scene:setBackgroundColor(col: glm.vec3): {}
        self:setBackgroundColor(glm.vec4.create(col, 1.0))
end

terra Scene:addObject(obj: &Mesh)
        return self.objects:insert(obj)
end

terra Scene:get(i:uint)
        return self.objects:get(i)
end

return Scene
