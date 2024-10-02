local word = ''
local submittedWord = ''

function GetSubmittedWord() return submittedWord end
function ResetSubmittedWord() submittedWord = '' end

local function submitWord()
    submittedWord = word
    word = ''
end

-- Keyboard Input
local letters = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }

local function validLetter(key)
    for index, value in ipairs(letters) do
        if key == value then return true end
    end

    return false
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'backspace' and #word > 0 then
        word = word:sub(1, -2)
    elseif key == 'return' then
        submitWord()
    elseif validLetter(key) then
        word = word..tostring(key)
    end
end

-- Controller Input (?)
-- Good luck haha

-- Test Functions
function drawWord()
    love.graphics.print(word, 10, 100)
end
