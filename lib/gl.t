local function prefix(lib, prefixes)
        local function lookup(_, key)
                for i,prefix in ipairs(prefixes) do
                        local symb = rawget(lib, prefix..key)
                        if symb then return symb end
                end
                return lib[key]
        end
        return setmetatable({____lib=lib}, {__index = lookup})
end

function glFixCreate(func)
        local type = func:gettype()
        if not rawget(type, "parameters") then type = type.type end --dereference function pointer
        local params = type.parameters
        local extraArgs = {}
        for i = 1,#params-2 do table.insert(extraArgs, symbol(params[i])) end
        return terra([extraArgs])
                var ret: params[#params].type --dereference
                func([extraArgs], 1, &ret)
                return ret
        end
end

function glFixDelete(func)
        local type = func:gettype()
        if not rawget(type, "parameters") then type = type.type end
        return terra(obj : type.parameters[2].type)
                func(1, &obj)
        end
end


local _GLEW = terralib.includec("GL/glew.h")
local _GLFW = terralib.includec("GLFW/glfw3.h")
gl = prefix(_GLEW, {"gl", "__glew", "GL_"})
GL = prefix(_GLEW, {"GL"})
glew = prefix(_GLEW, {"glew", "GLEW_"})
glfw = prefix(_GLFW, {"glfw", "GLFW_", "GLFW"})

terralib.linklibrary("libGLEW.so")
terralib.linklibrary("libglfw.so")


gl.CreateBuffer = glFixCreate(gl.CreateBuffers)
gl.DeleteBuffer = glFixDelete(gl.DeleteBuffers)

gl.CreateTexture = glFixCreate(gl.CreateTextures)
gl.DeleteTexture = glFixDelete(gl.DeleteTextures)

gl.CreateVertexArray = glFixCreate(gl.CreateVertexArrays)
gl.DeleteVertexArray = glFixDelete(gl.DeleteVertexArrays)


local C = terralib.includec("stdio.h")
local errs = {
        {err=gl.NO_ERROR, str="No error."},
        {err=gl.INVALID_ENUM, str="Invalid enum."},
        {err=gl.INVALID_VALUE, str="Invalid value."},
        {err=gl.INVALID_OPERATION, str="Invalid operation."},
        {err=gl.INVALID_FRAMEBUFFER_OPERATION, str="Invalid framebuffer operation."},
        {err=gl.OUT_OF_MEMORY, str="Out of memory."},
        {err=gl.STACK_UNDERFLOW, str="Stack underflow."},
        {err=gl.STACK_OVERFLOW, str="Stack overflow."}
}
local function getErrorChecks(err)
        local checkErrs = quote end
        for i,v in ipairs(errs) do
                local errCheck = quote if err == v.err then return v.str end end
                checkErrs = quote checkErrs errCheck end
        end
        return checkErrs
end

local terra getErrorString(err: GL.enum)
        [getErrorChecks(err)]
        return "Unknown error."
end



gl.DumpErrors = terra()
        var error = gl.GetError()
        while error ~= gl.NO_ERROR do
                C.printf("GL error: %s\n", getErrorString(error))
                error = gl.GetError()
        end
end
