--- @class color
local COLOR = { _parseFuncs = { }, __type = "color" }

--- creates a color class from the standard r,g,b,a colors
---
--- @param r number `0-255`
--- @param g number `0-255`
--- @param b number `0-255`
--- @param a number `0-255`
---
--- @return color color
function COLOR.new(r,g,b,a)
    -- creates a new color object form a given 0-255 r,g,b,a
    -- isn't used to make the colors usually, there are other
    -- functions (like the the `fromHex` function)

    local color = { }

    -- metatable magic ...
    setmetatable(color,COLOR)
    COLOR.__index = COLOR

    color.r = r
    color.g = g
    color.b = b
    color.a = a

    color._type = "color"

    return color
end

--- creates a new darker color from the existing color,
--- doesn't modify the original color
---
--- @param newPercent number `0-1`
---
--- @return color darkerColor
function COLOR:darken(newPercent)
    local r = self.r * newPercent
    local g = self.g * newPercent
    local b = self.b * newPercent

    return COLOR.new(r,g,b,self.a)
end

--- attempts to parse the given arguement as a color
--- using the registered parsing funcitons.
function COLOR.parse(c)
    for _, func in pairs(COLOR._parseFuncs) do
        local result = func(COLOR, c)
        if result ~= nil then
            if result.__type == "color" then return result end
        end
    end

    return nil, "unknown format: " .. tostring(c)
end

--- returns a table that is formatted for love, it can be directly
--- passed to love functions that are expecting color data.
---
--- @param override table where the keys `r`,`g`,`b`,`a` will override the existing values. expecting range `0-1`
---
--- @return table color
function COLOR:toLove(override)
    -- converts the color to 0 - 1 rgba table
    --
    -- parameters
    --   override : TABLE - a table of overrides for colors, with
    --                      the keys being r,b,g,a

    override = override or { }

    local r,g,b,a = self:toUnpackedLove()

    if override.r then r = override.r end
    if override.g then g= override.g end
    if override.b then b = override.b end
    if override.a then a = override.a end

    return { r,g,b,a }
end

--- returns a lits of items that is formatted for love, it can be directly
--- passed to love functions that are expecting color data. ranged `0-1`
---
--- @return number r
--- @return number g
--- @return number b
--- @return number a
function COLOR:toUnpackedLove()
    -- convert the 0-255 RGB values to 0-1 love values

    return
        self.r / 255,
        self.g / 255,
        self.b / 255,
        self.a / 255
end

--- creates a formated to string when outputting the color.
---
--- @param color color
---
--- @return string colorString
function COLOR.__tostring(color)
    -- returns a nice string text output, showing the rgba

    return "<color r = '" .. tostring(color.r) .. "', g = '"
        .. tostring(color.g) .. "', b = '" .. tostring(color.b)
        .. "', a = '" .. tostring(color.a) .. "'>"
end

return COLOR