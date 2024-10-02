local a = require "game.lists.a"
local b = require "game.lists.b"
local c = require "game.lists.c"

local function ValidateWord(word)
    local startLetter = word:sub(1, 1)

    if startLetter == 'a' then
        for i = 1, #a do if a[i] == word then return true end end
    elseif startLetter == 'b' then
        for i = 1, #b do if b[i] == word then return true end end
    elseif startLetter == 'c' then
        for i = 1, #c do if c[i] == word then return true end end
    end

    return false
end

return ValidateWord