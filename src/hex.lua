local function hexToInt(hex)
    if hex == "0" then return 0
    elseif hex == "1" then return 1
    elseif hex == "2" then return 2
    elseif hex == "3" then return 3
    elseif hex == "4" then return 4
    elseif hex == "5" then return 5
    elseif hex == "6" then return 6
    elseif hex == "7" then return 7
    elseif hex == "8" then return 8
    elseif hex == "9" then return 9
    elseif hex == "A" or hex == "a" then return 10
    elseif hex == "B" or hex == "b" then return 11
    elseif hex == "C" or hex == "c" then return 12
    elseif hex == "D" or hex == "d" then return 13
    elseif hex == "E" or hex == "e" then return 14
    elseif hex == "F" or hex == "f" then return 15
    else assert(false, "'" .. tostring(hex) .. "' is not a hex value?") end
end

local function hex(library, hexCode)
    local numbers = { }
    local r,g,b,a = 0,0,0,255

    if #hexCode > 1 then
        if hexCode:sub(1,1) == "#" then
            -- checks if the first charcater is a '#' and then
            -- removes it.
            hexCode = hexCode:sub(2,#hexCode)
        else
            return nil, "not a hexcode: " .. hexCode
        end
    end

    if (#hexCode ~= 6 and #hexCode ~= 3 and #hexCode ~= 4 and #hexCode ~= 8) then
        return nil,"not a valid color hex, needs tobe 3 or 6 digits long (or 4 or 8 with alpha)\n"
        .. "found " .. #hexCode
    end

    for i=1,#hexCode do
        numbers[#numbers + 1] = hexToInt(hexCode:sub(i,i))
    end

    if #numbers == 3 then
        -- we are doing a gray or something, no alpha
        r = numbers[1] * 16 + numbers[1]
        g = numbers[2] * 16 + numbers[2]
        b = numbers[3] * 16 + numbers[3]
    elseif #numbers == 4 then
        -- a gray with alpha.
        r = numbers[1] * 16 + numbers[1]
        g = numbers[2] * 16 + numbers[2]
        b = numbers[3] * 16 + numbers[3]
        a = numbers[4] * 16 + numbers[4]
    elseif #numbers == 6 then
        -- number with no alpha
        r = numbers[1] * 16 + numbers[2]
        g = numbers[3] * 16 + numbers[4]
        b = numbers[5] * 16 + numbers[6]
    elseif #numbers == 8 then
        -- number with alpha
        r = numbers[1] * 16 + numbers[2]
        g = numbers[3] * 16 + numbers[4]
        b = numbers[5] * 16 + numbers[6]
        b = numbers[7] * 16 + numbers[8]
    else
        assert(false,"wrong number of digits?? (colors-lua)")
    end

    return library.new(r,g,b,a)
end

return hex