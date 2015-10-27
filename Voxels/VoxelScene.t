import "lang/template"
local std = require "util/std"
local math = require "util/math"
local glm = require "util/glm"


local struct PreVoxelOctreeNode {
        childIdxs: uint[8]
        validMask: uint8
        leafMask: uint8
        subtreeSize: uint
}
terra PreVoxelOctreeNode.methods.create()
        var self = PreVoxelOctreeNode {validMask=0, leafMask=0}
        for i=0,8 do self.childIdxs[i] = 0 end
        self.subtreeSize = 0
        return self
end

local struct PreVoxelOctree(std.Object) {
        nodePool: std.Vector(PreVoxelOctreeNode)
}

terra PreVoxelOctree.methods.create()
        var self: PreVoxelOctree
        self.nodePool:init()
        return self
end

-- ugly hack to enable recursion with templated methods
PreVoxelOctree.methods.addSubtree = template<typename MVoxIter> (function()
local terra addSubtree(self: &PreVoxelOctree, size: uint, vox: &MVoxIter): bool
        -- if we're at the base level, only return a single voxel - a leaf or nothing.
        if size == 0 then return vox:next() end
        -- the node we plan to add.
        var nodeIdx = self.nodePool:size()
        self.nodePool:insert(PreVoxelOctreeNode.create())
        -- the current index, which our children will be pushed to.
        var curIdx = self.nodePool:size()
        for i=0,8 do
                self.nodePool:get(nodeIdx).childIdxs[i] = curIdx
                var isLeaf = addSubtree(self, size-1, vox)
                -- convenience
                var curNode = self.nodePool:get(nodeIdx)
                -- if the tree size changed, that means we pushed a node.
                if self.nodePool:size() ~= curIdx then
                        curIdx = self.nodePool:size()
                        curNode.validMask = curNode.validMask or 1 << i
                elseif isLeaf then
                        curNode.validMask = curNode.validMask or 1 << i
                        curNode.leafMask = curNode.leafMask or 1 << i
                end
        end
        self.nodePool:get(nodeIdx).subtreeSize = self.nodePool:size() - nodeIdx - 1
        if self.nodePool:get(nodeIdx).leafMask == 0xFF then
                if nodeIdx ~= 0 then self.nodePool:remove() end
                return true
        elseif self.nodePool:get(nodeIdx).validMask == 0 then
                if nodeIdx ~= 0 then self.nodePool:remove() end
        end
        return false
end return addSubtree end)()

terra PreVoxelOctree:print()
        for i=0,self.nodePool:size() do
                var node = self.nodePool:get(i)
                std.print(node.validMask, node.leafMask, node.subtreeSize)
                for j=0,8 do
                        if ((node.validMask ^ node.leafMask) and 1 << j) ~= 0 then
                                std.printC(j, ": ", node.childIdxs[j], "\n")
                        end
                end
        end
end

local struct VoxelNode {
        _childPtr: uint16
        validMask: uint8
        leafMask: uint8
}

terra VoxelNode:setChildPtr(offset: uint16, far: bool)
        self._childPtr = offset << 1
        if far then self._childPtr = self._childPtr or 1 end
end

terra VoxelNode:getChildPtr()
        return self._childPtr >> 1
end

terra printBinary(x: uint8)
        for i=0,8 do
                if (x and (1 << (8-i-1))) ~= 0 then
                        std.printC("1")
                else
                        std.printC("0")
                end
        end
end

terra VoxelNode:print()
        printBinary(self.validMask) std.printC("\t") printBinary(self.leafMask) std.printC("\t", self._childPtr >> 1,"\n")
end

local struct VoxelLeaf {
        rgb: glm.vector(uint8, 4)
}

local struct NodeOrFarptr {
        union {
                node: VoxelNode
                farptr: uint32
        }
}

local struct VoxelOctree(std.Object) {
        nodes: std.Vector(NodeOrFarptr)
}



terra deinterleave(x: uint)
        x = x or (x >> 2)
        x = x and 0xc30c30c3
        x = x or (x >> 4)
        x = x and 0x0f00f00f
        x = x or (x >> 8)
        x = x and 0xFF0000FF
        x = x or (x >> 16)
        x = x and 0x0000FFFF
        return x
end

terra mortonDecode(m: uint)
        var mask = 0x49249249
        var x = deinterleave(m and mask)
        var y = deinterleave((m >> 1) and mask)
        var z = deinterleave((m >> 2) and mask)
        return x, y, z
end

terra deinterleave(x: uint64)
        x = (x or  (x >> 2)) and 0x30c30c30c30c30c3L
        x = (x or  (x >> 4)) and 0xf00f00f00f00f00fL
        x = (x or  (x >> 8)) and 0x00ff0000ff0000ffL
        x = (x or (x >> 16)) and 0xffff00000000ffffL
        x = (x or (x >> 32)) and 0x00000000ffffffffL
end

terra mortonDecode(m: uint64)
        var mask = 0x9249249249249249L
        var x = deinterleave((m >> 0) and mask)
        var y = deinterleave((m >> 1) and mask)
        var z = deinterleave((m >> 2) and mask)
        return x, y, z
end

terra interleave2(x: uint)
        x = (x or x << 8) and 0x00FF00FF
        x = (x or x << 4) and 0x0F0F0F0F
        x = (x or x << 2) and 0x33333333
        x = (x or x << 1) and 0x55555555
        return x
end

terra mortonEncode2(x: uint, y: uint)
        return interleave2(x) or (interleave2(y) << 1)
end

local struct SimpleMVoxIter(std.Object) {
        idx: uint
        offset: uint
        cachedHeight: std.Vector(uint)
}

terra SimpleMVoxIter.methods.create()
        var self = SimpleMVoxIter {idx=0, offset=0}
        self.cachedHeight:init()
        return self
end

local Perlin = require "util/Perlin"
terra SimpleMVoxIter:next()
        var oldIdx = self.idx
        self.idx = self.idx + 1
        var x, y, z = mortonDecode(oldIdx)
        x = x + self.offset
        var cacheIdx = mortonEncode2(x, y)
        var height: uint
        if z == 0 then
                height = uint((Perlin.perlin2d(float(x)/512, float(y)/512) + 2)*256)
                if self.cachedHeight:size() <= cacheIdx then self.cachedHeight:resize(cacheIdx + 1) end
                @self.cachedHeight:get(cacheIdx) = height
        else
                height = @self.cachedHeight:get(cacheIdx)
        end
        if z == 0 then return true
        elseif z < height then
                do return true end
                var density = Perlin.perlin3d(float(x)/32, float(y)/32, float(z)/32)
                if density > -0.5 then return true end
        end
        return false
end

terra VoxelOctree.methods.create(offset: uint)
        var self: VoxelOctree
        self.nodes:init()
        var preOct = PreVoxelOctree.salloc()
        var iter = SimpleMVoxIter.salloc()
        iter.offset = offset
        PreVoxelOctree.addSubtree(SimpleMVoxIter)(preOct, 10, iter)
        -- preOct:print()
        var fst = preOct.nodePool:get(0)
        self.nodes:insert(NodeOrFarptr{node=VoxelNode{validMask=fst.validMask, leafMask=fst.leafMask}})
        self.nodes:get(0).node:setChildPtr(1, false)
        self:addSubtree(preOct, 0, 0)
        return self
end

terra VoxelOctree:print()
        for i=0,self.nodes:size() do
                -- std.print(self.nodes:get(i).node.validMask, self.nodes:get(i).node.leafMask, self.nodes:get(i).node._childPtr >> 1)
                var node = &self.nodes:get(i).node
                node:print()
        end
end

terra popCount(x: uint8)
        x = x - (x >> 1 and 0x55)
        x = (x and 0x33) + (x >> 2 and 0x33)
        return x + (x >> 4) and 0x0f
end

terra VoxelOctree:addSubtree(preOct: &PreVoxelOctree, currPreIdx: uint, currNodeIdx: uint): {}
        var startPos = self.nodes:size() -- The index of the first child
        var offset = startPos - currNodeIdx;
        -- if offset ~= (offset and 0x7fff) then
        --         std.print("Too far - skipping nodes.")
        --         std.print("Distance:",offset,"Max:", 0x7fff)
        --         var node = &self.nodes:get(currNodeIdx).node
        --         -- std.printC("Current IDX:","\t",currNodeIdx,"\tPointer:")
        --         std.print("Current node:",currNodeIdx,"Its childIdx:",self:getChildIdx(currNodeIdx),"Us:",startPos)
        --         node.leafMask = node.validMask
        --         return
        -- end

        var currPreNode = preOct.nodePool:get(currPreIdx)
        var validNonLeaves = currPreNode.validMask ^ currPreNode.leafMask
        for i=0,8 do
                if (validNonLeaves and 1 << i) ~= 0 then
                        var currPreChild = preOct.nodePool:get(currPreNode.childIdxs[i])
                        var node = NodeOrFarptr{node=VoxelNode{
                                validMask=currPreChild.validMask, leafMask=currPreChild.leafMask
                        }}
                        self.nodes:insert(&node)
                end
        end
        var sum: uint = 0
        var farPtrs = arrayof(uint,0,0,0,0,0,0,0,0)
        for i=0,8 do if (validNonLeaves and 1 << i) ~= 0 then
                var numPrevChildren = popCount(validNonLeaves and (not uint8(0)) >> (8-i))
                var childIdx = startPos + numPrevChildren
                var offset = sum + self.nodes:size() - childIdx
                if offset > 0x7fff then
                        farPtrs[i] = self.nodes:size()
                        -- self.nodes:get(childIdx).node:setChildPtr(self.nodes:size(), true)
                        self.nodes:insert(NodeOrFarptr{farptr=0})
                        goto continue
                end
                -- self.nodes:get(childIdx).node:setChildPtr(sum + self.nodes:size() - childIdx, false)
                sum = sum + preOct.nodePool:get(currPreNode.childIdxs[i]).subtreeSize
                ::continue::
        end end
        for i=0,8 do
                if (validNonLeaves and 1 << i) ~= 0 then
                        var numPrevChildren = popCount(validNonLeaves and (not uint8(0)) >> (8-i))
                        var childIdx = startPos + numPrevChildren

                        if farPtrs[i] == 0 then
                                self.nodes:get(childIdx).node:setChildPtr(self.nodes:size() - childIdx, false)
                        else
                                self.nodes:get(childIdx).node:setChildPtr(farPtrs[i] - childIdx, true)
                                self.nodes:get(farPtrs[i]).farptr = self.nodes:size() - farPtrs[i]
                        end
                        self:addSubtree(preOct, currPreNode.childIdxs[i], childIdx)
                end
        end
end

terra VoxelOctree:getChildIdx(curNodeIdx: uint)
        var childPtr = self.nodes:get(curNodeIdx).node._childPtr
        var offset = childPtr >> 1
        if (childPtr and 1) ~= 0 then
                var farptrIdx = offset + curNodeIdx
                return farptrIdx + self.nodes:get(farptrIdx).farptr
        else
                return offset + curNodeIdx
        end
end

terra VoxelOctree:getVoxel(x: uint, y: uint, z: uint)
        var curNodeIdx: uint = 0
        var curBit: uint = 0

        repeat
                var curMask = 1 << (31 - curBit)
                var curSelect: uint8 =  (x and curMask) >> (31-curBit) or
                                        (y and curMask) >> (31-curBit-1) or
                                        (z and curMask) >> (31-curBit-2)
                var curVoxMask = 1 << curSelect
                var curNode = &self.nodes:get(curNodeIdx).node
                if (curNode.leafMask and curVoxMask) ~= 0 then
                        return true
                elseif (curNode.validMask and curVoxMask) ~= 0 then
                        var numPrevChildren = popCount((curNode.validMask^curNode.leafMask) and (not uint8(0)) << (8-curSelect))
                        curNodeIdx = self:getChildIdx(curNodeIdx) + numPrevChildren
                else
                        return false
                end
                curBit = curBit + 1
        until curBit >= 32
        std.printf("something FUCKED UP\n")
end

local struct VoxelScene(std.Object) {
        uuid: math.UUID
        octree: VoxelOctree
}

terra VoxelScene.methods.create(offset: uint)
        var self = VoxelScene {
                uuid = math.generateUUID();
        }
        self.octree = VoxelOctree.create(offset)
        return self
end


local function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local VoxelShaderFrag = readAll("Voxels/VoxelShaderFrag.glsl")
local VoxelShaderVert = readAll("Voxels/VoxelShaderVert.glsl")


local Window = require "Window"
local Buffer = require "Buffer"
local Program = require "Program"
local Shader = require "Shader"
local VertexArray = require "VertexArray"
local Geometry = require "Geometry"
local struct VoxelRenderer(std.Object) {
        window: &Window
        octreeBuffer: Buffer
        octreeTexture: GL.uint
        quadBuffer: Buffer
        quadIdxBuffer: Buffer
        program: Program
        vao: VertexArray
}
local Vertex = require "Vertex"
terra VoxelRenderer.methods.create(window: &Window)
        var self = VoxelRenderer {
                window = window;
                octreeBuffer = Buffer.create();
                octreeTexture = gl.CreateTexture(gl.TEXTURE_BUFFER);
                quadBuffer = Buffer.create();
                quadIdxBuffer = Buffer.create();
                program = Program.create();
                vao = VertexArray.create();
        }
        gl.Enable(gl.BLEND)
        gl.BlendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA)
        var vert = Shader.fromString(gl.VERTEX_SHADER, VoxelShaderVert)
        var frag = Shader.fromString(gl.FRAGMENT_SHADER, VoxelShaderFrag)
        self.program:addShader(vert)
        self.program:addShader(frag)
        self.program:link()
        self.program:use()

        self.vao:formatVertexAttribs(Vertex, self.program:rawget())
        var quadGeometry = std.salloc(Geometry.squareGeom())
        quadGeometry:transform(glm.mat4.translate(-1,-1,0) * glm.mat4.scale(2, 2, 2))
        self.quadBuffer:assign(quadGeometry.verts:actualSize(), quadGeometry.verts:get(0), gl.STATIC_DRAW)
        self.quadIdxBuffer:assign(quadGeometry.indices:actualSize(), quadGeometry.indices:get(0), gl.STATIC_DRAW)
        gl.VertexArrayVertexBuffer(self.vao:rawget(), 0, self.quadBuffer.id, 0, sizeof(Vertex))
        gl.VertexArrayElementBuffer(self.vao:rawget(), self.quadIdxBuffer.id)

        return self
end

terra VoxelRenderer:loadOctree(octree: &VoxelOctree)
        self.octreeBuffer:assign(octree.nodes:actualSize(), octree.nodes:get(0), gl.STATIC_DRAW)
        gl.TextureBuffer(self.octreeTexture, gl.R32UI, self.octreeBuffer.id)
        var nodePool = self.program:getUniformLoc("nodePool")
        gl.Uniform1i(nodePool, 0)
        gl.BindTextureUnit(0, self.octreeTexture)
end

terra VoxelRenderer:render(cameraTransform: glm.mat4)
        self.window:makeCurrent()
        gl.ClearColor(1, 1, 1, 1)
        gl.Clear(gl.COLOR_BUFFER_BIT)
        self.vao:use()
        var camera = self.program:getUniformLoc("camera")
        gl.UniformMatrix4fv(camera, 1, gl.TRUE, cameraTransform:get(0,0))

        gl.DrawElements(gl.TRIANGLES, 6, gl.UNSIGNED_INT, nil)

        self.window:swapBuffers()
end


local Camera = require "Camera"
local M = terralib.includec("math.h")
terra simpleCameraMotion(camera: &Camera, window: &Window)
        var speed: float = M.exp2f(-8.0f)
        var movement = glm.vec3.create(0,0,0)
        if window:getKey(glfw.KEY_W) then
                movement = movement + glm.vec3.create(0, 1, 0)
        end
        if window:getKey(glfw.KEY_A) then
                movement = movement + glm.vec3.create(-1, 0, 0)
        end
        if window:getKey(glfw.KEY_S) then
                movement = movement + glm.vec3.create(0, -1, 0)
        end
        if window:getKey(glfw.KEY_D) then
                movement = movement + glm.vec3.create(1, 0, 0)
        end
        movement = movement * speed
        camera:move(movement)

        var rotspeed: float = M.M_PI/64.0
        if window:getKey(glfw.KEY_UP) then
                camera.rotation = camera.rotation + glm.vec2.create(0, 1) * rotspeed
        end
        if window:getKey(glfw.KEY_DOWN) then
                camera.rotation = camera.rotation + glm.vec2.create(0, -1) * rotspeed
        end
        if window:getKey(glfw.KEY_LEFT) then
                camera.rotation = camera.rotation + glm.vec2.create(-1, 0) * rotspeed
        end
        if window:getKey(glfw.KEY_RIGHT) then
                camera.rotation = camera.rotation + glm.vec2.create(1, 0) * rotspeed
        end
end

local shift = terralib.global(uint)

terra key_callback(window: &glfw.window, key: int, scancode: int, action: int, mods: int)
        if key == glfw.KEY_F and action == glfw.PRESS then
                shift = shift + 1
        end
end

local Timer = require "util/Timer"
terra test()
        glfw.Init() defer glfw.Terminate()
        var offset = 0
        shift = 0
        var oct = VoxelScene.salloc(0)
        var window = Window.salloc(1024,768,"Voxels")
        var renderer = VoxelRenderer.salloc(window)
        renderer:loadOctree(&oct.octree)

        var camera = Camera.create()
        -- glfw.SetKeyCallback(window._window, key_callback)
        while not window:shouldClose() do
                var timer = Timer.create()
                Window.pollEvents()
                if window:getKey(glfw.KEY_F) then
                        shift = shift + 64
                end
                if shift ~= 0 then
                        offset = offset + shift
                        shift = 0
                        oct:destruct()
                        @oct = VoxelScene.create(offset)
                        renderer:loadOctree(&oct.octree)
                end
                simpleCameraMotion(&camera, window)
                renderer:render(glm.mat4.translate(camera.position:unpack()) *
                        glm.mat4.rotatez(-camera.rotation.x) *
                        glm.mat4.rotatex(camera.rotation.y))
                timer:round(16)
        end

        -- oct:print()
        -- std.print(asdf)
end

test()
