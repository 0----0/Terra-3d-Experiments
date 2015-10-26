local std = require "std"

local struct Shader(std.Object) {
        shaderID: GL.uint
}

terra Shader:isAlive()
        return self.shaderID ~= 0
end

terra Shader:getint(name: GL.enum)
        var result: GL.int
        gl.GetShaderiv(self.shaderID, name, &result)
        return result
end

terra Shader:getInfoLog()
        var len = self:getint(gl.INFO_LOG_LENGTH)
        if len == 0 then return nil end
        var infolog = rawstring(std.malloc(len))
        if infolog == nil then return nil end
        gl.GetShaderInfoLog(self.shaderID, len, nil, infolog)
        return infolog
end

terra Shader:initFromString(type: GL.enum, shaderSource: rawstring)
        self.shaderID = gl.CreateShader(type)
        if self.shaderID == 0 then return end
        gl.ShaderSource(self.shaderID, 1, &shaderSource, nil)
        gl.CompileShader(self.shaderID)

        var success = self:getint(gl.COMPILE_STATUS)
        if success == 0 then
                var infolog = self:getInfoLog()
                if infolog ~= nil then std.puts(infolog) std.free(infolog) end
                gl.DeleteShader(self.shaderID)
                self.shaderID = 0
        end
end

terra Shader.methods.fromString(type: GL.enum, shaderSource: rawstring)
        var self: Shader
        self:initFromString(type, shaderSource)
        return self
end

terra Shader:__destruct()
        gl.DeleteShader(self.shaderID)
end


return Shader
