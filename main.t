local std = require "util/std"
require "lib/gl"
local glm = require "util/glm"
local Timer = require "util/Timer"
local Window = require "Window"
local Renderer = require "Renderer"
local Scene = require "Scene"
local Geometry = require "Geometry"
local Mesh = require "Mesh"
local Material = require "Material"
local Vertex = require "Vertex"
local Camera = require "Camera"


function trace(...) print(...) return quote end end

local M = terralib.includec("math.h")

terra simpleCameraMotion(camera: &Camera, window: &Window)
        var speed: float = 0.125
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

        var rotspeed: float = M.M_PI/32.0
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

terra main()
        glfw.Init()
        var scene = Scene.salloc()
        scene:setBackgroundColor(glm.vec3.create(0.2, 0.6, 0.4))

        var geo = std.salloc(Geometry.cubeGeom())

        var mat = Material.salloc()
        mat:setColor(glm.vec3.create(0.4, 0.3, 0.7))

        var geo2 = Geometry.salloc()
        geo2.verts:assign(array(Vertex {glm.vec3.create(0.0, 0.0, 0.0)},
                                Vertex {glm.vec3.create(1.0, 0.0, 0.0)},
                                Vertex {glm.vec3.create(1.0, 0.0, 1.0)},
                                Vertex {glm.vec3.create(0.0, 0.0, 1.0)},
                                Vertex {glm.vec3.create(0.5, 0.0, 1.25)}))
        geo2.indices:assign(arrayof(uint, 0, 1, 3, 1, 2, 3, 3, 4, 2))

        geo2:transform(glm.mat3.rotatez(M.M_PI/8))

        var mat2 = Material.salloc()
        mat2:setColor(glm.vec3.create(0.7, 0.3, 0.4))

        var mesh1 = Mesh.salloc(geo, mat)
        scene:addObject(mesh1)
        var mesh2 = Mesh.salloc(geo2, mat2)
        scene:addObject(mesh2)
        mesh2.position = glm.vec3.create(0, -0.8, 0)

        var window = Window.salloc()
        var renderer = Renderer.salloc(window)
        var window2 = Window.salloc()
        var renderer2 = Renderer.salloc(window2)
        var camera = Camera { glm.vec3.create(0.0, 0.0, 0.0), glm.vec2.create(0.0, 0.0) }
        while not window:shouldClose() and not window2:shouldClose() do
                var timer = Timer.create()
                Window.pollEvents()

                simpleCameraMotion(&camera, window)

                scene:setBackgroundColor(glm.vec3.create(0.2, 0.6, 0.4))
                renderer:render(scene, camera:getTransform())
                scene:setBackgroundColor(glm.vec3.create(0.2, 0.4, 0.6))
                renderer2:render(scene, camera:getTransform())

                mesh2.position = mesh2.position + glm.vec3.create(-0.01, 0, 0)
                timer:round(16)
        end
end

main()
