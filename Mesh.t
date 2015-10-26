local std = require "util/std"
local glm = require "util/glm"
local Material = require "Material"
local Geometry = require "Geometry"

local struct Mesh(std.Object) {
        geometry: &Geometry
        material: &Material
        position: glm.vec3
}

terra Mesh.methods.create(geo: &Geometry, material: &Material)
        return Mesh {
                geometry = geo;
                material = material;
                position = glm.vec3.create(0, 0, 0)
        }
end

terra Mesh:getTransform()
        return glm.mat4.translate(self.position:unpack())
end

return Mesh
