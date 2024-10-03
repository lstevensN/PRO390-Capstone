local a  = require "game.lists.a"
local b  = require "game.lists.b"
local c  = require "game.lists.c"
local d  = require "game.lists.d"
local e  = require "game.lists.e"
local f  = require "game.lists.f"
local g  = require "game.lists.g"
local h  = require "game.lists.h"
local iy = require "game.lists.iy"
local j  = require "game.lists.j"
local k  = require "game.lists.k"
local l  = require "game.lists.l"
local m  = require "game.lists.m"
local n  = require "game.lists.n"
local o  = require "game.lists.o"
local p  = require "game.lists.p"
local q  = require "game.lists.q"
local r  = require "game.lists.r"

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
    elseif startLetter == 'j' then
        for i = 1, #j do if j[i] == word then return true end end
    elseif startLetter == 'k' then
        for i = 1, #k do if k[i] == word then return true end end
    elseif startLetter == 'l' then
        for i = 1, #l do if l[i] == word then return true end end
    elseif startLetter == 'm' then
        for i = 1, #m do if m[i] == word then return true end end
    elseif startLetter == 'n' then
        for i = 1, #n do if n[i] == word then return true end end
    elseif startLetter == 'o' then
        for i = 1, #o do if o[i] == word then return true end end
    elseif startLetter == 'p' then
        for i = 1, #p do if p[i] == word then return true end end
    elseif startLetter == 'q' then
        for i = 1, #q do if q[i] == word then return true end end
    elseif startLetter == 'r' then
        for i = 1, #r do if r[i] == word then return true end end
    end

    return false
end

return ValidateWord