local glm = {}

-- local std = terralib.includec("stdio.h")

local function dumptable(tbl) for k,v in pairs(tbl) do print(k,v) end end

local function repeatN(x, N)
        local function repeatN(x, N, ...)
                if N == 0 then return ...
                else return repeatN(x, N-1, x, ...) end
        end
        return repeatN(x, N)
end

function glm.vector(T, N)
        if N == 1 then return T end

        local struct Vector {
                union {
                        -- _data: vector(T, N);
                        _array: T[N]
                }
        }

        Vector.T, Vector.N = T, N

        Vector.metamethods.__typename = function(self) return "glm.vector<"..tostring(self.T)..", "..tostring(self.N)..">" end

        terra Vector:get(i: uint)
                return &self._array[i]
        end

        Vector.metamethods.__cast = function(from, to, exp)
                if from:isvector() then return `Vector._create([vector(T,N)]([exp]))
                elseif from:isarray() then return `Vector._create([exp])
                elseif to:isvector() then return `to([exp]._data)
                else error("Cast failed.") end
        end

        local dimtbl = {["x"]=0, ["y"]=1, ["z"]=2, ["w"]=3}
        local coltbl = {["r"]=0, ["g"]=1, ["b"]=2, ["a"]=3}
        Vector.metamethods.__entrymissing = macro(function(entryname, obj)
                local tbl = nil
                if dimtbl[entryname:sub(1,1)] then tbl = dimtbl
                elseif coltbl[entryname:sub(1,1)] then tbl = coltbl
                else error("Invalid swizzle: "..entryname)
                end

                local exprs = terralib.newlist()
                for i=1,#entryname do
                        local v = entryname:sub(i,i)
                        exprs:insert(`obj._array[ [tbl[v]]])
                end

                if #exprs == 1 then return `[exprs[1]] end
                return `[glm.vector(obj:gettype().T, #exprs)].create(exprs)
        end)

        terra Vector:_getVector()
                return vector(self:unpack())
        end

        local operators = {"__add", "__sub", "__mul", "__div"}
        for _,op in ipairs(operators) do
                Vector.metamethods[op] = macro(function(lhs, rhs)
                        -- if lhs:gettype() == Vector then lhs = `lhs._data end
                        -- if rhs:gettype() == Vector then rhs = `rhs._data end
                        if lhs:gettype() == Vector then lhs = `lhs:_getVector() end
                        if rhs:gettype() == Vector then rhs = `rhs:_getVector() end
                        return `Vector._create(operator([op], lhs, rhs))
                end)
        end

        terra glm.dot(lhs: Vector, rhs: Vector)
                var product = lhs * rhs
                var total: T = 0
                for i=0,N do total = total + product._array[i] end
                return total
        end


        -- terra Vector.methods._create(vec: vector(T,N)): Vector
        --         var self: Vector
        --         self._data = vec
        --         return self
        -- end

        terra Vector.methods._create(vec: vector(T,N)): Vector
                var self: Vector
                for i=0,N do self._array[i] = vec[i] end
                return self
        end

        terra Vector.methods._create(vec: T[N]): Vector
                var self: Vector
                self._array = vec
                return self
        end

        local function genConstructor(nums)
                nums = terralib.newlist(nums)
                local types = nums:map(function(n) return n == N and Vector or glm.vector(T, n) end)
                local syms = types:map(symbol)

                local exprs = terralib.newlist()
                for i,s in pairs(syms) do
                        if nums[i] == 1 then exprs:insert(`s)
                        else
                                for j=0,nums[i]-1 do
                                        exprs:insert(`s._array[j])
                                end
                        end
                end

                terra Vector.methods.create([syms]): Vector return Vector._create(arrayof(T, exprs)) end
        end

        local function sum(a, b, ...)
                if not a then return 0 end
                if not b then return a end
                return sum(a+b, ...)
        end
        local function genStartingWith(...)
                local total = sum(...)
                if total == N then genConstructor({...})
                elseif total > N then return
                else for i=1,N do genStartingWith(i, ...) end
                end
        end

        for i=1,N do genStartingWith(i) end


        -- Vector.methods.unpack = macro(function(self)
        --         local _self = symbol(Vector)
        --         local exprs = terralib.newlist()
        --         for i=0,N-1 do exprs:insert(`[_self]._data[i]) end
        --         dumptable(exprs)
        --         return quote var [_self] = self in exprs end
        -- end)

        Vector.methods.unpack = macro(function(self)
                local exprs = terralib.newlist()
                for i=0,N-1 do exprs:insert(`self._array[i]) end
                return `exprs
        end)

        return Vector
end
glm.vector = terralib.memoize(glm.vector)

for i=2,4 do
        glm["vec"..tostring(i)] = glm.vector(float, i)
        glm["dvec"..tostring(i)] = glm.vector(double, i)
        glm["ivec"..tostring(i)] = glm.vector(int, i)
        glm["uvec"..tostring(i)] = glm.vector(uint, i)
end



local function matrixMul(T, W, H, W2) return terra(lhs: glm.matrix(T, W, H), rhs: glm.matrix(T,W2,W))
        var result: glm.matrix(T, W2, H)
        for j=0,H do for i=0,W2 do
                @result:get(i, j) = glm.dot(lhs:get(j), rhs:getColumn(i))
        end end
        return result
end end
matrixMul = terralib.memoize(matrixMul)

local isMatrix = {}
function glm.matrix(T,W,H)
        local len = W*H
        local struct Matrix {
                _data: T[len];
        }
        -- print(T, W, H, sizeof(Matrix), sizeof(vector(T, W*H)), sizeof(T[W*H]), sizeof(glm.vector(T,H)[W]))
        Matrix.T, Matrix.W, Matrix.H = T, W, H
        isMatrix[Matrix] = true

        function Matrix.metamethods.__typename(self) return "glm.matrix<"..tostring(self.T)..", "..tostring(self.W)..", "..tostring(self.H)..">" end

        terra Matrix.methods.create(): Matrix
                var self: Matrix
                for j=0,H do for i=0,W do
                        if i == j then
                                @self:get(i,j) = 1
                        else
                                @self:get(i,j) = 0
                        end
                end end
                return self
        end

        terra Matrix.methods.create(vec: T[W*H]): Matrix
                var self: Matrix
                self._data = vec
                return self
        end

        local syms = terralib.newlist()
        for i=1,W*H do syms:insert(symbol(T)) end
        terra Matrix.methods.create([syms]): Matrix
                return Matrix.create(arrayof(T,[syms]))
        end

        terra Matrix:get(i: uint, j: uint): &T
                return &self._data[i+j*H]
        end

        terra Matrix:get(j: uint): glm.vector(T,W)
                var result: glm.vector(T, W)
                for i=0,W do
                        @result:get(i) = @self:get(i, j)
                end
                return result
        end

        terra Matrix:getColumn(i: uint)
                var result: glm.vector(T, H)
                for j=0,H do
                        @result:get(j) = @self:get(i, j)
                end
                return result
        end

        terra Matrix:_add(rhs: Matrix)
                var ret: Matrix
                for j=0,H do for i=0,W do
                        @ret:get(i,j) = @self:get(i,j) + rhs:get(i,j)
                end end
                return ret
        end

        local operators = {"__add", "__sub"}
        for _,op in ipairs(operators) do
                Matrix.metamethods[op] = macro(function(lhs, rhs)
                        -- if lhs:gettype() == Matrix then lhs = `lhs._data end
                        -- if rhs:gettype() == Matrix then rhs = `rhs._data end
                        -- return `Matrix.create(operator([op], lhs, rhs))
                        return `lhs:_add(rhs)
                end)
        end

        terra Matrix:_mul(rhs: glm.vector(T, W))
                var result: glm.vector(T, H)
                for j=0,H do
                        @result:get(j) = glm.dot(self:get(j), rhs)
                end
                return result
        end

        Matrix.metamethods.__mul = macro(function(lhs, rhs)
                local lhsT = lhs:gettype()
                local rhsT = rhs:gettype()
                if lhsT == T then
                        return `Matrix._create(lhs * rhs._data)
                elseif rhsT == T then
                        return `Matrix._create(rhs * lhs._data)
                elseif isMatrix[lhsT] and isMatrix[rhsT] and lhsT.T == rhsT.T and rhsT.H == lhsT.W then
                        return `[matrixMul(T, lhsT.W, lhsT.H, rhsT.W)](lhs, rhs)
                elseif rhsT == glm.vector(T, lhsT.W) then
                        return `lhs:_mul(rhs)
                elseif lhsT.W == 4 and lhsT.H == 4 and rhsT == glm.vector(T, 3) then
                        return quote
                                var temp = lhs:_mul([glm.vector(T,4)].create(rhs, 1))
                        in
                                [glm.vector(T,3)].create(temp.x/temp.w, temp.y/temp.w, temp.z/temp.w)
                        end
                else
                        error("Could not multiply.")
                end
        end)

        return Matrix
end
glm.matrix = terralib.memoize(glm.matrix)

for i=2,4 do
        glm["mat"..tostring(i)] = glm.matrix(float, i, i)
        glm["dmat"..tostring(i)] = glm.matrix(double, i, i)
        glm["imat"..tostring(i)] = glm.matrix(int, i, i)
end

local math = terralib.includec("math.h")
local types = {
        [float]={cos=math.cosf, sin=math.sinf, tan=math.tanf};
        [double]={cos=math.cos, sin=math.sin, tan=math.tan};
}
for T,m in pairs(types) do
        glm.matrix(T,2,2).methods.rotate = terra(theta: T)
                return [glm.matrix(T,2,2)].create(
                        m.cos(theta), -m.sin(theta),
                        m.sin(theta), m.cos(theta)
                )
        end
        glm.matrix(T,3,3).methods.rotatex = terra(theta: T)
                return [glm.matrix(T,3,3)].create(
                        1,             0,             0,
                        0,  m.cos(theta), -m.sin(theta),
                        0,  m.sin(theta),  m.cos(theta)
                )
        end
        glm.matrix(T,3,3).methods.rotatey = terra(theta: T)
                return [glm.matrix(T,3,3)].create(
                        m.cos(theta),  0,  m.sin(theta),
                        0,             1,             0,
                        -m.sin(theta), 0,  m.cos(theta)
                )
        end
        glm.matrix(T,3,3).methods.rotatez = terra(theta: T)
                return [glm.matrix(T,3,3)].create(
                        m.cos(theta), -m.sin(theta),  0,
                        m.sin(theta),  m.cos(theta),  0,
                        0,             0,             1
                )
        end
        glm.matrix(T,4,4).methods.rotatex = terra(theta: T)
                return [glm.matrix(T,4,4)].create(
                        1,             0,             0,         0,
                        0,  m.cos(theta), -m.sin(theta),         0,
                        0,  m.sin(theta),  m.cos(theta),         0,
                        0,             0,             0,         1
                )
        end
        glm.matrix(T,4,4).methods.rotatey = terra(theta: T)
                return [glm.matrix(T,4,4)].create(
                        m.cos(theta),  0,  m.sin(theta),         0,
                        0,             1,             0,         0,
                        -m.sin(theta), 0,  m.cos(theta),         0,
                        0,             0,             0,         1
                )
        end
        glm.matrix(T,4,4).methods.rotatez = terra(theta: T)
                return [glm.matrix(T,4,4)].create(
                        m.cos(theta), -m.sin(theta),  0,         0,
                        m.sin(theta),  m.cos(theta),  0,         0,
                        0,             0,             1,         0,
                        0,             0,             0,         1
                )
        end
        glm.matrix(T, 4, 4).methods.translate = terra(x: T, y: T, z: T)
                return [glm.matrix(T,4,4)].create(
                        1, 0, 0, x,
                        0, 1, 0, y,
                        0, 0, 1, z,
                        0, 0, 0, 1
                )
        end
        glm.matrix(T, 4, 4).methods.scale = terra(x: T, y: T, z: T)
                return [glm.matrix(T,4,4)].create(
                        x, 0, 0, 0,
                        0, y, 0, 0,
                        0, 0, z, 0,
                        0, 0, 0, 1
                )
        end
        glm.matrix(T, 4, 4).methods.orthographic = terra(l: T, r: T, b: T, t: T, n: T, f: T)
                return [glm.matrix(T,4,4)].create(
                        2/(r-l),        0,             0, -(r+l)/(r-l),
                        0,        2/(t-b),             0, -(t+b)/(t-b),
                        0,              0,      -2/(f-n), -(f+n)/(f-n),
                        0,              0,             0,            1
                )
        end
        glm.matrix(T, 4, 4).methods.perspective = terra(fov: T, aspect: T, n: T, f: T)
                return [glm.matrix(T,4,4)].create(
                        1/m.tan(fov),   0,             0,            0,
                        0,        1/m.tan(fov)/aspect, 0,            0,
                        0,              0,  -(f+n)/(f-n), -2*f*n/(f-n),
                        0,              0,            -1,            0
                )
        end
end

-- terra test()
--         var a = glm.mat4.create() * glm.mat4.rotatez(math.M_PI*1) * glm.mat4.rotatey(math.M_PI*-0.25)
--         var b = glm.vec4.create(1,0,0,1)
--         var c = a * b
--         std.printf("%f %f %f %f\n", c.x, c.y, c.z, c.w)
-- end
-- test()

return glm
