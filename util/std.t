local C = terralib.includecstring [[
#include <stdio.h>
#include <stdlib.h>
]]

local std = {}

for k,v in pairs(C) do std[k] = v end

local terra printSingle(x: rawstring)
        std.printf("%s", x)
end
terra printSingle(x: float)
        std.printf("%f", x)
end
terra printSingle(x: int)
        std.printf("%i", x)
end
terra printSingle(x: uint)
        std.printf("%u", x)
end
terra printSingle(x: uint16)
        std.printf("%u", x)
end
terra printSingle(x: uint8)
        std.printf("%u", x)
end
terra printSingle(x: bool)
        if x then
                std.printf("True")
        else
                std.printf("False")
        end
end
terra printSingle(x: &opaque)
        std.printf("0x%016llx", x)
end

std.printC = macro(function(first, ...)
        local ret = terralib.newlist()
        ret:insert(quote printSingle(first) end)
        local args = terralib.newlist {...}
        if #args > 0 then ret:insert(quote std.printC(args) end) end
        return ret
end)
std.print = macro(function(...)
        local args = terralib.newlist {...}
        local ret = args:map(function(arg)
                return quote
                        printSingle(arg)
                        printSingle("\t")
                end
        end)
        ret:insert(quote printSingle("\n") end)
        return ret
end)

std.hasDestructor = function(T)
        if T:isstruct() then return T:getmethod("destruct")
        elseif T:isarray() then return std.hasDestructor(T.type)
        else return false end
end

std.runDestructor = macro(function(obj)
        local T = obj:gettype()
        if not std.hasDestructor(T) then return terralib.newlist() end
        if T:isarray() then
                return quote
                        for i=0,[T.N] do
                                std.runDestructor(obj[i])
                        end
                end
        else
                local stmts = terralib.newlist()
                for _,entry in ipairs(T:getentries()) do
                        stmts:insert(quote std.runDestructor(obj.[entry.field]) end)
                end
                if T:getmethod("__destruct") then stmts:insert(quote obj:__destruct() end) end
                return stmts
        end
end)
std.rundestructor = std.runDestructor

std.salloc = macro(function(myobj)
        return quote
                var obj = myobj
                defer obj:destruct()
        in
                &obj
        end
end)

std.Object = function(T)
        terra T.methods.alloc()
                return [&T](C.malloc(sizeof(T)))
        end
        T.methods.new = macro(function(...)
                local args = terralib.newlist {...}
                return quote
                        var obj = T.alloc()
                        @obj = T.create(args)
                in
                        obj
                end
        end)
        T.methods.salloc = macro(function(...)
                local args = terralib.newlist {...}
                return quote
                        var obj: T = T.create(args)
                        defer obj:destruct()
                in
                        &obj
                end
        end)
        terra T:destruct(): {}
                std.runDestructor(@self)
        end
        terra T:delete()
                self:destruct()
                C.free(self)
        end
end

function std.Vector(T)
        local struct Vector(std.Object) {
                data: &T
                size: uint
                allocated: uint
        }
        Vector.T = T

        Vector.metamethods.__typename = function(self)
                 return "std.vector<"..tostring(self.T)..">"
         end
        terra Vector.methods._create()
                var self: Vector
                self.data = nil
                self.size = 0
                self.allocated = 0
                return self
        end
        Vector.methods.create = macro(function(...)
                if ... then
                        local args = terralib.newlist {...}
                        return quote
                                var self = Vector._create()
                                self:assign(args)
                        in
                                self
                        end
                else
                        return `Vector._create()
                end
        end)
        terra Vector:init() @self = Vector.create() end
        terra Vector:__destruct()
                std.free(self.data)
        end
        terra Vector:get(i: uint)
                return &self.data[i]
        end
        terra Vector:size()
                return self.size
        end
        terra Vector:actualSize()
                return self.size * sizeof(T)
        end
        terra Vector:reserve(n: uint)
                if n > self.allocated then
                        var newSize = 2
                        while newSize < n do newSize = newSize * 2 end
                        if self.data ~= nil then
                                self.data = [&T](C.realloc(self.data, newSize * sizeof(T)))
                        else
                                self.data = [&T](C.malloc(newSize * sizeof(T)))
                        end
                        self.allocated = newSize
                end
        end
        terra Vector:resize(n: uint): {}
                if n < self:size() then
                        for i=n,self:size() do
                                std.runDestructor(self:get(i))
                        end
                else
                        self:reserve(n)
                end
                self.size = n
        end
        terra Vector:resize(n: uint, val: &T): {}
                var oldSize = self:size()
                self:resize(n)
                if oldSize < self:size() then
                        for i=oldSize,self:size() do
                                @self:get(i) = @val
                        end
                end
        end
        terra Vector:insert(val: &T): {}
                var i = self:size()
                self:resize(i+1)
                @self:get(i) = @val
        end
        terra Vector:insert(val: T): {}
                return self:insert(&val)
        end
        terra Vector:remove()
                self:resize(self:size() - 1)
        end
        terra Vector:_assign(n: uint, vals: &T)
                self:resize(n)
                for i=0,n do
                        @self:get(i) = vals[i]
                end
        end
        terra Vector:_append(n: uint, vals: &T)
                var sz = self:size()
                self:resize(n+sz)
                for i=0,n do
                        @self:get(sz + n) = vals[i]
                end
        end
        Vector.methods.assign = macro(function(self, n, vals)
                if not vals then
                        vals = n
                        n = vals:gettype().N
                end
                return `self:_assign(n, vals)
        end)
        Vector.methods.append = macro(function(self, n, vals)
                if not vals then
                        vals = n
                        n = vals:gettype().N
                end
                return `self:_append(n, vals)
        end)

        Vector.iterator = struct {
                loc: &T
        }
        terra Vector.iterator:inc()
                self.loc = self.loc + 1
        end
        terra Vector.iterator.metamethods.__eq(self: Vector.iterator, rhs: Vector.iterator)
                return self.loc == rhs.loc
        end
        terra Vector.iterator.metamethods.__ne(self: Vector.iterator, rhs: Vector.iterator)
                return not (self == rhs)
        end
        terra Vector.iterator:get()
                return self.loc
        end

        terra Vector:start(): Vector.iterator
                return [Vector.iterator] {loc=&self.data[0]}
        end
        terra Vector:stop(): Vector.iterator
                return [Vector.iterator] {loc=&self.data[self:size()]}
        end
        return Vector
end
std.Vector = terralib.memoize(std.Vector)

return std
