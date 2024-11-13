-- Handles overall game state
function GameState()
    local self = {}
    local gameState = function (dt) end
    local drawState = function () end
    local pauseState, pauseDrawState = function () end, function () end
    local start, game, prep, progress
    local cron
    local Lives
    local Deck
    local Storage
    local paused, canPause, pausePressed = false, false, false
    local act, difficulty = 3, 2


    -- START state
    start = function ()
        -- Initialize Start State
        canPause = false

        local buttonStart = Button(290, 280, 300, 100, function () gameState = progress end)
        local buttonSettings = Button(290, 480, 300, 100, function () end)
        local buttonQuit = Button(290, 680, 300, 100, function () love.event.quit() end)  -- DON'T FORGET TO ADD SAVING

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
            buttonStart.update(dt)
            buttonSettings.update(dt)
            buttonQuit.update(dt)
        end


        -- Start State Draw Instructions
        drawState = function ()
            buttonStart.draw()
            buttonSettings.draw()
            buttonQuit.draw()

            love.graphics.setColor(0, 0, 0)
            love.graphics.print("start", 290, 280)
            love.graphics.print("settings", 290, 480)
            love.graphics.print("quit", 290, 680)
            love.graphics.setColor(255, 255, 255)
        end
    end

    -- PROGRESS state
    progress = function ()
        -- Initialize Progress State
        canPause = true

        local buttonAct1 = ButtonCircle(150, 350, 100, function () gameState = prep end)
        local buttonAct2 = ButtonCircle(450, 350, 100, function () gameState = prep end)
        local buttonAct3 = ButtonCircle(750, 350, 100, function () gameState = prep end)
        local buttonAct4 = ButtonCircle(1050, 350, 100, function () gameState = prep end)

        local buttonDifficultyEasy = Button(375, 630, 140, 50, function () difficulty = 1 end)
        local buttonDifficultyNormal = Button(525, 630, 140, 50, function () difficulty = 2 end)
        local buttonDifficultyHard = Button(675, 630, 140, 50, function () difficulty = 3 end)
        local buttonDifficultyInsane = Button(825, 630, 140, 50, function () difficulty = 4 end)


        -- Progress State Loop
        gameState = function (dt)
            if act == 1 then buttonAct1.update(dt)
            elseif act == 2 then buttonAct2.update(dt)
            elseif act == 3 then buttonAct3.update(dt)
            elseif act == 4 then buttonAct4.update(dt) end

            buttonDifficultyEasy.update(dt)
            buttonDifficultyNormal.update(dt)
            buttonDifficultyHard.update(dt)
            buttonDifficultyInsane.update(dt)
        end


        -- Progress State Draw Instructions
        drawState = function ()
            love.graphics.circle("line", 150, 350, 100)
            love.graphics.circle("line", 450, 350, 100)
            love.graphics.circle("line", 750, 350, 100)
            love.graphics.circle("line", 1050, 350, 100)

            if act == 1 then buttonAct1.draw()
            elseif act == 2 then buttonAct2.draw()
            elseif act == 3 then buttonAct3.draw()
            elseif act == 4 then buttonAct4.draw() end

            love.graphics.rectangle("line", 300, 600, 150, 60)
            love.graphics.rectangle("line", 450, 600, 150, 60)
            love.graphics.rectangle("line", 600, 600, 150, 60)
            love.graphics.rectangle("line", 750, 600, 150, 60)

            if difficulty == 1 then buttonDifficultyEasy.draw()
            elseif difficulty == 2 then buttonDifficultyNormal.draw()
            elseif difficulty == 3 then buttonDifficultyHard.draw()
            elseif difficulty == 4 then buttonDifficultyInsane.draw() end

            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Easy", 375, 630)
            love.graphics.print("Normal", 525, 630)
            love.graphics.print("Hard", 675, 630)
            love.graphics.print("Insane", 825, 630)
            love.graphics.print("ACT 3", 750, 350)
            love.graphics.setColor(1, 1, 1)

            love.graphics.rectangle("line", 0, 720, 1200, 180)
        end
    end

    -- PREP state
    prep = function ()
        -- Initialize Prep State
        canPause = true
        pauseDrawState = function () love.graphics.rectangle("fill", 450, 200, 300, 400) end

        local background = love.graphics.newImage("game/assets/transmute UI.png")
        
        local countFont = love.graphics.newFont("game/assets/fonts/Irregularis-raa9.ttf", 35)
        local boilerCount = love.graphics.newText(countFont)
        
        local previewFont = love.graphics.newFont("game/assets/fonts/WC_RoughTrad.ttf", 80)
        local previewText = love.graphics.newText(previewFont)
        local previewColorWhite = false
        local preview = nil

        local goButton = Button(950, 720, 280, 170, function () gameState = game end, "game/assets/go_button.png", "game/assets/go_button_pressed.png")
        local transmuteButton

        local boilerX, boilerY, boilerW, boilerH = 52, 155, 371, 690
        local transmutationX, transmutationY, transmutationW, transmutationH = 475, 100, 250, 250
        local storageX, storageY, storageW, storageH = 465, 535, 280, 280

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

        transmuteButton = Button(605, 450, 300, 100, transmute, "game/assets/transmute_button.png", "game/assets/transmute_button_pressed.png")

        for i, v in ipairs(Deck) do
            v.transmuteMode = true

            v.x = math.random(boilerX, boilerX + boilerW)
            if v.value == 1 or (v.value == 5 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 - 10, boilerY + boilerH / 10 + 10)
            elseif v.value == 2 or (v.value == 10 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 * 3 - 10, boilerY + boilerH / 10 * 3 + 10)
            elseif v.value == 3 or (v.value == 15 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 * 5 - 10, boilerY + boilerH / 10 * 5 + 10)
            elseif v.value == 4 or (v.value == 20 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 * 7 - 10, boilerY + boilerH / 10 * 7 + 10)
            elseif v.value == 5 or (v.value == 25 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 * 9 - 10, boilerY + boilerH / 10 * 9 + 10) end
        end

        table.sort(Deck, sortDeck)

        for i, v in ipairs(Storage) do v.transmuteMode = true end
        table.sort(Storage, sortDeck)


        -- Prep State Loop
        gameState = function (dt)
            local selected = {}

            goButton.update(dt)
            transmuteButton.update(dt)

            for i, v in ipairs(Deck) do
                local withinTransmutationZone = false

                if #Deck > 15 then
                    if v.x - v.radius >= transmutationX and v.x + v.radius <= transmutationX + transmutationW and
                    v.y - v.radius >= transmutationY and v.y + v.radius <= transmutationY + transmutationH then withinTransmutationZone = true end

                    if v.x - v.radius >= storageX - 15 and v.x + v.radius <= storageX + storageW + 15 and
                    v.y - v.radius >= storageY - 15 and v.y + v.radius <= storageY + storageH + 15 then v.stored = true end
                    
                    if withinTransmutationZone then
                        if #transmutationQueue < 2 and transmutationQueue[1] ~= v then v.locked = true table.insert(transmutationQueue, v) end
                    else v.locked = false end
                end

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
                            v.xvel = -bumpX * v.radius / 2
                            v.yvel = -bumpY * v.radius / 2
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
                    if v.value == 1 or (v.value == 5 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, boilerY + boilerH / 10 - v.y, 50) * dt
                    elseif v.value == 2 or (v.value == 10 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, boilerY + boilerH / 10 * 3 - v.y, 50) * dt
                    elseif v.value == 3 or (v.value == 15 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, boilerY + boilerH / 10 * 5 - v.y, 50) * dt
                    elseif v.value == 4 or (v.value == 20 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, boilerY + boilerH / 10 * 7 - v.y, 50) * dt
                    elseif v.value == 5 or (v.value == 25 and v.type == "iron") then v.yvel = v.yvel + math.clamp(-50, boilerY + boilerH / 10 * 9 - v.y, 50) * dt
                    end
                end

                v.update(dt)

                if v.clicked == true and #selected == 0 then table.insert(selected, v) end
                if selected[1] ~= v then v.clicked = false end

                if v.stored == true and #Storage < 25 then table.insert(Storage, v) table.remove(Deck, i) else v.stored = false end

                if v.hoveredOver == true or v.clicked == true then
                    if v.type == "pierce" then previewColorWhite = true else previewColorWhite = false end
                    previewText:set(string.upper(v.letter))
                    if v.preview ~= nil then preview = v.preview end
                end
            end

            for i, v in ipairs(Storage) do
                v.x = storageX + 28 * (math.fmod(i - 1, 5)) * 2 + 28
                v.y = storageY + 28 * ((math.ceil(i / 5) - 1)) * 2 + 28

                v.update(dt)

                if v.clicked == true and #selected == 0 then table.insert(selected, v) end
                if selected[1] ~= v then v.clicked = false end

                if v.x - v.radius >= boilerX and v.x + v.radius <= boilerX + boilerW and
                v.y - v.radius >= boilerY and v.y + v.radius <= boilerY + boilerH then
                    v.stored = false
                    table.insert(Deck, v)
                    table.remove(Storage, i)
                end

                if v.hoveredOver == true or v.clicked == true then
                    if v.type == "pierce" then previewColorWhite = true else previewColorWhite = false end
                    previewText:set(string.upper(v.letter))
                    if v.preview ~= nil then preview = v.preview end
                end
            end

            for i, v in ipairs(transmutationQueue) do if v.locked == false then table.remove(transmutationQueue, i) end end

            boilerCount:set("Letters: "..tostring(#Deck))
        end


        -- Prep State Draw Instructions
        drawState = function ()
            love.graphics.draw(background, 0, 0, 0, 0.5, 0.5)

            for i, v in ipairs(Deck) do v.draw() end
            for i, v in ipairs(Storage) do v.draw() end

            if #Deck == 15 then love.graphics.setColor(1, 0, 0) end
            love.graphics.draw(boilerCount, 237 - boilerCount:getWidth() / 2, 857, 0)
            love.graphics.setColor(1, 1, 1)

            if preview ~= nil then love.graphics.draw(preview, 830, 175, 0, 0.25, 0.25) end
            if previewColorWhite == false then love.graphics.setColor(0, 0, 0) end
            love.graphics.draw(previewText, 889 - previewText:getWidth() / 2, 180, 0)
            love.graphics.setColor(1, 1, 1)

            goButton.draw()
            transmuteButton.draw()

            if paused == true then pauseDrawState() end
        end
    end

    -- GAME state
    game = function ()
        -- Initialize Game State
        canPause = true
        math.randomseed(os.time())

        -- assets
        local i_background = love.graphics.newImage("game/assets/beach.png")
        local i_inputAndChambers = love.graphics.newImage("game/assets/input_and_chambers_2.png")
        local i_bench = love.graphics.newImage("game/assets/bench_2.png")
        local i_icon = love.graphics.newImage("game/assets/icon.png")

        local recentX, recentY, recentW, recentH = 355, 620, 175, 130
        local chambersX, chambersY, chambersW, chambersH = 572, 650, 425, 80
        local inputX, inputY, inputW, inputH = 50, 770, 920, 80

        local Level = TestLevel()
        local gun = Gun(140, 680, "first")
        local fireTimer = cron.every(0.2, function (dt) gun.fire(dt) end)
        
        local line = Line(-100, 1300, 100, true)
        local line2 = Line(-100, 1300, 265, false)
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
        
        local typedLetters = {}
        local submittedLetters = {}
        local chambers = {}
        local chamberCount = 1

        local wordText = love.graphics.newText(love.graphics.getFont())
        local wordFoundText = love.graphics.newText(love.graphics.getFont())
        local wordValueText = love.graphics.newText(love.graphics.getFont())

        local resetChambers = function ()
            for i, v in ipairs(chambers) do
                v.locked = false
                v.x = chambersX + (i - 1) * 61.6
                v.y = chambersY + chambersH / 2 + 5
            end
        end

        local fillChambers = function ()
            if #chambers ~= chamberCount then table.insert(chambers, Letter("nil")) end

            for i = 1, chamberCount do
                if chambers[i].letter == "nil" then
                    local chamberContainsLetter, gunContainsLetter = false, false
                    local chamberLetter

                    repeat
                        chamberContainsLetter = false
                        gunContainsLetter = false

                        repeat
                            chamberContainsLetter = false
                            chamberLetter = Deck[math.random(#Deck)]
                            for index, value in ipairs(chambers) do if chamberLetter == value then chamberContainsLetter = true break end end
                        until chamberContainsLetter == false

                        for index, value in ipairs(gun.ammo) do
                            for ind, val in ipairs(value) do if chamberLetter == val then gunContainsLetter = true break end end
                            if gunContainsLetter == true then break end
                        end
                    until gunContainsLetter == false

                    chamberLetter.x = chambersX + (i - 1) * 61.6
                    chamberLetter.y = chambersY + chambersH / 2 + 5

                    chambers[i] =  chamberLetter
                end
            end
        end

        fillChambers()

        for i, v in ipairs(Deck) do v.locked = false v.transmuteMode = false end


        -- Game State Loop
        gameState = function (dt)
            local key = GetKeyPressed()

            -- Word Input & Validation (Keyboard)
            if key ~= '' then
                if key == 'backspace' and #word > 0 then
                    word = word:sub(1, -2)

                    for i, v in ipairs(chambers) do
                        if typedLetters[#typedLetters] == v then
                            v.locked = false
                            v.x = chambersX + (i - 1) * 61.6
                            v.y = chambersY + chambersH / 2 + 5
                            break
                        end
                    end

                    table.remove(typedLetters, #typedLetters)

                    local containsPierce = false

                    for _, l in ipairs(typedLetters) do if l.type == "pierce" then containsPierce = true break end end
                    if containsPierce == false then for _, l in ipairs(typedLetters) do l.canPierce = false end end
                elseif key == 'return' then
                    wordFound = ValidateWord(word)
                    word = ''
                    wordValue = 0

                    if wordFound == true then
                        local lettersInWord = {}

                        for index, value in ipairs(typedLetters) do
                            -- Removes letter from chamber
                            for i, v in ipairs(chambers) do if value == v then
                                local lock = false
                                if v.locked == true then lock = true end
                                chambers[i] = Letter("nil")
                                chambers[i].locked = lock
                                break
                            end end

                            value.locked = false
                            value.x = 140
                            value.y = 675
                            value.xvel = 0
                            value.yvel = 0

                            wordValue = wordValue + value.value
                            table.insert(submittedLetters, value)
                            table.insert(lettersInWord, submittedLetters[#submittedLetters])
                        end

                        table.insert(gun.ammo, lettersInWord)

                        local fillCheck = 0

                        for i, v in ipairs(chambers) do if v.locked == true then fillCheck = fillCheck + 1 end end

                        --if fillCheck == #chamber then chamberCount = chamberCount + 1 end
                        if chamberCount ~= 7 then chamberCount = chamberCount + 1 end
                        fillChambers()
                    else resetChambers() end
                    
                    typedLetters = {}
                else
                    for index, value in ipairs(validLetters) do
                        if key == value then
                            word = word..tostring(key)

                            local chamberCheck = false

                            for i, v in ipairs(chambers) do
                                if v.letter == key and v.locked == false then
                                    chamberCheck = true
                                    v.x = inputX + 30 + #typedLetters * 20 * 2.25
                                    v.y = inputY + inputH / 2
                                    v.locked = true

                                    if v.type == "pierce" then for _, l in ipairs(typedLetters) do l.canPierce = true end end

                                    table.insert(typedLetters, v)
                                    break
                                end
                            end

                            if chamberCheck == false then table.insert(typedLetters, Letter(key, inputX + 30 + #typedLetters * 20 * 2.25, inputY + inputH / 2)) end
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
                if v.x < 0 or v.x > love.graphics.getWidth() or v.y < 0 or v.y > love.graphics.getHeight() then
                    if v.type ~= "pierce" then v.canPierce = false end
                    table.remove(submittedLetters, i)
                else v.update(dt) end
            end

            -- Collision Detection
            for i, v in ipairs(line.riders) do for index, letter in ipairs(submittedLetters) do
                    if DistanceBetween(v.x, v.y, letter.x, letter.y) <= v.radius + 15 then
                        local alreadyHitBy = false
                    
                        if letter.canPierce == false then table.remove(submittedLetters, index)
                        else
                            for _, l in ipairs(v.hitBy) do if l == letter then alreadyHitBy = true break end end
                            if alreadyHitBy == false then table.insert(v.hitBy, letter) end
                        end

                        if alreadyHitBy == false then v.health = v.health - letter.value end
                        break
                    end
                end

                if v.health <= 0 then table.remove(line.riders, i) gun.removeEnemy(v) end
            end

            for i, v in ipairs(line2.riders) do for index, letter in ipairs(submittedLetters) do
                    if DistanceBetween(v.x, v.y, letter.x, letter.y) <= v.radius + 15 then
                        local alreadyHitBy = false
                    
                        if letter.canPierce == false then table.remove(submittedLetters, index)
                        else
                            for _, l in ipairs(v.hitBy) do if l == letter then alreadyHitBy = true break end end
                            if alreadyHitBy == false then table.insert(v.hitBy, letter) end
                        end

                        if alreadyHitBy == false then v.health = v.health - letter.value end
                        break
                    end
                end

                if v.health <= 0 then table.remove(line2.riders, i) gun.removeEnemy(v) end
            end

            for i, v in ipairs(line3.riders) do for index, letter in ipairs(submittedLetters) do
                    if DistanceBetween(v.x, v.y, letter.x, letter.y) <= v.radius + 15 then
                        local alreadyHitBy = false
                    
                        if letter.canPierce == false then table.remove(submittedLetters, index)
                        else
                            for _, l in ipairs(v.hitBy) do if l == letter then alreadyHitBy = true break end end
                            if alreadyHitBy == false then table.insert(v.hitBy, letter) end
                        end

                        if alreadyHitBy == false then v.health = v.health - letter.value end
                        break
                    end
                end

                if v.health <= 0 then table.remove(line3.riders, i) gun.removeEnemy(v) end
            end
            
            wordText:set(word)
            wordFoundText:set("Word found: "..tostring(wordFound))
            wordValueText:set("Word value: "..tostring(wordValue))
        end


        -- Game State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_background, 0, 0, 0, 0.5, 0.5)
            love.graphics.draw(i_bench, 18, 580, 0, 0.5, 0.5)
            love.graphics.draw(i_inputAndChambers, 8, 603, 0, 0.5, 0.5)
            love.graphics.draw(i_icon, 960, 660, 0, 0.5, 0.5)

            --love.graphics.draw(wordText, 800 - wordText:getWidth() / 2, 130, 0)
    
            line.draw()
            line2.draw()
            line3.draw()

            for i, v in ipairs(typedLetters) do v.draw() end
            for i, v in ipairs(submittedLetters) do v.draw() end
            for i, v in ipairs(chambers) do v.draw() end

            gun.draw()
            love.graphics.setColor(0, 0, 0)
            love.graphics.draw(wordFoundText, 1000, 490, 0)
            love.graphics.draw(wordValueText, 1000, 510, 0)
            love.graphics.print("Enemies: "..tostring(#gun.enemies), 1000, 530)
            love.graphics.print("Gun Word Ammo: "..tostring(#gun.ammo), 1000, 550)
            love.graphics.print("Submitted Letters: "..tostring(#submittedLetters), 1000, 570)
            love.graphics.setColor(1, 1, 1)
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
        -- Pausing
        if canPause == true and love.keyboard.isDown('escape') == true then
            if pausePressed == false then
                if paused == false then paused = true
                elseif paused == true then paused = false end
                pausePressed = true
            end
        else pausePressed = false end

        if paused == false then gameState(dt) end
    end

    self.draw = function ()
        drawState()
    end

    return self
end