local std = require "util/std"
require "lib/gl"

local struct Window(std.Object) {
        _window: &glfw.window
}

terra Window.methods.init()
        var self: Window
        self._window = nil
        return self
end

terra Window.methods.create(width: uint, height: uint, name: rawstring): Window
        var self = Window.init()
        self._window = glfw.CreateWindow(width, height, name, nil, nil)
        if self:isAlive() then
                self:makeCurrent()
                glew.Init()
                glfw.SwapInterval(0)
        end
        return self
end

terra Window.methods.create(): Window
        return Window.create(800, 600, "Untitled window")
end

terra Window:__destruct()
        glfw.DestroyWindow(self._window)
end

terra Window:isAlive()
        return self._window ~= nil
end

terra Window:shouldClose()
        if not self:isAlive() then return true end
        return glfw.WindowShouldClose(self._window) ~= 0
end

terra Window.methods.pollEvents()
        glfw.PollEvents()
end

terra Window:makeCurrent()
        glfw.MakeContextCurrent(self._window)
end

terra Window:swapBuffers()
        glfw.SwapBuffers(self._window)
end

terra Window:getKey(key: int)
        return glfw.GetKey(self._window, key) == glfw.PRESS
end

return Window
