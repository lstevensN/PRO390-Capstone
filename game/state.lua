-- Handles overall game state
function GameState()
    local self = {}
    local gameState = function (dt) end
    local drawState = function () end
    local pauseState, pauseDrawState = function () end, function () end
    local start, game, prep, progress, result
    local cron
    local Deck
    local Storage
    local paused, canPause, pausePressed = false, false, false
    local Act, Difficulty = 1, 2
    local alive = true
    local gameResults

    local Fade

    -- START state
    start = function ()
        -- Initialize Start State
        canPause = false
        math.randomseed(os.time())

        local buttonStart = Button(290, 280, 300, 100, function () Fade.start(function () gameState = progress end) end)
        local buttonSettings = Button(290, 480, 300, 100, function () end)
        local buttonQuit = Button(290, 680, 300, 100, function () love.event.quit() end)  -- DON'T FORGET TO ADD SAVING

        Deck = {
            Letter('a', -100, -100, "pierce"),
            Letter('b', -100, -100, "pierce"),
            Letter('c', -100, -100, "iron"),
            Letter('d', -100, -100, "iron"),
            Letter('e', -100, -100, "iron"),
            Letter('f', -100, -100, "iron"),
            Letter('a', -100, -100, "iron"),
            Letter('g', -100, -100, "iron"),
            Letter('h', -100, -100, "jade"),
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
            Letter('r', -100, -100, "jade"),
            Letter('s', -100, -100, "jade"),
            Letter('t', -100, -100, "iron"),
            Letter('?', -100, -100, "glorb"),
            Letter('?', -100, -100, "glorb")
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
        canPause = false

        local i_background = love.graphics.newImage("game/assets/progress UI.png")
        local i_tooltip = love.graphics.newImage("game/assets/tooltip_bar.png")
        local i_difficulty = love.graphics.newImage("game/assets/difficulty_selection.png")
        local i_easy = love.graphics.newImage("game/assets/difficulty_easy.png")
        local i_normal = love.graphics.newImage("game/assets/difficulty_normal.png")
        local i_hard = love.graphics.newImage("game/assets/difficulty_hard.png")
        local i_insane = love.graphics.newImage("game/assets/difficulty_insane.png")

        local buttonAct1 = ButtonGear(150, 350, 100, function () Fade.start(function () gameState = prep end) end, "game/assets/gear_act1.png", "game/assets/gear_act1_back.png", "game/assets/gear_act1_back_hover.png")
        local buttonAct2 = ButtonGear(450, 350, 100, function () Fade.start(function () gameState = prep end) end, "game/assets/gear_act2.png", "game/assets/gear_act2_back.png", "game/assets/gear_act2_back_hover.png")
        local buttonAct3 = ButtonGear(750, 350, 100, function () Fade.start(function () gameState = prep end) end, "game/assets/gear_act3.png", "game/assets/gear_act3_back.png", "game/assets/gear_act3_back_hover.png")
        local buttonAct4 = ButtonGear(1050, 350, 142, function () Fade.start(function () gameState = prep end) end, "game/assets/gear_act4.png", "game/assets/gear_act4_back.png", "game/assets/gear_act4_back_hover.png")

        local buttonDifficultyEasy = Button(378, 632, 140, 50, function () Difficulty = 1 end, "game/assets/difficulty_easy_selected.png")
        local buttonDifficultyNormal = Button(526, 632, 140, 50, function () Difficulty = 2 end, "game/assets/difficulty_normal_selected.png")
        local buttonDifficultyHard = Button(676, 632, 140, 50, function () Difficulty = 3 end, "game/assets/difficulty_hard_selected.png")
        local buttonDifficultyInsane = Button(824, 632, 140, 50, function () Difficulty = 4 end, "game/assets/difficulty_insane_selected.png")

        if Act == 1 then buttonAct1.locked = false
        elseif Act == 2 then buttonAct2.locked = false
        elseif Act == 3 then buttonAct3.locked = false
        elseif Act == 4 then buttonAct4.locked = false end

        local titleFont = love.graphics.newFont("game/assets/fonts/mixolydian titling bd.otf", 36)
        local titleText = love.graphics.newText(titleFont)
        local descriptionFont = love.graphics.newFont("game/assets/fonts/NotoSerif-Regular.ttf", 28)
        local descriptionText = love.graphics.newText(descriptionFont, "Hello")
        local rewardText = love.graphics.newText(descriptionFont, "Hello")

        local hoveredAct = Act

        local back = false


        -- Progress State Loop
        gameState = function (dt)
            if back == false and love.keyboard.isDown('escape') == true then back = true Fade.start(function () gameState = start end) end

            buttonAct1.update(dt)
            buttonAct2.update(dt)
            buttonAct3.update(dt)
            buttonAct4.update(dt)

            buttonDifficultyEasy.update(dt)
            buttonDifficultyNormal.update(dt)
            buttonDifficultyHard.update(dt)
            buttonDifficultyInsane.update(dt)
            
            if buttonAct1.hoveredOver == true then hoveredAct = 1
            elseif buttonAct2.hoveredOver == true then hoveredAct = 2
            elseif buttonAct3.hoveredOver == true then hoveredAct = 3
            elseif buttonAct4.hoveredOver == true then hoveredAct = 4 end

            local completeStatus = (Act > hoveredAct) and " - COMPLETED!" or ""
            titleText:set("[ACT "..tostring(hoveredAct).."]"..completeStatus)

            if hoveredAct == 1 then descriptionText:set((Act >= hoveredAct) and "The Hunger" or "???")
            elseif hoveredAct == 2 then descriptionText:set((Act >= hoveredAct) and "The Battle" or "???")
            elseif hoveredAct == 3 then descriptionText:set((Act >= hoveredAct) and "The Showdown" or "???")
            elseif hoveredAct == 4 then descriptionText:set((Act >= hoveredAct) and "The Party" or "???") end

            if Act == 4 and hoveredAct == 4 then rewardText:set("REWARD: ???")
            elseif Difficulty == 1 and hoveredAct == 1 then rewardText:set("REWARD: 1 GLORB")
            elseif Difficulty == 1 then rewardText:set((Act >= hoveredAct) and "REWARD: "..tostring(1 * hoveredAct).." GLORBS" or "???")
            elseif Difficulty == 2 then rewardText:set((Act >= hoveredAct) and "REWARD: "..tostring(2 * hoveredAct).." GLORBS" or "???")
            elseif Difficulty == 3 then rewardText:set((Act >= hoveredAct) and "REWARD: "..tostring(3 * hoveredAct).." GLORBS" or "???")
            elseif Difficulty == 4 then rewardText:set((Act >= hoveredAct) and "REWARD: "..tostring(4 * hoveredAct).." GLORBS" or "???") end
        end


        -- Progress State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_background, 0, 0, 0, 0.5, 0.5)

            if Act > 1 then love.graphics.setColor(0.5, 0.5, 0.5) end
            buttonAct1.draw()
            love.graphics.setColor(1, 1, 1)
            if Act < 2 or Act > 2 then love.graphics.setColor(0.5, 0.5, 0.5) end
            buttonAct2.draw()
            love.graphics.setColor(1, 1, 1)
            if Act < 3 or Act > 3 then love.graphics.setColor(0.5, 0.5, 0.5) end
            buttonAct3.draw()
            love.graphics.setColor(1, 1, 1)
            if Act < 4 then love.graphics.setColor(0.5, 0.5, 0.5) end
            buttonAct4.draw()
            love.graphics.setColor(1, 1, 1)

            love.graphics.draw(i_difficulty, 300, 600, 0, 0.5, 0.5)
            love.graphics.setColor(0.5, 0.5, 0.5)
            love.graphics.draw(i_easy, 308, 607, 0, 0.25, 0.25)
            love.graphics.draw(i_normal, 456, 607, 0, 0.25, 0.25)
            love.graphics.draw(i_hard, 606, 607, 0, 0.25, 0.25)
            love.graphics.draw(i_insane, 754, 607, 0, 0.25, 0.25)
            love.graphics.setColor(1, 1, 1)

            if Difficulty == 1 then buttonDifficultyEasy.draw()
            elseif Difficulty == 2 then buttonDifficultyNormal.draw()
            elseif Difficulty == 3 then buttonDifficultyHard.draw()
            elseif Difficulty == 4 then buttonDifficultyInsane.draw() end

            love.graphics.draw(i_tooltip, 0, 720, 0, 0.5, 0.5)
            love.graphics.setColor(0, 0, 0)
            love.graphics.draw(titleText, 50, 726, 0)
            love.graphics.draw(rewardText, 1180 - rewardText:getWidth(), 728, 0)
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(descriptionText, 50, 790, 0)
        end
    end

    -- PREP state
    prep = function ()
        -- Initialize Prep State
        canPause = false
        pauseDrawState = function () love.graphics.rectangle("fill", 450, 200, 300, 400) end

        local background = love.graphics.newImage("game/assets/transmute UI.png")
        
        local countFont = love.graphics.newFont("game/assets/fonts/Irregularis-raa9.ttf", 35)
        local boilerCount = love.graphics.newText(countFont)
        
        local previewFont = love.graphics.newFont("game/assets/fonts/WC_RoughTrad.ttf", 80)
        local previewText = love.graphics.newText(previewFont)
        local previewDetails = love.graphics.newText(countFont)
        local previewColorWhite = false
        local preview = nil

        local backButton = Button(1150, 50, 70, 70, function () Fade.start(function () gameState = progress end) end, "game/assets/back_button.png", "game/assets/back_button_hover.png")

        local goButton = Button(950, 770, 280, 170, function () Fade.start(function () gameState = game end) end, "game/assets/go_button.png", "game/assets/go_button_pressed.png")
        local transmuteButton

        local boilerX, boilerY, boilerW, boilerH = 52, 155, 371, 690
        local transmutationX, transmutationY, transmutationW, transmutationH = 475, 100, 250, 250
        local storageX, storageY, storageW, storageH = 465, 535, 280, 280

        local sortDeck = function (letter1, letter2) return letter1.value < letter2.value end

        local glorbHolder = {}
        local glorbSelection = {}
        local glorbing = false
        local glorbTransmuting = false
        local glorbProcessing = false
        local glorbingX, glorbingY = 0, 0
        local i_glorbSelection = love.graphics.newImage("game/assets/glorb_selection.png")
        
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

            if glorbTransmuting == true then
                if #transmutationQueue == 1 then
                    local opType1, opType2
                    glorbingX = 450
                    glorbingY = 300
                    glorbProcessing = true

                    letterType = transmutationQueue[1].type
                    if letterType == "iron" then opType1 = "pierce"
                    elseif letterType == "pierce" then opType1 = "iron"
                    end

                    glorbSelection = {}
                    table.insert(glorbSelection, Letter(transmutationQueue[1].letter, glorbingX + 100, glorbingY + 45, opType1, true))
                end
            elseif #transmutationQueue == 2 then
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
            v.xvel = 0
            v.yvel = 0
            v.locked = false

            v.x = math.random(boilerX, boilerX + boilerW)
            if v.value == 1 or (v.value == 5 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 - 10, boilerY + boilerH / 10 + 10)
            elseif v.value == 2 or (v.value == 10 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 * 3 - 10, boilerY + boilerH / 10 * 3 + 10)
            elseif v.value == 3 or (v.value == 15 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 * 5 - 10, boilerY + boilerH / 10 * 5 + 10)
            elseif v.value == 4 or (v.value == 20 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 * 7 - 10, boilerY + boilerH / 10 * 7 + 10)
            elseif v.value == 5 or (v.value == 25 and v.type == "iron") then v.y = math.random(boilerY + boilerH / 10 * 9 - 10, boilerY + boilerH / 10 * 9 + 10) end
        end

        table.sort(Deck, sortDeck)

        for i, v in ipairs(Storage) do v.transmuteMode = true end
        --table.sort(Storage, sortDeck)

        local back = false


        -- Prep State Loop
        gameState = function (dt)
            if glorbing == false and back == false and love.keyboard.isDown('escape') == true then
                back = true
                Fade.start(function () gameState = progress end)
            elseif glorbing == true and back == false and love.keyboard.isDown('escape') == true then
                back = true
                
                if glorbProcessing == true then
                    glorbProcessing = false
                    glorbSelection = {}
                else
                    glorbing = false
                    glorbTransmuting = false
                    glorbHolder[1].stored = true
                    glorbHolder[1].locked = false
                    table.insert(Storage, glorbHolder[1])

                    glorbSelection = {}
                    glorbHolder = {}
                end
            elseif love.keyboard.isDown('escape') == false then back = false end

            local selected = {}

            if glorbing == false then backButton.update(dt) goButton.update(dt) end
            if (glorbing == false or glorbTransmuting == true) and glorbProcessing == false then transmuteButton.update(dt) end

            for i, v in ipairs(Deck) do
                local withinTransmutationZone = false

                if #Deck > 15 then
                    if v.x - v.radius >= transmutationX and v.x + v.radius <= transmutationX + transmutationW and
                    v.y - v.radius >= transmutationY and v.y + v.radius <= transmutationY + transmutationH then withinTransmutationZone = true end

                    if glorbTransmuting == false and v.x - v.radius >= storageX - 15 and v.x + v.radius <= storageX + storageW + 15 and
                    v.y - v.radius >= storageY - 15 and v.y + v.radius <= storageY + storageH + 15 then v.stored = true end
                    
                    if withinTransmutationZone then
                        if #transmutationQueue < (glorbTransmuting and 1 or 2) and transmutationQueue[1] ~= v then v.locked = true table.insert(transmutationQueue, v) end
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

                if v.clicked == true and #selected == 0 and glorbProcessing == false then table.insert(selected, v) end
                if selected[1] ~= v or (glorbing == true and glorbTransmuting == false) then v.clicked = false end

                if v.stored == true and #Storage < 25 then table.insert(Storage, v) table.remove(Deck, i) else v.stored = false end

                -- set preview
                if v.hoveredOver == true or v.clicked == true then
                    if v.type == "pierce" or v.type == "jade" then previewColorWhite = true else previewColorWhite = false end
                    previewDetails:set("Type: "..string.upper(v.type).."\nDamage: "..tostring(v.value))
                    previewText:set(string.upper(v.letter))
                    if v.preview ~= nil then preview = v.preview end
                end
            end

            for i, v in ipairs(Storage) do
                v.x = storageX + 28 * (math.fmod(i - 1, 5)) * 2 + 28
                v.y = storageY + 28 * ((math.ceil(i / 5) - 1)) * 2 + 28

                v.update(dt)
                if glorbing == true then v.clicked = false end

                if v.clicked == true and #selected == 0 then table.insert(selected, v) end
                if selected[1] ~= v then v.clicked = false end

                if v.x - v.radius >= boilerX and v.x + v.radius <= boilerX + boilerW and
                v.y - v.radius >= boilerY and v.y + v.radius <= boilerY + boilerH then
                    v.stored = false
                    if v.type == "glorb" then table.insert(glorbHolder, v) else table.insert(Deck, v) end
                    table.remove(Storage, i)
                end

                if v.type == "glorb" and v.x - v.radius >= transmutationX and v.x + v.radius <= transmutationX + transmutationW and
                v.y - v.radius >= transmutationY and v.y + v.radius <= transmutationY + transmutationH then
                    --if #transmutationQueue == 1 then end
                    v.stored = false
                    v.locked = true
                    glorbTransmuting = true
                    table.insert(glorbHolder, v)
                    table.remove(Storage, i)
                end

                if v.hoveredOver == true or v.clicked == true then
                    if v.type == "pierce" or v.type == "jade" then previewColorWhite = true else previewColorWhite = false end
                    previewDetails:set("Type: "..string.upper(v.type).."\nDamage: "..tostring(v.value))
                    previewText:set(string.upper(v.letter))
                    if v.preview ~= nil then preview = v.preview end
                end
            end

            -- GLORBS
            if glorbing == true then
                if glorbTransmuting == false then
                    if #glorbSelection == 0 then
                        math.randomseed(os.time())

                        for i = 1, 5 do
                            local num = math.random(1, 100)
                            local sLetter

                            if num <= 75 then sLetter = randomTier1Letter()
                            elseif num <= 90 then sLetter = randomTier2Letter()
                            elseif num <= 95 then sLetter = randomTier3Letter()
                            elseif num <= 99 then sLetter = randomTier4Letter()
                            elseif num <= 100 then sLetter = randomTier5Letter() end

                            table.insert(glorbSelection, sLetter)
                        end

                        for i, v in ipairs(glorbSelection) do
                            v.transmuteMode = true
                            v.x = glorbingX + 40 + (i - 1) * 55
                            v.y = glorbingY + 45
                        end
                    end

                    for _, v in ipairs(glorbSelection) do
                        v.update(dt)

                        if v.hoveredOver == true then
                            previewColorWhite = false
                            previewDetails:set("Type: "..string.upper(v.type).."\nDamage: "..tostring(v.value))
                            previewText:set(string.upper(v.letter))
                            if v.preview ~= nil then preview = v.preview end
                        end
    
                        if v.clicked == true then
                            glorbing = false
                            v.x = 250
                            v.clicked = false
    
                            table.insert(Deck, v)
    
                            glorbHolder = {}
                            glorbSelection = {}
                            break
                        end
                    end
                elseif glorbProcessing == true then
                    local hoveredLetter = nil

                    glorbHolder[1].update(dt)
                    glorbHolder[1].clicked = false
                    transmutationQueue[1].update(dt)

                    if glorbHolder[1].hoveredOver == true then hoveredLetter = glorbHolder[1] end
                    if transmutationQueue[1].hoveredOver == true then hoveredLetter = transmutationQueue[1] end

                    for _, v in ipairs(glorbSelection) do
                        v.update(dt)

                        if v.hoveredOver == true then hoveredLetter = v end

                        if v.clicked == true then
                            glorbing = false
                            glorbTransmuting = false
                            glorbProcessing = false
                            v.x = 600
                            v.y = 225
                            v.clicked = false
    
                            for i, l in ipairs(Deck) do if l == transmutationQueue[1] then table.remove(Deck, i) end end
                            table.insert(Deck, v)
    
                            transmutationQueue = {}
                            glorbHolder = {}
                            glorbSelection = {}
                            break
                        end
                    end

                    if hoveredLetter ~= nil then
                        if hoveredLetter.type == "pierce" or v.type == "jade" then previewColorWhite = true else previewColorWhite = false end
                        previewDetails:set("Type: "..string.upper(hoveredLetter.type).."\nDamage: "..tostring(hoveredLetter.value))
                        previewText:set(string.upper(hoveredLetter.letter))
                        if hoveredLetter.preview ~= nil then preview = hoveredLetter.preview end
                    end
                elseif glorbTransmuting == true then
                    glorbHolder[1].update(dt)

                    if glorbHolder[1].clicked == true and #selected == 0 then table.insert(selected, glorbHolder[1]) end
                    if selected[1] ~= glorbHolder[1] then
                        glorbHolder[1].clicked = false
                        glorbHolder[1].x = transmutationX + transmutationW / 2
                        glorbHolder[1].y = transmutationY + transmutationH / 2
                    end

                    if glorbHolder[1].hoveredOver == true or glorbHolder[1].clicked == true then
                        previewDetails:set("Type: "..string.upper(glorbHolder[1].type).."\nDamage: "..tostring(glorbHolder[1].value))
                        previewText:set(glorbHolder[1].letter)
                        if glorbHolder[1].preview ~= nil then preview = glorbHolder[1].preview end
                    end

                    -- collision check 
                    for _, l in ipairs(transmutationQueue) do
                        if DistanceBetween(glorbHolder[1].x, glorbHolder[1].y, l.x, l.y) < glorbHolder[1].radius * 2 then
                            local bumpX = (l.x - glorbHolder[1].x) / glorbHolder[1].radius
                            local bumpY = (l.y - glorbHolder[1].y) / glorbHolder[1].radius
                            l.x = l.x + bumpX
                            l.y = l.y + bumpY
                            glorbHolder[1].x = glorbHolder[1].x - bumpX
                            glorbHolder[1].y = glorbHolder[1].y - bumpY
                        end
                    end

                    -- boiler check
                    if glorbHolder[1].x - glorbHolder[1].radius >= boilerX and glorbHolder[1].x + glorbHolder[1].radius <= boilerX + boilerW and
                    glorbHolder[1].y - glorbHolder[1].radius >= boilerY and glorbHolder[1].y + glorbHolder[1].radius <= boilerY + boilerH then
                        glorbTransmuting = false
                    end

                    -- storage check
                    if glorbHolder[1].x - glorbHolder[1].radius >= storageX - 15 and glorbHolder[1].x + glorbHolder[1].radius <= storageX + storageW + 15 and
                    glorbHolder[1].y - glorbHolder[1].radius >= storageY - 15 and glorbHolder[1].y + glorbHolder[1].radius <= storageY + storageH + 15 then
                        glorbing = false
                        glorbTransmuting = false
                        glorbHolder[1].stored = true
                        table.insert(Storage, glorbHolder[1])
                        table.remove(glorbHolder, 1)
                    end
                end
            end

            for i, v in ipairs(glorbHolder) do
                v.update(dt)

                if selected[1] ~= v then
                    v.clicked = false
                    glorbing = true
                else
                    glorbingX = v.x + v.radius + 10
                    glorbingY = v.y - v.radius * 2
                end
            end

            for i, v in ipairs(transmutationQueue) do if v.locked == false then table.remove(transmutationQueue, i) end end

            boilerCount:set("Letters: "..tostring(#Deck))
        end


        -- Prep State Draw Instructions
        drawState = function ()
            love.graphics.draw(background, 0, 0, 0, 0.5, 0.5)

            backButton.draw()
            goButton.draw()
            transmuteButton.draw()

            for i, v in ipairs(Deck) do v.draw() end
            for i, v in ipairs(Storage) do v.draw() end
            for i, v in ipairs(glorbHolder) do v.draw() end

            if #Deck == 15 then love.graphics.setColor(1, 0, 0) end
            love.graphics.draw(boilerCount, 237 - boilerCount:getWidth() / 2, 857, 0)
            love.graphics.setColor(1, 1, 1)

            if preview ~= nil then love.graphics.draw(preview, 830, 175, 0, 0.25, 0.25) end
            love.graphics.setColor(0, 0, 0)
            love.graphics.draw(previewDetails, 975, 200, 0)
            if previewColorWhite == true then love.graphics.setColor(1, 1, 1) end
            love.graphics.draw(previewText, 889 - previewText:getWidth() / 2, 180, 0)
            love.graphics.setColor(1, 1, 1)

            if (glorbing == true and glorbTransmuting == false) or glorbProcessing == true then
                love.graphics.draw(i_glorbSelection, glorbingX, glorbingY, 0, 0.5, 0.5)
                for i, v in ipairs(glorbSelection) do v.draw() end
            end

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

        -- set Level based on Act/Difficulty
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
                if enemy.type ~= "blank" and enemy.type ~= "empty" then gameResults.totalEnemies = gameResults.totalEnemies + 1 end
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

        local done = false
        local successfullyStolenSandwiches = 0

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

        gameResults = Results()
        gameResults.totalSandwiches = #Level.sandwiches


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
                    wordValue = 0

                    if wordFound == true and string.len(word) > 2 then
                        local lettersInWord = {}

                        for index, value in ipairs(typedLetters) do
                            -- Removes letter from chamber
                            for i, v in ipairs(chambers) do
                                if value == v then
                                    local lock = false
                                    if v.locked == true then lock = true end
                                    chambers[i] = Letter("nil")
                                    chambers[i].locked = lock
                                    break
                                end
                            end

                            value.locked = false
                            value.x = 140
                            value.y = 675
                            value.xvel = 0
                            value.yvel = 0

                            wordValue = wordValue + value.value
                            table.insert(submittedLetters, value)
                            table.insert(lettersInWord, submittedLetters[#submittedLetters])
                        end

                        if wordValue > gameResults.bestValue then
                            gameResults.bestWord = {}
                            gameResults.bestValue = wordValue

                            for _, l in ipairs(lettersInWord) do
                                local letter = Letter(l.letter, 0, 0, l.type)
                                table.insert(gameResults.bestWord, letter)
                            end
                        end

                        table.insert(gun.ammo, lettersInWord)

                        local fillCheck = 0

                        for i, v in ipairs(chambers) do if v.locked == true then fillCheck = fillCheck + 1 end end

                        if fillCheck == #chambers then chamberCount = chamberCount + 1 end
                        --if chamberCount ~= 7 then chamberCount = chamberCount + 1 end
                        fillChambers()
                    else resetChambers() end
                    
                    word = ''
                    typedLetters = {}
                else
                    if string.len(word) < 20 then
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

                                if chamberCheck == false then
                                    local newLetter = Letter(key, inputX + 30 + #typedLetters * 20 * 2.25, inputY + inputH / 2)
                                    for _, l in ipairs(typedLetters) do if l.type == "pierce" then newLetter.canPierce = true break end end
                                    table.insert(typedLetters, newLetter)
                                end
                                break
                            end
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

            -- Collision Detection (+ Sandwich Stealing)
            for i, v in ipairs(line.riders) do
                for index, letter in ipairs(submittedLetters) do
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

                if v.sandwichHeld == nil then
                    for _, s in ipairs(Level.sandwiches) do if s.stolen == false and math.abs(v.x - s.x) < 10 and v.y == s.y and v.sandwichHeld == nil then s.stolen = true v.sandwichHeld = s end end
                else v.sandwichHeld.x = v.x v.sandwichHeld.y = v.y end

                if v.health <= 0 then
                    if v.sandwichHeld ~= nil then v.sandwichHeld.stolen = false v.sandwichHeld = nil end
                    gameResults.enemies = gameResults.enemies + 1
                    table.remove(line.riders, i)
                    gun.removeEnemy(v)
                end
            end

            for i, v in ipairs(line2.riders) do
                for index, letter in ipairs(submittedLetters) do
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

                if v.sandwichHeld == nil then
                    for _, s in ipairs(Level.sandwiches) do if s.stolen == false and math.abs(v.x - s.x) < 10 and v.y == s.y and v.sandwichHeld == nil then s.stolen = true v.sandwichHeld = s end end
                else v.sandwichHeld.x = v.x v.sandwichHeld.y = v.y end

                if v.health <= 0 then
                    if v.sandwichHeld ~= nil then v.sandwichHeld.stolen = false v.sandwichHeld = nil end
                    gameResults.enemies = gameResults.enemies + 1
                    table.remove(line2.riders, i)
                    gun.removeEnemy(v)
                end
            end

            for i, v in ipairs(line3.riders) do
                for index, letter in ipairs(submittedLetters) do
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

                if v.sandwichHeld == nil then
                    for _, s in ipairs(Level.sandwiches) do if s.stolen == false and math.abs(v.x - s.x) < 10 and v.y == s.y and v.sandwichHeld == nil then s.stolen = true v.sandwichHeld = s end end
                else v.sandwichHeld.x = v.x v.sandwichHeld.y = v.y end

                if v.health <= 0 then
                    if v.sandwichHeld ~= nil then v.sandwichHeld.stolen = false v.sandwichHeld = nil end
                    gameResults.enemies = gameResults.enemies + 1
                    table.remove(line3.riders, i)
                    gun.removeEnemy(v)
                end
            end
            
            wordText:set(word)
            wordFoundText:set("Word found: "..tostring(wordFound))
            wordValueText:set("Word value: "..tostring(wordValue))

            successfullyStolenSandwiches = 0
            for _, s in ipairs(Level.sandwiches) do if s.stolen == true and s.x < 0 and s.y < 200 then successfullyStolenSandwiches = successfullyStolenSandwiches + 1 end end
            
            -- Win Condition
            if done == false and Level.over == true and #gun.enemies == 1 then
                done = true
                Fade.start(function () gameState = result end)
            end

            -- Lose Condition
            if done == false and successfullyStolenSandwiches == #Level.sandwiches then
                done = true
                alive = false
                Fade.start(function () gameState = result end)
            end

            gameResults.stolenSandwiches = successfullyStolenSandwiches
        end


        -- Game State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_background, 0, 0, 0, 0.5, 0.5)
            love.graphics.draw(i_bench, 18, 580, 0, 0.5, 0.5)
            love.graphics.draw(i_inputAndChambers, 8, 603, 0, 0.5, 0.5)
            love.graphics.draw(i_icon, 960, 660, 0, 0.5, 0.5)
    
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

            for _, s in ipairs(Level.sandwiches) do s.draw() end
        end
    end

    -- RESULT state
    result = function ()
        -- Initialize Result State
        canPause = false

        local i_background = love.graphics.newImage("game/assets/results UI.png")

        local nextFunc
        if alive == true then nextFunc = function ()
            if Act ~= 4 then
                Fade.start(function () gameState = progress end)

                -- Put dropped Glorbs into Storage
                local glorbReward = Act * Difficulty
                for i = 0, glorbReward do
                    if #Storage ~= 25 then
                        table.insert(Storage, Letter("?", 0, 0, "glorb"))
                    else break end
                end
                
                Act = Act + 1
            else gameState = start end  -- Big Win
        end
        else nextFunc = function () -- Restart Game
            Fade.start(function () gameState = start end)
            alive = true
            Act = 1
            Difficulty = 2
            -- Reset Deck/Storage
        end end

        local nextButton = Button(600, 700, 470, 175, nextFunc, "game/assets/next_button.png", "game/assets/next_button_hover.png")

        local resultBoldFont = love.graphics.newFont("game/assets/fonts/Manuale-Bold.ttf", 50)
        local resultFont = love.graphics.newFont("game/assets/fonts/Manuale-Regular.ttf", 50)

        local sandwichTitle = love.graphics.newText(resultBoldFont, "Sandwiches Lost:  ", 50)
        local sandwichText = love.graphics.newText(resultFont, tostring(gameResults.stolenSandwiches).."/"..tostring(gameResults.totalSandwiches))

        local enemiesTitle = love.graphics.newText(resultBoldFont, "Squids Repelled:  ")
        local enemiesText = love.graphics.newText(resultFont, tostring(gameResults.enemies).."/"..tostring(gameResults.totalEnemies))

        local bestWordTitle = love.graphics.newText(resultBoldFont, "Best Word:  ")
        local bestWordText = love.graphics.newText(resultFont, "("..tostring(gameResults.bestValue)..")")



        for i, l in ipairs(gameResults.bestWord) do
            l.y =  425
            l.x = 100 + bestWordTitle:getWidth() - l.radius + l.radius * i * 2 + 5
        end


        -- Result State Loop
        gameState = function (dt)
            nextButton.update(dt)
        end


        -- Result State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_background, 0, 0, 0, 0.5, 0.5)

            love.graphics.draw(sandwichTitle, 100, 210, 0)
            love.graphics.draw(sandwichText, 100 + sandwichTitle:getWidth(), 210, 0)

            love.graphics.draw(enemiesTitle, 100, 300, 0)
            love.graphics.draw(enemiesText, 100 + enemiesTitle:getWidth(), 300, 0)

            if #gameResults.bestWord > 2 then
                love.graphics.draw(bestWordTitle, 100, 390, 0)
                for _, l in ipairs(gameResults.bestWord) do l.draw() end
                love.graphics.draw(bestWordText, gameResults.bestWord[#gameResults.bestWord].x + gameResults.bestWord[#gameResults.bestWord].radius * 2, 390, 0)
            end

            nextButton.draw()
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
        require("game.fade")
        require("game.sandwich")
        require("game.results")

        require("game.levels.test_level")

        cron = require "cron"

        gameState = start

        Fade = Fader()
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

        Fade.update(dt)
    end

    self.draw = function ()
        drawState()

        Fade.draw()
    end

    return self
end