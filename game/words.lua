local a  = require "game.lists.a"
local b  = require "game.lists.b"
local c  = require "game.lists.c"
local d  = require "game.lists.d"
local e  = require "game.lists.e"
local f  = require "game.lists.f"
local g  = require "game.lists.g"
local h  = require "game.lists.h"
local iy = require "game.lists.iy"

local function ValidateWord(word)
    local startLetter = word:sub(1, 1)

    if startLetter == 'a' then
        for i = 1, #a do if a[i] == word then return true end end
    elseif startLetter == 'b' then
        for i = 1, #b do if b[i] == word then return true end end
    elseif startLetter == 'c' then
        for i = 1, #c do if c[i] == word then return true end end
    elseif startLetter == 'd' then
        for i = 1, #d do if d[i] == word then return true end end
    elseif startLetter == 'e' then
        for i = 1, #e do if e[i] == word then return true end end
    elseif startLetter == 'f' then
        for i = 1, #f do if f[i] == word then return true end end
    elseif startLetter == 'g' then
        for i = 1, #g do if g[i] == word then return true end end
    elseif startLetter == 'h' then
        for i = 1, #h do if h[i] == word then return true end end
    elseif startLetter == 'i' or startLetter == 'y' then
        for i = 1, #iy do if iy[i] == word then return true end end
    end

    return false
end

return ValidateWord