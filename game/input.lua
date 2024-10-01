local word = ''
local letters = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }

local function valid(key)
    for index, value in ipairs(letters) do
        if key == value then return true end
    end

    return false
end

function love.keypressed(key)
    --[[if key == 'escape' then
        love.event.quit()
    end]]--

    if key =='backspace' and #word > 0 then
        word = word:sub(1, -2)
    elseif valid(key) then
        word = word..tostring(key)
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function drawWord()
    love.graphics.print(word, 10, 100)
end