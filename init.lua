

local thisLibraryPath = ...
local library = require(thisLibraryPath .. ".src.color")

do
    local hex = require(thisLibraryPath .. ".src.hex")
    table.insert(library._parseFuncs, hex)
    library.fromHex = function(s) return hex(library, s) end
end

library.__library_version = "0.1.0"
library.__library_name = "colors"

return library