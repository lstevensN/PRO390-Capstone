-- Handles overall game state

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
    require("game.words")
end

function GameState.update(dt)
    
end

function GameState.draw()
    drawWord()

    --love.graphics.print()
end

return GameState
