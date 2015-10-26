require "lib/gl"
local std = require "util/std"

local struct VertexArray(std.Object) {
        vao: GL.uint
}

terra VertexArray.methods.create()
        return VertexArray {
                vao = gl.CreateVertexArray()
        }
end

terra VertexArray:__destruct()
        gl.DeleteVertexArray(self.vao)
end

terra VertexArray:rawget()
        return self.vao
end

terra VertexArray:use()
        gl.BindVertexArray(self.vao)
end


local terraTypeToGL = {
        [float] = gl.FLOAT;
        [double] = gl.DOUBLE;
        [int8] = gl.BYTE;
        [int16] = gl.SHORT;
        [int] = gl.INT;
        [uint8] = gl.UNSIGNED_BYTE;
        [uint16] = gl.UNSIGNED_SHORT;
        [uint] = gl.UNSIGNED_INT;
}
local initFormatM = macro(function(vao, T, prog)
        T = T:astype()
        local output = terralib.newlist()
        for i,entry in ipairs(T:getentries()) do
                local type = entry.type
                local n = 1
                if type.T and type.N then
                        n = type.N
                        type = type.T
                end
                local glType = terraTypeToGL[type]
                output:insert(quote
                        var attribIdx = gl.GetAttribLocation(prog, [entry.field])
                        if attribIdx ~= -1 then
                                gl.VertexArrayAttribFormat(vao, attribIdx, n, glType, gl.FALSE, [terralib.offsetof(T, entry.field)])
                                gl.VertexArrayAttribBinding(vao, attribIdx, 0)
                                gl.EnableVertexArrayAttrib(vao, attribIdx)
                        end
                end)
        end
        return output
end)
local initFormat = function(T)
        return terra(vao: GL.uint, prog: GL.uint)
                initFormatM(vao, T, prog)
        end
end
initFormat = terralib.memoize(initFormat)

VertexArray.methods.formatVertexAttribs = macro(function(self,T, prog)
        T = T:astype()
        return `[initFormat(T)](self.vao, prog)
end)

return VertexArray
