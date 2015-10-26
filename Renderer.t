local std = require "util/std"
require "lib/gl"
local RBTree = require "util/RBTree"
local math = require "util/math"
local glm = require "util/glm"
local Window = require "Window"
local Scene = require "Scene"
local Mesh = require "Mesh"
local Geometry = require "Geometry"
local Program = require "Program"
local Shader = require "Shader"
local VertexArray = require "VertexArray"
local Vertex = require "Vertex"

local VertexShader = [[
#version 450
uniform mat4 camera;
uniform mat4 objTransform;

in vec3 position;

void main() {
        gl_Position = camera * objTransform * vec4(position, 1.0);
}
]]

local FragmentShader = [[
#version 450
uniform vec3 color;

in vec2 _texCoords;
out vec4 _color;

void main() {
        _color = vec4(color,1.0);
}
]]

local uniforms = terralib.newlist {
        "camera",
        "objTransform",
        "color",
}

local function Uniforms(uniforms)
        local entries = uniforms:map(function(u) return {field=u, type=GL.uint} end)
        local struct Uniforms {}
        Uniforms.entries = entries

        terra Uniforms:init(program: GL.uint)
                [uniforms:map(function(uniform) return quote
                        self.[uniform] = gl.GetUniformLocation(program, uniform)
                end end)]
        end

        terra Uniforms.methods.create(program: GL.uint)
                var self: Uniforms
                self:init(program)
                return self
        end

        return Uniforms
end

local struct Buffer(std.Object) {
        vertexBuffer: GL.uint;
        indexBuffer: GL.uint;
        numIndices: uint
}
terra Buffer:__destruct()
        gl.DeleteBuffer(self.vertexBuffer)
        gl.DeleteBuffer(self.indexBuffer)
end

local struct Renderer(std.Object) {
        window: &Window

        buffers: RBTree(math.UUID, Buffer)
        program: Program
        uniforms: Uniforms(uniforms)

        vao: VertexArray
}

terra Renderer.methods.create(window: &Window)
        var self = Renderer {
                window = window;
        }
        gl.Enable(gl.DEPTH_TEST)

        self.buffers:init()
        self.program = Program.create()
        self:initProgram()
        self.vao = VertexArray.create()
        self.vao:formatVertexAttribs(Vertex, self.program:rawget())
        return self
end

terra Renderer:initProgram()
        var vert = Shader.fromString(gl.VERTEX_SHADER, VertexShader)
        var frag = Shader.fromString(gl.FRAGMENT_SHADER, FragmentShader)
        self.program:addShader(vert)
        self.program:addShader(frag)
        self.program:link()
        self.program:use()


        -- [initUniforms(`self.program.programID, uniforms)]
        self.uniforms:init(self.program:rawget())
        var ident = glm.mat4.create()
        var cam = glm.mat4.orthographic(-400, 400, -300, 300, -100, 100) * glm.mat4.scale(100, 100, 1)
        gl.UniformMatrix4fv(self.uniforms.camera, 1, gl.TRUE, cam:get(0,0))
        gl.UniformMatrix4fv(self.uniforms.objTransform, 1, gl.TRUE, ident:get(0,0))
        gl.Uniform3f(self.uniforms.color, glm.vec3.create(0,0,0):unpack())
end


local function dumptable(tbl) for k,v in pairs(tbl) do print(k,v) end end
local membertype = function(typ, field)
        for _,v in ipairs(typ:getentries()) do
                if v.field == field then
                        return v.type
                end
        end
        error("Type "..tostring(typ).." has no member "..field)
end

terra Renderer:createBufferFromGeometry(geo: &Geometry)
        var verts = gl.CreateBuffer()
        gl.NamedBufferData(verts, geo.verts:size() * [sizeof(membertype(Geometry,"verts").T)],
                                geo.verts:get(0), gl.STATIC_DRAW)
        var indices = gl.CreateBuffer()
        gl.NamedBufferData(indices, geo.indices:size() * sizeof([membertype(Geometry,"indices").T]),
                                geo.indices:get(0), gl.STATIC_DRAW)
        return Buffer { vertexBuffer=verts; indexBuffer=indices; numIndices = geo.indices:size() }
end

terra Renderer:renderMesh(mesh: &Mesh)
        var buff = self.buffers:get(mesh.geometry.uuid)
        if buff == nil then
                buff = self.buffers:insert(mesh.geometry.uuid, self:createBufferFromGeometry(mesh.geometry))
        end

        self.vao:use()
        self.program:use()
        gl.VertexArrayVertexBuffer(self.vao:rawget(), 0, buff.vertexBuffer, 0, sizeof(Vertex))
        gl.VertexArrayElementBuffer(self.vao:rawget(), buff.indexBuffer)

        gl.Uniform3f(self.uniforms.color, mesh.material:getColor():unpack())
        var objTransform = mesh:getTransform()
        gl.UniformMatrix4fv(self.uniforms.objTransform, 1, gl.TRUE, objTransform:get(0,0))
        gl.DrawElements(gl.TRIANGLES, buff.numIndices, gl.UNSIGNED_INT, nil)

        gl.DumpErrors()
end

terra Renderer:render(scene: &Scene, cameraTransform: glm.mat4)
        if not self.window:isAlive() then return end
        self.window:makeCurrent()

        gl.ClearColor(scene.backgroundColor:unpack())
        gl.Clear(gl.COLOR_BUFFER_BIT or gl.DEPTH_BUFFER_BIT)

        gl.UniformMatrix4fv(self.uniforms.camera, 1, gl.TRUE, cameraTransform:get(0,0))

        var obj = scene.objects:start()
        while obj ~= scene.objects:stop() do
                self:renderMesh(@obj:get())
                obj:inc()
        end

        self.window:swapBuffers()
end

return Renderer
