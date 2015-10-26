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

return prefix
