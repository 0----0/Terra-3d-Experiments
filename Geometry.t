local std = require "util/std"
require "lib/gl"
local math = require "util/math"
local glm = require "util/glm"
local Vertex = require "Vertex"

local struct Geometry(std.Object) {
        uuid: math.UUID
        verts: std.Vector(Vertex)
        indices: std.Vector(uint)
}

terra Geometry.methods.create()
        var self = Geometry {
                uuid = math.generateUUID();
        }
        self.verts:init()
        self.indices:init()
        return self
end

terra Geometry:transform(matrix: glm.mat3)
        var i = self.verts:start()
        while i ~= self.verts:stop() do
                i:get().position = matrix * i:get().position
                i:inc()
        end
end

terra Geometry:transform(matrix: glm.mat4)
        var i = self.verts:start()
        while i ~= self.verts:stop() do
                i:get().position = matrix * i:get().position
                i:inc()
        end
end

terra Geometry.methods.squareGeom()
        var self = Geometry.create()
        self.verts:assign(
                array(
                        Vertex {
                                position=arrayof(float, 0.0, 0.0, 0.0);
                                texCoords=arrayof(float, 0.0, 0.0);
                        },
                        Vertex {
                                position=arrayof(float, 1.0, 0.0, 0.0);
                                texCoords=arrayof(float, 1.0, 0.0);
                        },
                        Vertex {
                                position=arrayof(float, 1.0, 1.0, 0.0);
                                texCoords=arrayof(float, 1.0, 1.0);
                        },
                        Vertex {
                                position=arrayof(float, 0.0, 1.0, 0.0);
                                texCoords=arrayof(float, 0.0, 1.0);
                        }
                )
        )
        self.indices:assign(arrayof(uint, 0, 1, 3, 1, 2, 3))
        return self
end
terra Geometry.methods.cubeGeom()
        var self = Geometry.create()
        self.verts:assign(arrayof(Vertex,
                Vertex {arrayof(float, 0.0, 0.0, 0.0)},
                Vertex {arrayof(float, 0.0, 0.0, 1.0)},
                Vertex {arrayof(float, 0.0, 1.0, 0.0)},
                Vertex {arrayof(float, 0.0, 1.0, 1.0)},
                Vertex {arrayof(float, 1.0, 0.0, 0.0)},
                Vertex {arrayof(float, 1.0, 0.0, 1.0)},
                Vertex {arrayof(float, 1.0, 1.0, 0.0)},
                Vertex {arrayof(float, 1.0, 1.0, 1.0)}
        ))
        self.indices:assign(arrayof(uint,
                0, 4, 2, 4, 6, 2,
                0, 1, 2, 1, 2, 3,
                0, 1, 4, 1, 4, 5
        ))
        -- self.indices:assign(arrayof(uint, 0, 4, 2, 4, 6, 2))
        -- self.indices:assign(arrayof(uint,
        --         0,3,1,0,2,3
        -- ))
        return self
end

return Geometry
