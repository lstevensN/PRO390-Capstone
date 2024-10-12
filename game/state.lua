-- Handles overall game state
local wordFound = false
local ValidateWord, Sprites
local line, line2

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
    require("game.line")

    ValidateWord = require "game.words"
    Sprites = require "game.sprite"

    line = Line(100, 700, 300, true, true)
    line2 = Line(100, 700, 400, true, false)

    line.addRider(Sprites:new({speed = 200}))
    line2.addRider(Sprites:new({speed = 150}))
end

function GameState.update(dt)
    if GetSubmittedWord() ~= '' then
        wordFound = ValidateWord(GetSubmittedWord())
        ResetSubmittedWord()
    end

    line.update(dt)
    line2.update(dt)
end

function GameState.draw()
    DrawWord()

    love.graphics.print("Word found: "..tostring(wordFound), 10, 200)

    line.draw()
    line2.draw()

    love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 740, 10)
end

return GameState
