-- Handles overall game state
function GameState()
    local self = {}
    local wordFound = false
    local gameState = function (dt) end
    local drawState = function () end

    -- START state
    local start = function (dt)
    end

    -- GAME state
    local game = function (dt, level)
        -- Initialize Game State
        local line = Line(100, 700, 300, true)
        line.addRider(Sprite(0, 0, 100))

        local line2 = Line(100, 700, 400, false, true)
        line2.addRider(Sprite(0, 0, 200))

        -- Game State Loop
        gameState = function (dt)
            if GetSubmittedWord() ~= '' then
                wordFound = ValidateWord(GetSubmittedWord())
                ResetSubmittedWord()
            end
    
            line.update(dt)
            line2.update(dt)
        end

        -- Game State Draw Instructions
        drawState = function ()
            DrawWord()

            love.graphics.print("Word found: "..tostring(wordFound), 10, 200)
    
            line.draw()
            line2.draw()
    
            love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 740, 10)
        end
    end

    self.load = function ()
        require("game.input")
        require("game.sprite")
        require("game.line")
        require("game.words")

        gameState = game
    end

    self.update = function (dt)
        gameState(dt)
    end

    self.draw = function ()
        drawState()
    end

    return self
end