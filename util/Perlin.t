
terra noise1d(x: uint)
        x = (x << 13) ^ x
        return (1.0f - ( (x * (x * 15731 + 789221) + 1376312589) and 0x7fffffff) / 1073741824.0f)
end

terra noise2d(x: uint, y: uint)
        return noise1d(x + y * 71)
end

terra noise3d(x: uint, y: uint, z: uint)
        return noise1d(x + y * 67 + z*101)
end

local M = terralib.includec("math.h")

terra cosinInterp(a: float, b: float, x: float)
        var f = (1-M.cosf(x * M.M_PI))/2
        return (b-a)*f + a
end
terra interpNoise2d(x: float, y: float)
        var ix = int(M.floorf(x))
        var iy = int(M.floorf(y))
        var fx = x - M.floorf(x)
        var fy = y - M.floorf(y)
        var v00 = noise2d(ix, iy)
        var v10 = noise2d(ix + 1, iy)
        var v01 = noise2d(ix, iy + 1)
        var v11 = noise2d(ix + 1, iy + 1)
        var u0 = cosinInterp(v00, v10, fx)
        var u1 = cosinInterp(v01, v11, fx)
        return cosinInterp(u0, u1, fy)
end
terra perlinNoise2d(x: float, y: float)
        var result = 0.0f
        for i=0,5 do
                result = result + interpNoise2d(x * M.exp2f(i), y * M.exp2f(i)) * M.exp2f(-i)
        end
        return result
end


terra interpNoise3d(x: float, y: float, z: float)
        var ix = int(M.floorf(x))
        var iy = int(M.floorf(y))
        var iz = int(M.floorf(z))
        var fx = x - M.floorf(x)
        var fy = y - M.floorf(y)
        var fz = z - M.floorf(z)
        var v000 = noise3d(ix, iy, iz)
        var v100 = noise3d(ix + 1, iy, iz)
        var v010 = noise3d(ix, iy + 1, iz)
        var v110 = noise3d(ix + 1, iy + 1, iz)
        var v001 = noise3d(ix, iy, iz + 1)
        var v101 = noise3d(ix + 1, iy, iz + 1)
        var v011 = noise3d(ix, iy + 1, iz + 1)
        var v111 = noise3d(ix + 1, iy + 1, iz + 1)
        var u00 = cosinInterp(v000, v100, fx)
        var u10 = cosinInterp(v010, v110, fx)
        var u01 = cosinInterp(v001, v101, fx)
        var u11 = cosinInterp(v011, v111, fx)
        var w0 = cosinInterp(u00, u10, fy)
        var w1 = cosinInterp(u01, u11, fy)
        return cosinInterp(w0, w1, fz)
end

terra perlinNoise3d(x: float, y: float, z: float)
        var result = 0.0f
        for i=0,5 do
                result = result + interpNoise3d(x * M.exp2f(i), y * M.exp2f(i), z * M.exp2f(i)) * M.exp2f(-i)
        end
        return result
end

return { perlin2d = perlinNoise2d, perlin3d = perlinNoise3d }
