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
        end
    end

    -- GAME state
    game = function (level)
        -- Initialize Game State
        local gun = Gun(200, 800, "first")
        
        local line = Line(100, 1100, 300, true)
        local line2 = Line(100, 1100, 400, false)
        local line3 = Line(100, 1100, 500, true, true)

        line.nextLine = line2
        line2.prevLine = line
        line2.nextLine = line3
        line3.prevLine = line2
        
        local enemy = Enemy(0, 0, 250)
        line.addRider(enemy)
        gun.addEnemy(enemy)

        local enemy2 = Enemy(0, 0, 300)
        line.addRider(enemy2)
        gun.addEnemy(enemy2)

        local word = ''
        local wordFound = false
        local wordValue = 0
        local validLetters = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }
        local letters = {}

        local wordText = love.graphics.newText(love.graphics.getFont())
        local wordFoundText = love.graphics.newText(love.graphics.getFont())
        local wordValueText = love.graphics.newText(love.graphics.getFont())


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
            line3.update(dt)

            gun.aim()

            wordText:set(word)
            wordFoundText:set("Word found: "..tostring(wordFound))
            wordValueText:set("Word value: "..tostring(wordValue))
        end


        -- Game State Draw Instructions
        drawState = function ()
            love.graphics.draw(wordText, (600 - wordText:getWidth() / 2) + XOffset, 130 * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.draw(wordFoundText, (600 - wordFoundText:getWidth() / 2) + XOffset, 160 * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.draw(wordValueText, (600 - wordValueText:getWidth() / 2) + XOffset, 180 * ScaleFactor, 0, ScaleFactor, ScaleFactor)

            love.graphics.print("Enemy1: "..tostring(enemy.progress), 600, 700)
            love.graphics.print("Enemy2: "..tostring(enemy2.progress), 600, 720)
    
            line.draw()
            line2.draw()
            line3.draw()

            gun.draw()
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
        require("game.enemy")

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