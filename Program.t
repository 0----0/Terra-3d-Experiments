local Shader = require "Shader"
local std = require "std"

local struct Program {
        programID: GL.uint
}

terra Program:getint(name: GL.enum)
        var result: GL.int
        gl.GetProgramiv(self.programID, name, &result)
        return result
end

terra Program:getInfoLog()
        var len = self:getint(gl.INFO_LOG_LENGTH)
        if len == 0 then return nil end
        var infolog = rawstring(std.malloc(len))
        if infolog == nil then return nil end
        gl.GetProgramInfoLog(self.programID, len, nil, infolog)
        return infolog
end

terra Program:init() self.programID = gl.CreateProgram() end

terra Program.methods.create()
        var self: Program
        self:init()
        return self
end

terra Program:isAlive()
        return self.programID ~= 0
end

terra Program:isLinked()
        return self:isAlive() and self:getint(gl.LINK_STATUS) == gl.TRUE
end

terra Program:addShader(shader: Shader)
        if shader:isAlive() then
                gl.AttachShader(self.programID, shader.shaderID)
        end
end

terra Program:link()
        gl.LinkProgram(self.programID)
        var success = self:getint(gl.LINK_STATUS)
        if success == 0 then
                var infolog = self:getInfoLog()
                if infolog ~= nil then std.puts(infolog) std.free(infolog) end
        end
end

terra Program:use() gl.UseProgram(self.programID) end

terra Program:destruct() gl.DeleteProgram(self.programID) end

terra Program:rawget() return self.programID end

terra Program:getUniformLoc(name: rawstring)
        return gl.GetUniformLocation(self.programID, name)
end

return Program
