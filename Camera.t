local glm = require "util/glm"

local M = terralib.includec("math.h")


local struct Camera {
        position: glm.vec3
        rotation: glm.vec2
}

terra Camera.methods.create()
        return Camera {
                position = glm.vec3.create(0.0, 0.0, 0.0);
                rotation = glm.vec2.create(0.0, 0.0);
        }
end

terra Camera:getRotationTransform()
        return glm.mat4.rotatex(-self.rotation.y) * glm.mat4.rotatez(self.rotation.x)
end

terra Camera:move(movement: glm.vec3)
        self.position = self.position +
                glm.mat3.rotatez(-self.rotation.x)
                * glm.mat3.rotatex(self.rotation.y)
                * movement
end

terra Camera:getTransform()
        -- return glm.mat4.orthographic(-400, 400, -300, 300, -100, 100) * glm.mat4.scale(100, 100, 1)
        return  glm.mat4.perspective(M.M_PI/4, 3.0/4.0, 0.125, 1024.0)
              * glm.mat4.create(1,0,0,0, 0,0,1,0, 0,-1,0,0, 0,0,0,1)
              * self:getRotationTransform()
              * glm.mat4.translate((-1*self.position):unpack())
end

return Camera
