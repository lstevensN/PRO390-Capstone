-- Handles overall game state
function GameState()
    local self = {}
    local gameState = function (dt) end
    local drawState = function () end
    local start, game, prep
    local cron
    local Lives
    local Deck
    local Storage


    -- START state
    start = function ()
        -- Initialize Start State
        local button = Button(600, 650, 100, 50, function () gameState = prep end)
        Lives = 2
        Deck = {
            Letter('a', -100, -100, "pierce"),
            Letter('b', -100, -100, "pierce"),
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
            Letter('o', -100, -100, "pierce"),
            Letter('p', -100, -100, "iron"),
            Letter('q', -100, -100, "iron"),
            Letter('u', -100, -100, "iron"),
            Letter('v', -100, -100, "iron"),
            Letter('w', -100, -100, "iron"),
            Letter('x', -100, -100, "iron"),
            Letter('y', -100, -100, "pierce"),
        }
        Storage = {
            Letter('z', -100, -100, "pierce"),
            Letter('r', -100, -100, "iron"),
            Letter('s', -100, -100, "iron"),
            Letter('t', -100, -100, "iron")
        }

        -- Start State Loop
        gameState = function (dt)
            button.update(dt)
        end

        -- Start State Draw Instructions
        drawState = function ()
            button.draw()
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("prep", 580, 650, 0)
            love.graphics.setColor(255, 255, 255)
        end
    end

    -- PREP state
    prep = function ()
        -- Initialize Prep State
        local button = Button(960, 750, 300, 150, function () gameState = game end)
        local transmuteButton

        local boilerX, boilerY, boilerW, boilerH = 50, 50, 375, 800
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
        
        -- transmuation recipies
        local transmute = function ()
            local letterFunction = function () end
            local valid = false
            local letterType = "iron"

            if #transmutationQueue == 2 then
                local value1, value2 = transmutationQueue[1].value, transmutationQueue[2].value
                local type1, type2 = transmutationQueue[1].type, transmutationQueue[2].type

                -- iron combining
                if value1 == 5 and value2 == 5 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier2Letter
                elseif value1 == 10 and value2 == 10 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier3Letter
                elseif value1 == 15 and value2 == 15 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier4Letter
                elseif value1 == 20 and value2 == 20 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier5Letter
                elseif ((value1 == 25 and value2 == 5) or (value1 == 5 and value2 == 25)) and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier1Letter letterType = "pierce"
                elseif ((value1 == 25 and value2 == 10) or (value1 == 10 and value2 == 25)) and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier2Letter letterType = "pierce"
                elseif ((value1 == 25 and value2 == 15) or (value1 == 15 and value2 == 25)) and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier3Letter letterType = "pierce"
                elseif ((value1 == 25 and value2 == 20) or (value1 == 20 and value2 == 25)) and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier4Letter letterType = "pierce"
                -- pierce combining
                elseif value1 == 1 and value2 == 1 and type1 == "pierce" and type2 == "pierce" then valid = true letterFunction = randomTier2Letter letterType = "pierce"
                elseif value1 == 2 and value2 == 2 and type1 == "pierce" and type2 == "pierce" then valid = true letterFunction = randomTier3Letter letterType = "pierce"
                elseif value1 == 3 and value2 == 3 and type1 == "pierce" and type2 == "pierce" then valid = true letterFunction = randomTier4Letter letterType = "pierce"
                elseif value1 == 4 and value2 == 4 and type1 == "pierce" and type2 == "pierce" then valid = true letterFunction = randomTier5Letter letterType = "pierce"
                end

                if valid == true then
                    for i, v in ipairs(Deck) do if v == transmutationQueue[1] then table.remove(Deck, i) end end
                    for i, v in ipairs(Deck) do if v == transmutationQueue[2] then table.remove(Deck, i) end end
                    table.insert(Deck, letterFunction(letterType))
                    transmutationQueue = {}
                    table.sort(Deck, sortDeck)
                end
            elseif #transmutationQueue == 1 then
                local value = transmutationQueue[1].value
                local type = transmutationQueue[1].type
                local letterFunction2 = function () end

                -- iron splitting
                if value == 25 and type == "iron" then valid = true letterFunction = randomTier4Letter letterFunction2 = randomTier4Letter
                elseif value == 20 and type == "iron" then valid = true letterFunction = randomTier3Letter letterFunction2 = randomTier3Letter
                elseif value == 15 and type == "iron" then valid = true letterFunction = randomTier2Letter letterFunction2 = randomTier2Letter
                elseif value == 10 and type == "iron" then valid = true letterFunction = randomTier1Letter letterFunction2 = randomTier1Letter
                -- pierce splitting
                elseif value == 5 and type == "pierce" then valid = true letterFunction = randomTier4Letter letterFunction2 = randomTier4Letter letterType = "pierce"
                elseif value == 4 and type == "pierce" then valid = true letterFunction = randomTier5Letter letterFunction2 = randomTier4Letter
                elseif value == 3 and type == "pierce" then valid = true letterFunction = randomTier5Letter letterFunction2 = randomTier3Letter
                elseif value == 2 and type == "pierce" then valid = true letterFunction = randomTier5Letter letterFunction2 = randomTier2Letter
                elseif value == 1 and type == "pierce" then valid = true letterFunction = randomTier5Letter letterFunction2 = randomTier1Letter
                end

                if valid == true then
                    for i, v in ipairs(Deck) do if v == transmutationQueue[1] then table.remove(Deck, i) end end
                    table.insert(Deck, letterFunction(letterType))
                    Deck[#Deck].x = Deck[#Deck].x - Deck[#Deck].radius * 2
                    table.insert(Deck, letterFunction2(letterType))
                    Deck[#Deck].x = Deck[#Deck].x + Deck[#Deck].radius * 2
                    transmutationQueue = {}
                    table.sort(Deck, sortDeck)
                end
            end
        end

        transmuteButton = ButtonCircle(600, 450, 75, transmute)

        for i, v in ipairs(Deck) do
            v.transmuteMode = true

            v.x = math.random(boilerX, boilerX + boilerW)
            if v.value == 1 or (v.value == 5 and v.type == "iron") then v.y = math.random(boilerH / 5 - 10, boilerH / 5 + 10)
            elseif v.value == 2 or (v.value == 10 and v.type == "iron") then v.y = math.random(boilerH / 5 * 2 - 10, boilerH / 5 * 2 + 10)
            elseif v.value == 3 or (v.value == 15 and v.type == "iron") then v.y = math.random(boilerH / 5 * 3 - 10, boilerH / 5 * 3 + 10)
            elseif v.value == 4 or (v.value == 20 and v.type == "iron") then v.y = math.random(boilerH / 5 * 4 - 10, boilerH / 5 * 4 + 10)
            elseif v.value == 5 or (v.value == 25 and v.type == "iron") then v.y = math.random(boilerH - 10, boilerH + 10) end
        end

        table.sort(Deck, sortDeck)

        for i, v in ipairs(Storage) do v.transmuteMode = true end
        table.sort(Storage, sortDeck)


        -- Prep State Loop
        gameState = function (dt)
            local selected = {}

            button.update(dt)
            transmuteButton.update(dt)

            for i, v in ipairs(Deck) do
                local withinTransmutationZone = false

                if v.x - v.radius >= transmutationX and v.x + v.radius <= transmutationX + transmutationW and
                v.y - v.radius >= transmutationY and v.y + v.radius <= transmutationY + transmutationH then withinTransmutationZone = true end

                if v.x - v.radius >= storageX - 15 and v.x + v.radius <= storageX + storageW + 15 and
                v.y - v.radius >= storageY - 15 and v.y + v.radius <= storageY + storageH + 15 then v.stored = true end
                
                if withinTransmutationZone then
                    if #transmutationQueue < 2 and transmutationQueue[1] ~= v then v.locked = true table.insert(transmutationQueue, v) end
                else v.locked = false end

                -- letter collision checks
                for index, letter in ipairs(Deck) do
                    if letter ~= v and DistanceBetween(v.x, v.y, letter.x, letter.y) < v.radius * 2 then
                        local bumpX = (letter.x - v.x) / v.radius
                        local bumpY = (letter.y - v.y) / v.radius
                        letter.x = letter.x + bumpX
                        letter.y = letter.y + bumpY
                        v.x = v.x - bumpX
                        v.y = v.y - bumpY
                        if withinTransmutationZone == false and v.stored == false and letter.stored == false then
                            letter.xvel = bumpX * letter.radius
                            letter.yvel = bumpY * letter.radius
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
                    if v.value == 1 or (v.value == 5 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, (boilerH / 5 - v.y), 50) * dt
                    elseif v.value == 2 or (v.value == 10 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, (boilerH / 5 * 2 - v.y), 50) * dt
                    elseif v.value == 3 or (v.value == 15 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, (boilerH / 5 * 3 - v.y), 50) * dt
                    elseif v.value == 4 or (v.value == 20 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, (boilerH / 5 * 4 - v.y), 50) * dt
                    elseif v.value == 5 or (v.value == 25 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, (boilerH - v.y), 50) * dt
                    end
                end

                v.update(dt)

                if v.clicked == true and #selected == 0 then table.insert(selected, v) end
                if selected[1] ~= v then v.clicked = false end

                if v.stored == true and #Storage < 25 then table.insert(Storage, v) table.remove(Deck, i) else v.stored = false end
            end

            for i, v in ipairs(Storage) do
                v.x = 500 + (math.fmod(i - 1, 5) * v.radius * 2.5)
                v.y = 575 + ((math.ceil(i / 5) - 1) * v.radius * 2.5)

                v.update(dt)

                if v.clicked == true and #selected == 0 then table.insert(selected, v) end
                if selected[1] ~= v then v.clicked = false end

                if v.x - v.radius >= boilerX and v.x + v.radius <= boilerX + boilerW and
                v.y - v.radius >= boilerY and v.y + v.radius <= boilerY + boilerH then
                    v.stored = false
                    table.insert(Deck, v)
                    table.remove(Storage, i)
                end
            end

            for i, v in ipairs(transmutationQueue) do if v.locked == false then table.remove(transmutationQueue, i) end end
        end


        -- Prep State Draw Instructions
        drawState = function ()
            for i, v in ipairs(Deck) do v.draw() end
            for i, v in ipairs(Storage) do v.draw() end

            button.draw()
            transmuteButton.draw()

            love.graphics.setColor(0, 0, 0)
            love.graphics.print("game", button.x, button.y, 0)
            love.graphics.print("transmute", transmuteButton.x, transmuteButton.y, 0)
            love.graphics.setColor(255, 255, 255)

            love.graphics.rectangle("line", boilerX, boilerY, boilerW, boilerH)  -- boiler
            love.graphics.rectangle("line", transmutationX, transmutationY, transmutationW, transmutationH)  -- transmuting area
            love.graphics.rectangle("line", storageX, storageY, storageW, storageH)  -- storage
            love.graphics.rectangle("line", 775, 100, 375, 500)  -- transmutation recipies

            love.graphics.print("Transmutation: "..tostring(#transmutationQueue), 800, 150)
        end
    end

    -- GAME state
    game = function ()
        -- Initialize Game State
        local recentX, recentY, recentW, recentH = 355, 620, 175, 130
        local chambersX, chambersY, chambersW, chambersH = 545, 650, 425, 80
        local inputX, inputY, inputW, inputH = 50, 770, 920, 80

        local Level = TestLevel()
        local gun = Gun(150, 650, "first")
        local fireTimer = cron.every(0.2, function (dt) gun.fire(dt) end)
        
        local line = Line(-100, 1300, 130, true)
        local line2 = Line(-100, 1300, 280, false)
        local line3 = Line(-100, 1000, 430, true, true)

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
        local chamberCount = 1

        local wordText = love.graphics.newText(love.graphics.getFont())
        local wordFoundText = love.graphics.newText(love.graphics.getFont())
        local wordValueText = love.graphics.newText(love.graphics.getFont())

        local fillChamber = function ()
            if #chamber ~= chamberCount then table.insert(chamber, Letter("nil")) end

            for i = 1, chamberCount do
                if chamber[i].letter == "nil" then
                    local chamberContainsLetter = false
                    local chamberLetter

                    repeat
                        chamberContainsLetter = false
                        chamberLetter = Deck[math.random(#Deck)]
                        for index, value in ipairs(chamber) do if chamberLetter == value then chamberContainsLetter = true break end end
                    until chamberContainsLetter == false

                    chamberLetter.x = chambersX + 30 + (i - 1) * chamberLetter.radius * 2.6
                    chamberLetter.y = chambersY + chambersH / 2

                    chamber[i] =  chamberLetter
                end

                chamber[i].x = chambersX + 30 + (i - 1) * chamber[i].radius * 2.6
                chamber[i].y = chambersY + chambersH / 2
            end
        end

        fillChamber()

        for i, v in ipairs(Deck) do v.locked = false v.transmuteMode = false end


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
                            for i, v in ipairs(chamber) do if value == v then
                                local lock = false
                                if v.locked == true then lock = true end
                                chamber[i] = Letter("nil")
                                chamber[i].locked = lock
                                break
                            end end

                            value.locked = false

                            wordValue = wordValue + value.value
                            table.insert(submittedLetters, value)
                            table.insert(lettas, submittedLetters[#submittedLetters])
                        end

                        table.insert(gun.ammo, lettas)

                        local fillCheck = 0

                        for i, v in ipairs(chamber) do if v.locked == true then fillCheck = fillCheck + 1 end end

                        --if fillCheck == #chamber then chamberCount = chamberCount + 1 end
                        if chamberCount ~= 8 then chamberCount = chamberCount + 1 end
                        fillChamber()
                    end
                    letters = {}
                else
                    for index, value in ipairs(validLetters) do
                        if key == value then
                            word = word..tostring(key)

                            local chamberCheck = false

                            for i, v in ipairs(chamber) do if v.letter == key and v.locked == false then
                                chamberCheck = true
                                v.x = inputX + 30 + #letters * 20 * 2.25
                                v.y = inputY + inputH / 2
                                v.locked = true
                                table.insert(letters, v)
                                break
                            end end

                            if chamberCheck == false then table.insert(letters, Letter(key, inputX + 30 + #letters * 20 * 2.25, inputY + inputH / 2)) end
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
                if v.x < 0 or v.x > love.graphics.getWidth() or v.y < 0 or v.y > love.graphics.getHeight() then table.remove(submittedLetters, i)
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
            --love.graphics.draw(wordText, 800 - wordText:getWidth() / 2, 130, 0)
            love.graphics.draw(wordFoundText, 800 - wordFoundText:getWidth() / 2, 160, 0)
            love.graphics.draw(wordValueText, 800 - wordValueText:getWidth() / 2, 180, 0)

            -- love.graphics.print("Enemy1: "..tostring(enemy.x), 570, 700)
            -- love.graphics.print("Enemy2: "..tostring(enemy2.x), 570, 720)
    
            line.draw()
            line2.draw()
            line3.draw()

            for i, v in ipairs(letters) do v.draw() end
            for i, v in ipairs(submittedLetters) do v.draw() end
            for i, v in ipairs(chamber) do v.draw() end

            gun.draw()
            love.graphics.print("Enemies: "..tostring(#gun.enemies), 1000, 630)
            love.graphics.print("Gun Word Ammo: "..tostring(#gun.ammo), 1000, 650)
            love.graphics.print("Submitted Letters: "..tostring(#submittedLetters), 1000, 670)

            love.graphics.rectangle("line", 0, 600, 1200, 300) -- Outline

            --love.graphics.circle("line", 115, 115, 100)
            love.graphics.circle("line", 1085, 750, 100)  -- Facial Reaction

            love.graphics.rectangle("line", recentX, recentY, recentW, recentH)  -- Recently Used Words
            love.graphics.rectangle("line", chambersX, chambersY, chambersW, chambersH)  -- Letter Chambers
            love.graphics.rectangle("line", inputX, inputY, inputW, inputH)  -- Letter Input Area
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