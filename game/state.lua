-- Handles overall game state
function GameState()
    local self = {}
    local gameState = function (dt) end
    local drawState = function () end
    local start, game

    -- START state
    start = function ()
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
    game = function (level)
        -- Initialize Game State
        local line = Line(100, 700, 300, true)
        line.addRider(Sprite(0, 0, 100))

        local line2 = Line(100, 700, 400, false, true)
        line2.addRider(Sprite(0, 0, 200))

        local gun = Gun(300, 600)

        local word = ''
        local wordFound = false
        local wordValue = 0
        local validLetters = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }
        local letters = {}


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

                    wordValue = 0
                    for index, value in ipairs(letters) do wordValue = wordValue + value.value end
                    letters = {}
                else
                    for index, value in ipairs(validLetters) do
                        if key == value then
                            word = word..tostring(key)
                            table.insert(letters, Letter(key))
                            break
                        end
                    end
                end

                ResetKeyPressed()
            end

            line.update(dt)
            line2.update(dt)

            gun.aim(line2.riders)
        end


        -- Game State Draw Instructions
        drawState = function ()
            love.graphics.print("Word found: "..tostring(wordFound), 10, 200)
            love.graphics.print("Word value: "..tostring(wordValue), 10, 230)
    
            line.draw()
            line2.draw()

            gun.draw()
    
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
        require("game.letter")
        require("game.gun")

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