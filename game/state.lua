-- Handles overall game state
function GameState()
    local self = {}
    local gameState = function (dt) end
    local drawState = function () end
    local start, game, prep
    local cron
    local Lives
    local Deck


    -- START state
    start = function ()
        -- Initialize Start State
        local button = Button(600, 450, 100, 50, function () gameState = prep end)
        Lives = 2
        Deck = {
            Letter('a', -100, -100, "strong"),
            Letter('b', -100, -100, "strong"),
            Letter('c', -100, -100, "strong"),
            Letter('d', -100, -100, "strong"),
            Letter('e', -100, -100, "strong"),
            Letter('f', -100, -100, "strong"),
            Letter('a', -100, -100, "strong"),
            Letter('g', -100, -100, "strong"),
            Letter('h', -100, -100, "strong"),
            Letter('i', -100, -100, "strong"),
            Letter('j', -100, -100, "strong"),
            Letter('k', -100, -100, "strong"),
            Letter('l', -100, -100, "strong"),
            Letter('m', -100, -100, "strong"),
            Letter('n', -100, -100, "strong"),
            Letter('o', -100, -100, "strong"),
            Letter('p', -100, -100, "strong"),
            Letter('q', -100, -100, "strong"),
            Letter('r', -100, -100, "strong"),
            Letter('s', -100, -100, "strong"),
            Letter('t', -100, -100, "strong"),
            Letter('u', -100, -100, "strong"),
            Letter('v', -100, -100, "strong"),
            Letter('w', -100, -100, "strong"),
            Letter('x', -100, -100, "strong"),
            Letter('y', -100, -100, "strong"),
            Letter('z', -100, -100, "strong")
        }

        -- Start State Loop
        gameState = function (dt)
            button.update(dt)
        end

        -- Start State Draw Instructions
        drawState = function ()
            button.draw()
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("prep", 580 + XOffset, 450 * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.setColor(255, 255, 255)
        end
    end

    -- PREP state
    prep = function ()
        -- Initialize Prep State
        local button = Button(600, 650, 100, 50, function () gameState = game end)

        for i, v in ipairs(Deck) do
            v.draggable = true
            v.x = 480 + 5 + v.radius + math.fmod(i, 10) * 20
            if i < 10 then v.y = 300
            elseif i < 20 then v.y = 320
            else v.y = 340 end
        end

        -- Prep State Loop
        gameState = function (dt)
            button.update(dt)

            for i, v in ipairs(Deck) do
                for index, letter in ipairs(Deck) do
                    if letter ~= v and DistanceBetween(v.x, v.y, letter.x, letter.y) < v.radius * 2 then
                        local bumpX = (letter.x - v.x) / v.radius
                        local bumpY = (letter.y - v.y) / v.radius
                        letter.x = letter.x + bumpX
                        letter.y = letter.y + bumpY
                        letter.xvel = bumpX * letter.radius
                        letter.yvel = bumpY * letter.radius
                        v.x = v.x - bumpX
                        v.y = v.y - bumpY
                        v.xvel = -bumpX * v.radius
                        v.yvel = -bumpY * v.radius
                    end
                end
                v.update(dt)
            end
        end

        -- Prep State Draw Instructions
        drawState = function ()
            for i, v in ipairs(Deck) do
                love.graphics.print(tostring(v.clicked), v.x, v.y - 20)
                v.draw()
            end

            button.draw()
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("game", 580 + XOffset, 650 * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.setColor(255, 255, 255)
        end
    end

    -- GAME state
    game = function ()
        -- Initialize Game State
        local Level = TestLevel()
        local gun = Gun(200, 800, "first")
        local fireTimer = cron.every(0.2, function (dt) gun.fire(dt) end)
        
        local line = Line(-100, 1300, 200, true)
        local line2 = Line(-100, 1300, 350, false)
        local line3 = Line(-100, 1000, 500, true, true)

        line.nextLine = line2
        line2.prevLine = line
        line2.nextLine = line3
        line3.prevLine = line2

        local blankEnemy = Enemy(200, -100, 0)
        gun.addEnemy(blankEnemy)

        local spawnTimer = cron.every(Level.spawnTimer, function ()
            if Level.canSpawn == true then
                local enemy = Level.spawnEnemy()
                line.addRider(enemy)
                gun.addEnemy(enemy)
            end
        end)

        local word = ''
        local wordFound = false
        local wordValue = 0
        local validLetters = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }
        local letters = {}
        local submittedLetters = {}
        local chamber = {}

        local wordText = love.graphics.newText(love.graphics.getFont())
        local wordFoundText = love.graphics.newText(love.graphics.getFont())
        local wordValueText = love.graphics.newText(love.graphics.getFont())

        local fillChamber = function ()
            for i,v in ipairs(chamber) do
                
            end
        end


        -- Game State Loop
        gameState = function (dt)
            local key = GetKeyPressed()

            -- Word Input & Validation (Keyboard)
            if key ~= '' then
                if key == 'escape' then
                    love.event.quit()
                end
            
                if key == 'backspace' and #word > 0 then
                    word = word:sub(1, -2)
                    table.remove(letters, #letters)
                elseif key == 'return' then
                    wordFound = ValidateWord(word)
                    word = ''

                    wordValue = 0
                    if wordFound == true then
                        local lettas = {}

                        for index, value in ipairs(letters) do
                            wordValue = wordValue + value.value
                            table.insert(submittedLetters, value)
                            table.insert(lettas, submittedLetters[#submittedLetters])
                        end

                        table.insert(gun.ammo, lettas)
                    end
                    letters = {}
                else
                    for index, value in ipairs(validLetters) do
                        if key == value then
                            word = word..tostring(key)
                            table.insert(letters, Letter(key, 575 + #letters * 20, 720))
                            break
                        end
                    end
                end

                ResetKeyPressed()
            end

            spawnTimer:update(dt)

            line.update(dt)
            line2.update(dt)
            line3.update(dt)

            gun.aim()
            fireTimer:update(dt, dt)

            for i, v in ipairs(submittedLetters) do
                if v.x < 0 or v.x > love.graphics.getWidth() - XOffset or v.y < 0 or v.y > love.graphics.getHeight() then table.remove(submittedLetters, i)
                else v.update(dt) end
            end

            -- Collision Detection
            for i, v in ipairs(line.riders) do for index, letter in ipairs(submittedLetters) do if DistanceBetween(v.x, v.y, letter.x, letter.y) <= v.radius + 15 then 
                v.health = v.health - letter.value
                if letter.canPierce == false then table.remove(submittedLetters, index) end end
                break
            end if v.health <= 0 then table.remove(line.riders, i) gun.removeEnemy(v) end end

            for i, v in ipairs(line2.riders) do for index, letter in ipairs(submittedLetters) do if DistanceBetween(v.x, v.y, letter.x, letter.y) <= v.radius + 15 then 
                v.health = v.health - letter.value
                if v.health <= 0 then table.remove(line2.riders, i) gun.removeEnemy(v) end
                if letter.canPierce == false then table.remove(submittedLetters, index) end
                break
            end end end

            for i, v in ipairs(line3.riders) do for index, letter in ipairs(submittedLetters) do if DistanceBetween(v.x, v.y, letter.x, letter.y) <= v.radius + 15 then 
                v.health = v.health - letter.value
                if v.health <= 0 then table.remove(line3.riders, i) gun.removeEnemy(v) end
                if letter.canPierce == false then table.remove(submittedLetters, index) end
                break
            end end end
            
            wordText:set(word)
            wordFoundText:set("Word found: "..tostring(wordFound))
            wordValueText:set("Word value: "..tostring(wordValue))
        end


        -- Game State Draw Instructions
        drawState = function ()
            love.graphics.draw(wordText, (600 - wordText:getWidth() / 2) + XOffset, 130 * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.draw(wordFoundText, (600 - wordFoundText:getWidth() / 2) + XOffset, 160 * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.draw(wordValueText, (600 - wordValueText:getWidth() / 2) + XOffset, 180 * ScaleFactor, 0, ScaleFactor, ScaleFactor)

            -- love.graphics.print("Enemy1: "..tostring(enemy.x), 570 + XOffset, 700 * ScaleFactor)
            -- love.graphics.print("Enemy2: "..tostring(enemy2.x), 570 + XOffset, 720 * ScaleFactor)
    
            line.draw()
            line2.draw()
            line3.draw()

            for i, v in ipairs(letters) do v.draw() end
            for i, v in ipairs(submittedLetters) do v.draw() end

            gun.draw()
            love.graphics.print("Enemies: "..tostring(#gun.enemies), 570 + XOffset, 730 * ScaleFactor)
            love.graphics.print("Gun Word Ammo: "..tostring(#gun.ammo), 570 + XOffset, 750 * ScaleFactor)
            love.graphics.print("Submitted Letters: "..tostring(#submittedLetters), 570 + XOffset, 770 * ScaleFactor)
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
        require("game.util")

        require("game.levels.test_level")

        cron = require "cron"

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