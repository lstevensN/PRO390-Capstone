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
        local button = Button(600, 650, 100, 50, function () gameState = prep end)
        Lives = 2
        Deck = {
            Letter('a', -100, -100, "iron"),
            Letter('b', -100, -100, "iron"),
            Letter('c', -100, -100, "iron"),
            Letter('d', -100, -100, "iron"),
            Letter('e', -100, -100, "iron"),
            Letter('f', -100, -100, "iron"),
            Letter('a', -100, -100, "iron"),
            Letter('g', -100, -100, "iron"),
            Letter('h', -100, -100, "iron"),
            Letter('i', -100, -100, "iron"),
            Letter('j', -100, -100, "iron"),
            Letter('k', -100, -100, "iron"),
            Letter('l', -100, -100, "iron"),
            Letter('m', -100, -100, "iron"),
            Letter('n', -100, -100, "iron"),
            Letter('o', -100, -100, "iron"),
            Letter('p', -100, -100, "iron"),
            Letter('q', -100, -100, "iron"),
            Letter('r', -100, -100, "iron"),
            Letter('s', -100, -100, "iron"),
            Letter('t', -100, -100, "iron"),
            Letter('u', -100, -100, "iron"),
            Letter('v', -100, -100, "iron"),
            Letter('w', -100, -100, "iron"),
            Letter('x', -100, -100, "iron"),
            Letter('y', -100, -100, "iron"),
            Letter('z', -100, -100, "iron")
        }

        -- Start State Loop
        gameState = function (dt)
            button.update(dt)
        end

        -- Start State Draw Instructions
        drawState = function ()
            button.draw()
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("prep", 580 + XOffset, 650 * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.setColor(255, 255, 255)
        end
    end

    -- PREP state
    prep = function ()
        -- Initialize Prep State
        local button = Button(960, 750, 300, 150, function () gameState = game end)
        local transmuteButton

        local boilerX, boilerY, boilerW, boilerH = 50, 100, 375, 700
        local transmutationX, transmutationY, transmutationW, transmutationH = 475, 100, 250, 250
        local storageX, storageY, storageW, storageH = 475, 550, 250, 250

        local sortDeck = function (letter1, letter2) return letter1.value < letter2.value end
        
        local transmutationQueue = {}
        local randomTier1Letter = function (type)
            local num = math.random(5)
            if num == 1 then return Letter("a", 600, 225, type or "iron", true)
            elseif num == 2 then return Letter("e", 600, 225, type or "iron", true)
            elseif num == 3 then return Letter("i", 600, 225, type or "iron", true)
            elseif num == 4 then return Letter("r", 600, 225, type or "iron", true)
            else return Letter("s", 600, 225, type or "iron", true) end
        end
        local randomTier2Letter = function (type)
            local num = math.random(6)
            if num == 1 then return Letter("d", 600, 225, type or "iron", true)
            elseif num == 2 then return Letter("g", 600, 225, type or "iron", true)
            elseif num == 3 then return Letter("l", 600, 225, type or "iron", true)
            elseif num == 4 then return Letter("o", 600, 225, type or "iron", true)
            elseif num == 5 then return Letter("n", 600, 225, type or "iron", true)
            else return Letter("t", 600, 225, type or "iron", true) end
        end
        local randomTier3Letter = function (type)
            local num = math.random(6)
            if num == 1 then return Letter("b", 600, 225, type or "iron", true)
            elseif num == 2 then return Letter("c", 600, 225, type or "iron", true)
            elseif num == 3 then return Letter("h", 600, 225, type or "iron", true)
            elseif num == 4 then return Letter("m", 600, 225, type or "iron", true)
            elseif num == 5 then return Letter("p", 600, 225, type or "iron", true)
            else return Letter("u", 600, 225, type or "iron", true) end
        end
        local randomTier4Letter = function (type)
            local num = math.random(5)
            if num == 1 then return Letter("f", 600, 225, type or "iron", true)
            elseif num == 2 then return Letter("k", 600, 225, type or "iron", true)
            elseif num == 3 then return Letter("v", 600, 225, type or "iron", true)
            elseif num == 4 then return Letter("w", 600, 225, type or "iron", true)
            else return Letter("y", 600, 225, type or "iron", true) end
        end
        local randomTier5Letter = function (type)
            local num = math.random(4)
            if num == 1 then return Letter("j", 600, 225, type or "iron", true)
            elseif num == 2 then return Letter("q", 600, 225, type or "iron", true)
            elseif num == 3 then return Letter("x", 600, 225, type or "iron", true)
            else return Letter("z", 600, 225, type or "iron", true) end
        end
        
        local transmute = function ()
            if #transmutationQueue == 2 then
                local letterFunction = function () end
                local valid = false
                local value1, value2 = transmutationQueue[1].value, transmutationQueue[2].value
                local type1, type2 = transmutationQueue[1].type, transmutationQueue[2].type

                if value1 == 5 and value2 == 5 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier2Letter
                elseif value1 == 10 and value2 == 10 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier3Letter
                elseif value1 == 15 and value2 == 15 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier4Letter
                elseif value1 == 20 and value2 == 20 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier5Letter
                end

                if valid == true then
                    for i, v in ipairs(Deck) do if v == transmutationQueue[1] then table.remove(Deck, i) end end
                    for i, v in ipairs(Deck) do if v == transmutationQueue[2] then table.remove(Deck, i) end end
                    table.insert(Deck, letterFunction())
                    transmutationQueue = {}
                end
            else

            end
        end

        transmuteButton = ButtonCircle(600, 450, 75, transmute)

        for i, v in ipairs(Deck) do
            v.transmuteMode = true

            v.x = math.random(boilerX, boilerX + boilerW)
            v.y = math.random(boilerY, boilerY + boilerH)
        end

        table.sort(Deck, sortDeck)


        -- Prep State Loop
        gameState = function (dt)
            local selected = {}

            button.update(dt)
            transmuteButton.update(dt)

            for i, v in ipairs(Deck) do
                local withinTransmutationZone = false
                if v.x - v.radius >= transmutationX and v.x + v.radius <= transmutationX + transmutationW and 
                v.y - v.radius >= transmutationY and v.y + v.radius <= transmutationY + transmutationH then withinTransmutationZone = true end
                
                if withinTransmutationZone then
                    if #transmutationQueue < 2 and transmutationQueue[1] ~= v then v.locked = true table.insert(transmutationQueue, v) end
                else
                    v.locked = false

                    -- letter collision checks
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
                end

                -- boiler collison checks and bubbling
                if v.locked == false then
                    if v.x - v.radius < boilerX then v.x = boilerX + v.radius v.xvel = -v.xvel end
                    if v.x + v.radius > boilerX + boilerW then v.x = boilerX + boilerW - v.radius v.xvel = -v.xvel end
                    if v.y - v.radius < boilerY then v.y = boilerY + v.radius v.yvel = -v.yvel end
                    if v.y + v.radius > boilerY + boilerH then v.y = boilerY + boilerH - v.radius v.yvel = -v.yvel end

                    -- bubbling :>
                end

                v.update(dt)

                if v.clicked == true and #selected == 0 then table.insert(selected, v) end
                if selected[1] ~= v then v.clicked = false end
            end

            for i, v in ipairs(transmutationQueue) do if v.locked == false then table.remove(transmutationQueue, i) end end
        end


        -- Prep State Draw Instructions
        drawState = function ()
            for i, v in ipairs(Deck) do
                -- love.graphics.print(tostring(v.locked), v.x, v.y - 20)
                v.draw()
            end

            button.draw()
            transmuteButton.draw()

            love.graphics.setColor(0, 0, 0)
            love.graphics.print("game", button.x + XOffset, button.y * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.print("transmute", transmuteButton.x + XOffset, transmuteButton.y * ScaleFactor, 0, ScaleFactor, ScaleFactor)
            love.graphics.setColor(255, 255, 255)

            love.graphics.rectangle("line", boilerX + XOffset, boilerY * ScaleFactor, boilerW, boilerH * ScaleFactor)  -- boiler
            love.graphics.rectangle("line", transmutationX + XOffset, transmutationY * ScaleFactor, transmutationW, transmutationH * ScaleFactor)  -- transmuting area
            love.graphics.rectangle("line", storageX + XOffset, storageY * ScaleFactor, storageW, storageH * ScaleFactor)  -- storage
            love.graphics.rectangle("line", 775 + XOffset, 100 * ScaleFactor, 375, 500 * ScaleFactor)  -- transmutation recipies

            love.graphics.print("Transmutation: "..tostring(#transmutationQueue), 800, 150)
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