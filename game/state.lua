-- Handles overall game state
function GameState()
    local self = {}
    local gameState = function (dt) end
    local drawState = function () end
    local start, game

    -- START state
    start = function (dt)
        -- Initialize Start State
        local button = Button(400, 300, 100, 50, function () gameState = game end)

        -- Start State Loop
        gameState = function (dt)
            button.update(dt)
        end

        -- Start State Draw Instructions
        drawState = function ()
            button.draw()

            if love.mouse.isDown(1) == true then love.graphics.print("down", 10, 120) end
        end
    end

    -- GAME state
    game = function (dt, level)
        -- Initialize Game State
        local line = Line(100, 700, 300, true)
        line.addRider(Sprite(0, 0, 100))

        local line2 = Line(100, 700, 400, false, true)
        line2.addRider(Sprite(0, 0, 200))

        local word = ''
        local wordFound = false
        local letters = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }

        -- Game State Loop
        gameState = function (dt)
            local key = GetKeyPressed()

            if key ~= '' then
                if key == 'escape' then
                    love.event.quit()
                end
            
                if key == 'backspace' and #word > 0 then
                    word = word:sub(1, -2)
                elseif key == 'return' then
                    wordFound = ValidateWord(word)
                    word = ''
                else
                    for index, value in ipairs(letters) do if key == value then word = word..tostring(key) end end
                end

                ResetKeyPressed()
            end

            line.update(dt)
            line2.update(dt)
        end

        -- Game State Draw Instructions
        drawState = function ()
            love.graphics.print("Word found: "..tostring(wordFound), 10, 200)
    
            line.draw()
            line2.draw()
    
            love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 740, 10)
            love.graphics.print(word, 10, 100)
        end
    end

    self.load = function ()
        require("game.input")
        require("game.sprite")
        require("game.line")
        require("game.words")
        require("game.button")

        gameState = start
    end

    self.update = function (dt)
        gameState(dt)
    end

    self.draw = function ()
        drawState()
    end

    return self
end