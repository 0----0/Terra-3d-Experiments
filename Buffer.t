local std = require "util/std"
require "lib/gl"

local struct Buffer(std.Object) {
        id: GL.uint
}

terra Buffer.methods.create()
        return Buffer { id=gl.CreateBuffer() }
end

terra Buffer:__destruct()
        gl.DeleteBuffer(self.id)
end

terra Buffer:assign(size: uint, data: &opaque, usage: GL.enum)
        gl.NamedBufferData(self.id, size, data, usage)
end

return Buffer
