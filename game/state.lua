-- Handles overall game state
local wordFound = false
local ValidateWord

GameState = {
--  LOAD =  0,
    MENU  = 1,
    START = 2,
    GAME  = 3,
    WIN   = 4,
    LOSE  = 5,
    END   = 6
}

function GameState.load()
    require("game.input")
    ValidateWord = require "game.words"
end

function GameState.update(dt)
    if GetSubmittedWord() ~= '' then
        wordFound = ValidateWord(GetSubmittedWord())
        ResetSubmittedWord()
    end
end

function GameState.draw()
    DrawWord()

    love.graphics.print("Word found: "..tostring(wordFound), 10, 200)
end

return GameState
