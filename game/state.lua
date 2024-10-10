-- Handles overall game state
local wordFound = false
local ValidateWord, Splines, Sprites
local spline1, spline2

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
    Splines = require "game.spline"
    Sprites = require "game.sprite"

    spline1 = Splines:new({startX = 100, startY = 150, endX = 700, endY = 150, shown = true})
    spline2 = Splines:new({startX = 100, startY = 350, endX = 700, endY = 450, shown = false})

    spline1:direct()
    spline2:direct()

    spline1:addRider(Sprites:new({speed = 50}))
    --spline1:addRider(Sprites:new({speed = 200}))
    --spline1:addRider(Sprites:new({speed = 300}))

    -- spline2:addRider(Sprites:new({speed = 100}))
    --spline2:addRider(Sprites:new({speed = 200}))
    --spline2:addRider(Sprites:new({speed = 300}))
end

function GameState.update(dt)
    if GetSubmittedWord() ~= '' then
        wordFound = ValidateWord(GetSubmittedWord())
        ResetSubmittedWord()
    end

    spline1:update(dt)
    spline2:update(dt)
end

function GameState.draw()
    DrawWord()

    love.graphics.print("Word found: "..tostring(wordFound), 10, 200)

    spline1:draw()
    spline2:draw()

    love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 740, 10)
end

return GameState
