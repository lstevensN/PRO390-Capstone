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
    local started = false
    local unlocked = false

    local Fade

    --#region ASSETS
        -- START
        local i_start_background = love.graphics.newImage("game/assets/start UI.png") -- Image by pikisuperstar on Freepik
        local i_start_logo = love.graphics.newImage("game/assets/logo.png")
        local i_start_howToPlay = love.graphics.newImage("game/assets/how_to_play.png")

        local i_b_start_new = love.graphics.newImage("game/assets/start_selection_new.png")
        local i_b_start_newSelected = love.graphics.newImage("game/assets/start_selection_new_selected.png")
        local i_b_start_continue = love.graphics.newImage("game/assets/start_selection_continue.png")
        local i_b_start_continueSelected = love.graphics.newImage("game/assets/start_selection_continue_selected.png")
        local i_b_start_settings = love.graphics.newImage("game/assets/start_selection_settings.png")
        local i_b_start_settingsSelected = love.graphics.newImage("game/assets/start_selection_settings_selected.png")
        local i_b_start_quit = love.graphics.newImage("game/assets/start_selection_exit.png")
        local i_b_start_quitSelected = love.graphics.newImage("game/assets/start_selection_exit_selected.png")
        local i_b_start_info = love.graphics.newImage("game/assets/info.png")


        -- PROGRESS
        local i_progress_background = love.graphics.newImage("game/assets/progress UI.png")
        local i_progress_tooltip = love.graphics.newImage("game/assets/tooltip_bar.png")
        local i_progress_difficulty = love.graphics.newImage("game/assets/difficulty_selection.png")
        local i_progress_easy = love.graphics.newImage("game/assets/difficulty_easy.png")
        local i_progress_normal = love.graphics.newImage("game/assets/difficulty_normal.png")
        local i_progress_hard = love.graphics.newImage("game/assets/difficulty_hard.png")
        local i_progress_insane = love.graphics.newImage("game/assets/difficulty_insane.png")

        local i_b_progress_act1Front = love.graphics.newImage("game/assets/gear_act1.png")
        local i_b_progress_act1Back = love.graphics.newImage("game/assets/gear_act1_back.png")
        local i_b_progress_act1BackHovered = love.graphics.newImage("game/assets/gear_act1_back_hover.png")
        local i_b_progress_act2Front = love.graphics.newImage("game/assets/gear_act2.png")
        local i_b_progress_act2Back = love.graphics.newImage("game/assets/gear_act2_back.png")
        local i_b_progress_act2BackHovered = love.graphics.newImage("game/assets/gear_act2_back_hover.png")
        local i_b_progress_act3Front = love.graphics.newImage("game/assets/gear_act3.png")
        local i_b_progress_act3Back = love.graphics.newImage("game/assets/gear_act3_back.png")
        local i_b_progress_act3BackHovered = love.graphics.newImage("game/assets/gear_act3_back_hover.png")
        local i_b_progress_act4Front = love.graphics.newImage("game/assets/gear_act4.png")
        local i_b_progress_act4Back = love.graphics.newImage("game/assets/gear_act4_back.png")
        local i_b_progress_act4BackHovered = love.graphics.newImage("game/assets/gear_act4_back_hover.png")
        local i_b_progress_difficultyEasy = love.graphics.newImage("game/assets/difficulty_easy_selected.png")
        local i_b_progress_difficultyNormal = love.graphics.newImage("game/assets/difficulty_normal_selected.png")
        local i_b_progress_difficultyHard = love.graphics.newImage("game/assets/difficulty_hard_selected.png")
        local i_b_progress_difficultyInsane = love.graphics.newImage("game/assets/difficulty_insane_selected.png")

        local f_progress_titleFont = love.graphics.newFont("game/assets/fonts/mixolydian titling bd.otf", 36)
        local f_progress_descriptionFont = love.graphics.newFont("game/assets/fonts/NotoSerif-Regular.ttf", 28)
        
        local t_progress_titleText = love.graphics.newText(f_progress_titleFont)
        local t_progress_descriptionText = love.graphics.newText(f_progress_descriptionFont, "Hello")
        local t_progress_rewardText = love.graphics.newText(f_progress_descriptionFont, "Hello")

        local sfx_progress_difficulty = love.audio.newSource("game/audio/submit.wav", "static")


        -- PREP
        local i_prep_background = love.graphics.newImage("game/assets/transmute UI.png")
        local i_prep_glorbSelection = love.graphics.newImage("game/assets/glorb_selection.png")

        local i_b_prep_go = love.graphics.newImage("game/assets/go_button.png")
        local i_b_prep_goHovered = love.graphics.newImage("game/assets/go_button_pressed.png")
        local i_b_prep_transmute = love.graphics.newImage("game/assets/transmute_button.png")
        local i_b_prep_transmuteHovered = love.graphics.newImage("game/assets/transmute_button_pressed.png")

        local f_prep_countFont = love.graphics.newFont("game/assets/fonts/Irregularis-raa9.ttf", 35)
        local f_prep_previewFont = love.graphics.newFont("game/assets/fonts/WC_RoughTrad.ttf", 80)
        
        local t_prep_previewText = love.graphics.newText(f_prep_previewFont)
        local t_prep_previewDetails = love.graphics.newText(f_prep_countFont)
        local t_prep_boilerCount = love.graphics.newText(f_prep_countFont)

        local sfx_prep_bubbling = love.audio.newSource("game/audio/bubbling.wav", "stream")
        local sfx_prep_transmute = love.audio.newSource("game/audio/transmute_zap.wav", "stream")


        -- GAME
        local i_game_background = love.graphics.newImage("game/assets/beach.png")
        local i_game_inputAndChambers = love.graphics.newImage("game/assets/input_and_chambers_2.png")
        local i_game_bench = love.graphics.newImage("game/assets/bench_2.png")
        local i_game_icon = love.graphics.newImage("game/assets/icon.png")
        local i_game_sBox = love.graphics.newImage("game/assets/sandwich_box.png")

        local f_game_powerNum = love.graphics.newFont("game/assets/fonts/Manuale-Regular.ttf", 25)
        local f_game_powerBigNum = love.graphics.newFont("game/assets/fonts/Manuale-Bold.ttf", 65)

        local t_game_wordText = love.graphics.newText(love.graphics.getFont())
        local t_game_wordFoundText = love.graphics.newText(love.graphics.getFont())
        local t_game_wordValueText = love.graphics.newText(love.graphics.getFont())

        local sfx_game_click = love.audio.newSource("game/audio/typing.wav", "static")
        local sfx_game_clickUndo = love.audio.newSource("game/audio/typing2.wav", "static")
        local sfx_game_hit = love.audio.newSource("game/audio/splat.mp3", "static")
        local sfx_game_bigHit = love.audio.newSource("game/audio/big_hit.wav", "static")
        local sfx_game_ding = love.audio.newSource("game/audio/chamber.wav", "static")
        local sfx_game_wrong = love.audio.newSource("game/audio/wrong.wav", "static")


        -- RESULT
        local i_result_background = love.graphics.newImage("game/assets/results UI.png")

        local i_b_result_next = love.graphics.newImage("game/assets/next_button.png")
        local i_b_result_nextHovered = love.graphics.newImage("game/assets/next_button_hover.png")

        local f_result_infoBold = love.graphics.newFont("game/assets/fonts/Manuale-Bold.ttf", 50)
        local f_result_info = love.graphics.newFont("game/assets/fonts/Manuale-Regular.ttf", 50)
        local f_result_tipTitle = love.graphics.newFont("game/assets/fonts/Irregularis-raa9.ttf", 50)
        local f_result_tip = love.graphics.newFont("game/assets/fonts/Irregularis-raa9.ttf", 35)

        local t_result_timeTitle = love.graphics.newText(f_result_infoBold)
        local t_result_time = love.graphics.newText(f_result_info)
        local t_result_sandwichTitle = love.graphics.newText(f_result_infoBold)
        local t_result_sandwich = love.graphics.newText(f_result_info)
        local t_result_enemiesTitle = love.graphics.newText(f_result_infoBold)
        local t_result_enemies = love.graphics.newText(f_result_info)
        local t_result_bestWordTitle = love.graphics.newText(f_result_infoBold)
        local t_result_bestWord = love.graphics.newText(f_result_info)
        local t_result_tipTitle = love.graphics.newText(f_result_tipTitle)
        local t_result_tip = love.graphics.newText(f_result_tip)


        -- ALL
        local i_b_back = love.graphics.newImage("game/assets/back_button.png")
        local i_b_backHovered = love.graphics.newImage("game/assets/back_button.png")

        local sfx_confirm = love.audio.newSource("game/audio/confirm.wav", "static") sfx_confirm:setVolume(0.8 * SfxVolume * MainVolume)
        local bgm_menu = love.audio.newSource("game/audio/Menu_Music.wav", "stream") bgm_menu:setVolume(MusicVolume * MainVolume)
    --#endregion

    -- START state
    start = function ()
        -- Initialize Start State
        canPause = false
        math.randomseed(os.time())

        local showTutorial = false

        local startImage = (started == true and i_b_start_continue or i_b_start_new)
        local startSelectedImage = (started == true and i_b_start_continueSelected or i_b_start_newSelected)

        local buttonStart = Button(340, 225, 620, 200, function () if sfx_confirm:isPlaying() then sfx_confirm:stop() end sfx_confirm:play() started = true Fade.start(function () gameState = progress end) end, startImage, startSelectedImage)
        local buttonSettings = Button(340, 450, 620, 200, function () end, i_b_start_settings, i_b_start_settingsSelected)
        local buttonQuit = Button(340, 675, 620, 200, function () if sfx_confirm:isPlaying() then sfx_confirm:stop() end sfx_confirm:play() Fade.start(function () love.event.quit() end) end, i_b_start_quit, i_b_start_quitSelected)  -- DON'T FORGET TO ADD SAVING
        local buttonInfo = Button(1100, 800, 50, 50, function () showTutorial = true end, i_b_start_info)

        buttonStart.selected = true

        if Deck == nil then
            Deck = {
                Letter('a', -100, -100, "iron"),
                Letter('e', -100, -100, "iron"),
                Letter('i', -100, -100, "iron"),
                Letter('r', -100, -100, "iron"),
                Letter('s', -100, -100, "iron"),

                Letter('d', -100, -100, "iron"),
                Letter('g', -100, -100, "iron"),
                Letter('l', -100, -100, "iron"),
                Letter('n', -100, -100, "iron"),
                Letter('o', -100, -100, "iron"),
                Letter('t', -100, -100, "iron"),

                Letter('b', -100, -100, "iron"),
                Letter('c', -100, -100, "iron"),
                Letter('h', -100, -100, "iron"),
                Letter('m', -100, -100, "iron"),
                Letter('p', -100, -100, "iron"),
                Letter('u', -100, -100, "iron"),

                Letter('j', -100, -100, "iron"),
                Letter('q', -100, -100, "iron"),
                Letter('x', -100, -100, "iron"),
                Letter('z', -100, -100, "iron")
            }
        end
        if Storage == nil then Storage = { Letter('?', -100, -100, "glorb"), Letter('?', -100, -100, "glorb"), Letter('?', -100, -100, "glorb") } end


        -- Start State Loop
        gameState = function (dt)
            if GetKeyPressed() == "escape" then showTutorial = false ResetKeyPressed() end

            buttonStart.update(dt)
            buttonSettings.update(dt)
            buttonQuit.update(dt)

            buttonInfo.update(dt)

            local x, y = love.mouse.getPosition()
            x = (x - XOffset) / ScaleFactor
            y = y / ScaleFactor

            if (x >= buttonStart.x - buttonStart.width / 2 and x <= buttonStart.x - buttonStart.width / 2 + buttonStart.width) and
            (y >= buttonStart.y - buttonStart.height / 2 and y <= buttonStart.y - buttonStart.height / 2 + buttonStart.height) then
                buttonStart.selected = true
                buttonSettings.selected = false
                buttonQuit.selected = false
            elseif (x >= buttonSettings.x - buttonSettings.width / 2 and x <= buttonSettings.x - buttonSettings.width / 2 + buttonSettings.width) and
            (y >= buttonSettings.y - buttonSettings.height / 2 and y <= buttonSettings.y - buttonSettings.height / 2 + buttonSettings.height) then
                buttonStart.selected = false
                buttonSettings.selected = true
                buttonQuit.selected = false
            elseif (x >= buttonQuit.x - buttonQuit.width / 2 and x <= buttonQuit.x - buttonQuit.width / 2 + buttonQuit.width) and
            (y >= buttonQuit.y - buttonQuit.height / 2 and y <= buttonQuit.y - buttonQuit.height / 2 + buttonQuit.height) then
                buttonStart.selected = false
                buttonSettings.selected = false
                buttonQuit.selected = true
            end

            if not bgm_menu:isPlaying() then bgm_menu:play() end
        end


        -- Start State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_start_background, 0, 0, 0, 0.5, 0.5)

            love.graphics.setColor(216/255, 190/255, 103/255)
            love.graphics.circle("fill", 900, 400, 200)
            love.graphics.setColor(155/255, 125/255, 65/255)
            love.graphics.setLineWidth(10)
            love.graphics.circle("line", 900, 400, 200)
            --love.graphics.draw(i_game_icon, 680, 180, 0, 1.25)
            love.graphics.setColor(1, 1, 1)
            love.graphics.setLineWidth(1)
            love.graphics.draw(i_start_logo, 735, 235, 0, 0.5, 0.5)

            buttonStart.draw()
            buttonSettings.draw()
            buttonQuit.draw()

            buttonInfo.draw()

            if showTutorial == true then love.graphics.draw(i_start_howToPlay, 350, 50, 0, 0.5) end
        end
    end

    -- PROGRESS state
    progress = function ()
        -- Initialize Progress State
        canPause = false

        sfx_progress_difficulty:setVolume(SfxVolume * MainVolume)

        local buttonAct1 = ButtonGear(150, 350, 100, function () if sfx_confirm:isPlaying() then sfx_confirm:stop() end sfx_confirm:play() Fade.start(function () gameState = prep end) end, i_b_progress_act1Front, i_b_progress_act1Back, i_b_progress_act1BackHovered)
        local buttonAct2 = ButtonGear(450, 350, 100, function () if sfx_confirm:isPlaying() then sfx_confirm:stop() end sfx_confirm:play() Fade.start(function () gameState = prep end) end, i_b_progress_act2Front, i_b_progress_act2Back, i_b_progress_act2BackHovered)
        local buttonAct3 = ButtonGear(750, 350, 100, function () if sfx_confirm:isPlaying() then sfx_confirm:stop() end sfx_confirm:play() Fade.start(function () gameState = prep end) end, i_b_progress_act3Front, i_b_progress_act3Back, i_b_progress_act3BackHovered)
        local buttonAct4 = ButtonGear(1050, 350, 142, function () if sfx_confirm:isPlaying() then sfx_confirm:stop() end sfx_confirm:play() Fade.start(function () gameState = prep end) end, i_b_progress_act4Front, i_b_progress_act4Back, i_b_progress_act4BackHovered)

        local buttonDifficultyEasy = Button(378, 632, 140, 50, function () if sfx_progress_difficulty:isPlaying() then sfx_progress_difficulty:stop() end sfx_progress_difficulty:play() Difficulty = 1 end, i_b_progress_difficultyEasy)
        local buttonDifficultyNormal = Button(526, 632, 140, 50, function () if sfx_progress_difficulty:isPlaying() then sfx_progress_difficulty:stop() end sfx_progress_difficulty:play() Difficulty = 2 end, i_b_progress_difficultyNormal)
        local buttonDifficultyHard = Button(676, 632, 140, 50, function () if sfx_progress_difficulty:isPlaying() then sfx_progress_difficulty:stop() end sfx_progress_difficulty:play() Difficulty = 3 end, i_b_progress_difficultyHard)
        local buttonDifficultyInsane = Button(824, 632, 140, 50, function () if sfx_progress_difficulty:isPlaying() then sfx_progress_difficulty:stop() end sfx_progress_difficulty:play() Difficulty = 4 end, i_b_progress_difficultyInsane)

        if Act == 1 then buttonAct1.locked = false
        elseif Act == 2 then buttonAct2.locked = false
        elseif Act == 3 then buttonAct3.locked = false
        elseif Act == 4 then buttonAct4.locked = false end

        local hoveredAct = Act

        local backButton = Button(1150, 50, 70, 70, function () Fade.start(function () gameState = start end) end, i_b_back, i_b_backHovered)
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
            t_progress_titleText:set("[ACT "..tostring(hoveredAct).."]"..completeStatus)

            if hoveredAct == 1 then t_progress_descriptionText:set((Act >= hoveredAct) and "The Hunger" or "???")
            elseif hoveredAct == 2 then t_progress_descriptionText:set((Act >= hoveredAct) and "The Battle" or "???")
            elseif hoveredAct == 3 and Difficulty == 4 then t_progress_descriptionText:set((Act >= hoveredAct) and "The Showdown" or "???")
            elseif hoveredAct == 3 then t_progress_descriptionText:set((Act >= hoveredAct) and "The War" or "???")
            elseif hoveredAct == 4 and Difficulty == 4 and unlocked == true then t_progress_descriptionText:set((Act >= hoveredAct) and "The Party" or "???")
            elseif hoveredAct == 4 then t_progress_descriptionText:set((Act >= hoveredAct) and "The Showdown" or "???") end

            if Act == 4 and hoveredAct == 4 then t_progress_rewardText:set("REWARD: ???")
            elseif Difficulty == 1 and hoveredAct == 1 then t_progress_rewardText:set("REWARD: 1 GLORB")
            elseif Difficulty == 1 then t_progress_rewardText:set((Act >= hoveredAct) and "REWARD: "..tostring(1 * hoveredAct).." GLORBS" or "???")
            elseif Difficulty == 2 then t_progress_rewardText:set((Act >= hoveredAct) and "REWARD: "..tostring(2 * hoveredAct).." GLORBS" or "???")
            elseif Difficulty == 3 then t_progress_rewardText:set((Act >= hoveredAct) and "REWARD: "..tostring(3 * hoveredAct).." GLORBS" or "???")
            elseif Difficulty == 4 then t_progress_rewardText:set((Act >= hoveredAct) and "REWARD: "..tostring(4 * hoveredAct).." GLORBS" or "???") end

            backButton.update(dt)

            if not bgm_menu:isPlaying() then bgm_menu:play() end
        end


        -- Progress State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_progress_background, 0, 0, 0, 0.5, 0.5)

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

            love.graphics.draw(i_progress_difficulty, 300, 600, 0, 0.5, 0.5)
            love.graphics.setColor(0.5, 0.5, 0.5)
            love.graphics.draw(i_progress_easy, 308, 607, 0, 0.25, 0.25)
            love.graphics.draw(i_progress_normal, 456, 607, 0, 0.25, 0.25)
            love.graphics.draw(i_progress_hard, 606, 607, 0, 0.25, 0.25)
            love.graphics.draw(i_progress_insane, 754, 607, 0, 0.25, 0.25)
            love.graphics.setColor(1, 1, 1)

            if Difficulty == 1 then buttonDifficultyEasy.draw()
            elseif Difficulty == 2 then buttonDifficultyNormal.draw()
            elseif Difficulty == 3 then buttonDifficultyHard.draw()
            elseif Difficulty == 4 then buttonDifficultyInsane.draw() end

            love.graphics.draw(i_progress_tooltip, 0, 720, 0, 0.5, 0.5)
            love.graphics.setColor(0, 0, 0)
            love.graphics.draw(t_progress_titleText, 50, 726, 0)
            love.graphics.draw(t_progress_rewardText, 1180 - t_progress_rewardText:getWidth(), 728, 0)
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(t_progress_descriptionText, 50, 790, 0)

            backButton.draw()
        end
    end

    -- PREP state
    prep = function ()
        -- Initialize Prep State
        canPause = false
        pauseDrawState = function () love.graphics.rectangle("fill", 450, 200, 300, 400) end

        sfx_prep_bubbling:setVolume(0.9 * SfxVolume * MainVolume)
        sfx_prep_transmute:setVolume(0.7 * SfxVolume * MainVolume)
        
        local previewColorWhite = false
        local preview = nil

        local backButton = Button(1150, 50, 70, 70, function () Fade.start(function () gameState = progress end) end, i_b_back, i_b_backHovered)

        local goButton = Button(950, 770, 280, 170, function () if sfx_confirm:isPlaying() then sfx_confirm:stop() end sfx_confirm:play() Fade.start(function () gameState = game end, bgm_menu) end, i_b_prep_go, i_b_prep_goHovered)
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
                    if letterType == "iron" then opType1 = "pierce" opType2 = "jade"
                    elseif letterType == "pierce" then opType1 = "jade" opType2 = "iron"
                    elseif letterType == "jade" then opType1 = "iron" opType2 = "pierce"
                    end

                    glorbSelection = {}
                    table.insert(glorbSelection, Letter(transmutationQueue[1].letter, glorbingX + 100, glorbingY + 45, opType1, true))
                    table.insert(glorbSelection, Letter(transmutationQueue[1].letter, glorbingX + 200, glorbingY + 45, opType2, true))
                end
            elseif #transmutationQueue == 2 then
                local value1, value2 = transmutationQueue[1].value, transmutationQueue[2].value
                local type1, type2 = transmutationQueue[1].type, transmutationQueue[2].type

                -- iron combining
                if value1 == 5 and value2 == 5 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier2Letter
                elseif value1 == 10 and value2 == 10 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier3Letter
                elseif value1 == 15 and value2 == 15 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier4Letter
                elseif value1 == 20 and value2 == 20 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier5Letter
                elseif value1 == 25 and value2 == 25 and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier1Letter letterType = "jade"
                elseif ((value1 == 25 and value2 == 5) or (value1 == 5 and value2 == 25)) and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier1Letter letterType = "pierce"
                elseif ((value1 == 25 and value2 == 10) or (value1 == 10 and value2 == 25)) and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier2Letter letterType = "pierce"
                elseif ((value1 == 25 and value2 == 15) or (value1 == 15 and value2 == 25)) and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier3Letter letterType = "pierce"
                elseif ((value1 == 25 and value2 == 20) or (value1 == 20 and value2 == 25)) and type1 == "iron" and type2 == "iron" then valid = true letterFunction = randomTier4Letter letterType = "pierce"
                -- pierce combining
                elseif value1 == 4 and value2 == 4 and type1 == "pierce" and type2 == "pierce" then valid = true letterFunction = randomTier5Letter letterType = "pierce"
                -- jade combining
                elseif value1 == 1 and value2 == 1 and type1 == "jade" and type2 == "jade" then valid = true letterFunction = randomTier2Letter letterType = "jade"
                elseif value1 == 2 and value2 == 2 and type1 == "jade" and type2 == "jade" then valid = true letterFunction = randomTier3Letter letterType = "jade"
                elseif value1 == 3 and value2 == 3 and type1 == "jade" and type2 == "jade" then valid = true letterFunction = randomTier4Letter letterType = "jade"
                elseif value1 == 4 and value2 == 4 and type1 == "jade" and type2 == "jade" then valid = true letterFunction = randomTier5Letter letterType = "jade"
                end

                if valid == true then
                    for i, v in ipairs(Deck) do if v == transmutationQueue[1] then table.remove(Deck, i) end end
                    for i, v in ipairs(Deck) do if v == transmutationQueue[2] then table.remove(Deck, i) end end
                    table.insert(Deck, letterFunction(letterType))
                    transmutationQueue = {}
                    table.sort(Deck, sortDeck)

                    if sfx_prep_transmute:isPlaying() then sfx_prep_transmute:stop() end sfx_prep_transmute:play()
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
                -- jade splitting
                elseif value == 5 and type == "jade" then valid = true letterFunction = randomTier4Letter letterFunction2 = randomTier4Letter letterType = "jade"
                elseif value == 4 and type == "jade" then valid = true letterFunction = randomTier3Letter letterFunction2 = randomTier3Letter letterType = "jade"
                elseif value == 3 and type == "jade" then valid = true letterFunction = randomTier2Letter letterFunction2 = randomTier2Letter letterType = "jade"
                elseif value == 2 and type == "jade" then valid = true letterFunction = randomTier1Letter letterFunction2 = randomTier1Letter letterType = "jade"
                elseif value == 1 and type == "jade" then valid = true letterFunction = randomTier5Letter letterFunction2 = randomTier5Letter
                end

                if valid == true then
                    for i, v in ipairs(Deck) do if v == transmutationQueue[1] then table.remove(Deck, i) end end
                    table.insert(Deck, letterFunction(letterType))
                    Deck[#Deck].x = Deck[#Deck].x - Deck[#Deck].radius * 2
                    table.insert(Deck, letterFunction2(letterType))
                    Deck[#Deck].x = Deck[#Deck].x + Deck[#Deck].radius * 2
                    transmutationQueue = {}
                    table.sort(Deck, sortDeck)

                    if sfx_prep_transmute:isPlaying() then sfx_prep_transmute:stop() end sfx_prep_transmute:play()
                end
            end
        end

        transmuteButton = Button(605, 450, 300, 100, transmute, i_b_prep_transmute, i_b_prep_transmuteHovered)

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

        if Deck[1].type == "pierce" or Deck[1].type == "jade" then previewColorWhite = true else previewColorWhite = false end
        t_prep_previewDetails:set("Type: "..string.upper(Deck[1].type).."\nPower: "..tostring(Deck[1].value))
        t_prep_previewText:set(string.upper(Deck[1].letter))
        if Deck[1].preview ~= nil then preview = Deck[1].preview end

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
                    t_prep_previewDetails:set("Type: "..string.upper(v.type).."\nPower: "..tostring(v.value))
                    t_prep_previewText:set(string.upper(v.letter))
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
                v.y - v.radius >= boilerY and v.y + v.radius <= boilerY + boilerH or
                (v.type ~= "glorb" and v.x - v.radius >= transmutationX and v.x + v.radius <= transmutationX + transmutationW and
                v.y - v.radius >= transmutationY and v.y + v.radius <= transmutationY + transmutationH) then
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
                    t_prep_previewDetails:set("Type: "..string.upper(v.type).."\nPower: "..tostring(v.value))
                    t_prep_previewText:set(string.upper(v.letter))
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
                            t_prep_previewDetails:set("Type: "..string.upper(v.type).."\nPower: "..tostring(v.value))
                            t_prep_previewText:set(string.upper(v.letter))
                            if v.preview ~= nil then preview = v.preview end
                        end
    
                        if v.clicked == true then
                            glorbing = false
                            v.x = 250
                            v.clicked = false
    
                            table.insert(Deck, v)
    
                            glorbHolder = {}
                            glorbSelection = {}

                            if sfx_prep_transmute:isPlaying() then sfx_prep_transmute:stop() end sfx_prep_transmute:play()
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

                            if sfx_prep_transmute:isPlaying() then sfx_prep_transmute:stop() end sfx_prep_transmute:play()
                            break
                        end
                    end

                    if hoveredLetter ~= nil then
                        if hoveredLetter.type == "pierce" or hoveredLetter.type == "jade" then previewColorWhite = true else previewColorWhite = false end
                        t_prep_previewDetails:set("Type: "..string.upper(hoveredLetter.type).."\nPower: "..tostring(hoveredLetter.value))
                        t_prep_previewText:set(string.upper(hoveredLetter.letter))
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
                        t_prep_previewDetails:set("Type: "..string.upper(glorbHolder[1].type).."\nPower: "..tostring(glorbHolder[1].value))
                        t_prep_previewText:set(glorbHolder[1].letter)
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

            t_prep_boilerCount:set("Letters: "..tostring(#Deck))

            if not bgm_menu:isPlaying() then bgm_menu:play() end
        end


        -- Prep State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_prep_background, 0, 0, 0, 0.5, 0.5)

            backButton.draw()
            goButton.draw()
            transmuteButton.draw()

            for i, v in ipairs(Deck) do v.draw() end
            for i, v in ipairs(Storage) do v.draw() end
            for i, v in ipairs(glorbHolder) do v.draw() end

            if #Deck == 15 then love.graphics.setColor(1, 0, 0) end
            love.graphics.draw(t_prep_boilerCount, 237 - t_prep_boilerCount:getWidth() / 2, 857, 0)
            love.graphics.setColor(1, 1, 1)

            if preview ~= nil then love.graphics.draw(preview, 830, 175, 0, 0.25, 0.25) end
            love.graphics.setColor(0, 0, 0)
            love.graphics.draw(t_prep_previewDetails, 975, 200, 0)
            if previewColorWhite == true then love.graphics.setColor(1, 1, 1) end
            love.graphics.draw(t_prep_previewText, 889 - t_prep_previewText:getWidth() / 2, 180, 0)
            love.graphics.setColor(1, 1, 1)

            if (glorbing == true and glorbTransmuting == false) or glorbProcessing == true then
                love.graphics.draw(i_prep_glorbSelection, glorbingX, glorbingY, 0, 0.5, 0.5)
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

        local recentX, recentY, recentW, recentH = 355, 620, 175, 130
        local chambersX, chambersY, chambersW, chambersH = 572, 650, 425, 80
        local inputX, inputY, inputW, inputH = 50, 770, 920, 80

        -- set Level based on Act/Difficulty
        local Level
        local magalaManager = nil
        if Act == 1 and Difficulty == 1 then Level = Act1_Easy()
        elseif Act == 1 and Difficulty == 2 then Level = Act1_Normal()
        elseif Act == 1 and Difficulty == 3 then Level = Act1_Hard()
        elseif Act == 1 and Difficulty == 4 then Level = Act1_Insane()
        elseif Act == 2 and Difficulty == 1 then Level = Act2_Easy()
        elseif Act == 2 and Difficulty == 2 then Level = Act2_Normal()
        elseif Act == 2 and Difficulty == 3 then Level = Act2_Hard()
        elseif Act == 2 and Difficulty == 4 then Level = Act2_Insane()
        elseif Act == 3 and Difficulty == 1 then Level = Act3_Easy()
        elseif Act == 3 and Difficulty == 2 then Level = Act3_Normal()
        elseif Act == 3 and Difficulty == 3 then Level = Act3_Hard()
        elseif Act == 3 and Difficulty == 4 then Level = Act3_Insane() magalaManager = {}
        elseif Act == 4 and Difficulty == 1 then Level = Act4_Easy() magalaManager = {}
        elseif Act == 4 and Difficulty == 2 then Level = Act4_Normal() magalaManager = {}
        elseif Act == 4 and Difficulty == 3 then Level = Act4_Hard() magalaManager = {}
        elseif Act == 4 and Difficulty == 4 and unlocked == true then Level = Act4_Party() magalaManager = {}
        elseif Act == 4 and Difficulty == 4 then Level = Act4_Insane() magalaManager = {}
        else Level = TestLevel() end

        if Level.music ~= nil then Level.music:play() end

        local gun = Gun(140, 680, "first")
        local fireTimer = cron.every(0.2, function (dt) gun.fire(dt) end)
        
        local line = Line(-100, 1300, 100, 1)
        local line2 = Line(-100, 1300, 265, 2)
        local line3 = Line(-100, 1050, 430, 3, true)

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
                if magalaManager ~= nil and enemy.type == "magala" then table.insert(magalaManager, enemy) end
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

        local VFX = {}

        sfx_game_click:setVolume(SfxVolume * MainVolume)
        sfx_game_click:setPitch(0.8)
        sfx_game_clickUndo:setVolume(SfxVolume * MainVolume)
        sfx_game_clickUndo:setPitch(0.8)
        sfx_game_hit:setVolume(0.7 * SfxVolume * MainVolume)
        sfx_game_hit:setPitch(0.8)
        sfx_game_bigHit:setVolume(SfxVolume * MainVolume)
        sfx_game_ding:setVolume(SfxVolume * MainVolume)
        sfx_game_wrong:setVolume(SfxVolume * MainVolume)


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
                    if containsPierce == false then for _, l in ipairs(typedLetters) do l.canPierce = false l.pierceCount = 1 end end

                    local containsJade = false
                    for _, l in ipairs(typedLetters) do if l.type == "jade" then containsJade = true break end end
                    if containsJade == false then for _, l in ipairs(typedLetters) do l.jadeMultiplier = 1 end end

                    if sfx_game_clickUndo:isPlaying() then sfx_game_clickUndo:stop() end sfx_game_clickUndo:play()
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

                            wordValue = wordValue + value.value * value.jadeMultiplier * value.pierceCount
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

                        if fillCheck == #chambers then
                            chamberCount = chamberCount + 1
                            if sfx_game_ding:isPlaying() then sfx_game_ding:stop() end sfx_game_ding:play()
                        end
                        fillChambers()
                    else if sfx_game_wrong:isPlaying() then sfx_game_wrong:stop() end sfx_game_wrong:play() resetChambers() end
                    
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

                                        if v.type == "pierce" then
                                            for _, l in ipairs(typedLetters) do
                                                l.canPierce = true
                                                if l.pierceCount < v.pierceCount then l.pierceCount = v.pierceCount end
                                                if l.pierceCount > v.pierceCount then v.pierceCount = l.pierceCount end
                                                if l.jadeMultiplier > v.jadeMultiplier then v.jadeMultiplier = l.jadeMultiplier end
                                            end
                                        end
                                        if v.type == "jade" then
                                            for _, l in ipairs(typedLetters) do
                                                if l.jadeMultiplier < v.jadeMultiplier then l.jadeMultiplier = v.jadeMultiplier end
                                                if l.pierceCount > v.pierceCount then v.pierceCount = l.pierceCount end
                                                if l.jadeMultiplier > v.jadeMultiplier then v.jadeMultiplier = l.jadeMultiplier end
                                            end
                                        end

                                        table.insert(typedLetters, v)
                                        break
                                    end
                                end

                                if chamberCheck == false then
                                    local newLetter = Letter(key, inputX + 30 + #typedLetters * 20 * 2.25, inputY + inputH / 2)
                                    for _, l in ipairs(typedLetters) do if l.type == "pierce" then newLetter.canPierce = true if l.pierceCount > newLetter.pierceCount then newLetter.pierceCount = l.pierceCount end end end
                                    for _, l in ipairs(typedLetters) do if l.type == "jade" then if l.jadeMultiplier > newLetter.jadeMultiplier then newLetter.jadeMultiplier = l.jadeMultiplier end end end
                                    table.insert(typedLetters, newLetter)
                                end

                                if sfx_game_click:isPlaying() then sfx_game_click:stop() end sfx_game_click:play()
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
            gun.update(dt)

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
                        local hitByCount = 0
                    
                        if letter.canPierce == false then table.remove(submittedLetters, index)
                        else
                            for _, l in ipairs(v.hitBy) do if l == letter then hitByCount = hitByCount + 1 end end
                            if hitByCount ~= letter.pierceCount then table.insert(v.hitBy, letter) end
                        end

                        if letter.canPierce == false or hitByCount ~= letter.pierceCount then
                            local power = letter.value * letter.jadeMultiplier
                            v.health = v.health - power
                            local font = (power >= 30 and f_game_powerBigNum or f_game_powerNum)
                            table.insert(VFX, DamageNumber(math.ceil(power), v.x, v.y, font))

                            if power > 30 then if sfx_game_bigHit:isPlaying() then sfx_game_bigHit:stop() end sfx_game_bigHit:play()
                            else if sfx_game_hit:isPlaying() then sfx_game_hit:stop() end sfx_game_hit:play() end
                        end
                        break
                    end
                end

                if v.sandwichHeld == nil then
                    for _, s in ipairs(Level.sandwiches) do
                        if s.stolen == false and math.abs(v.x - s.x) < 20 and v.y == s.y and v.sandwichHeld == nil then
                            s.stolen = true
                            v.sandwichHeld = s
                            if v.speed > 0 then v.speed = -v.speed end
                            break
                        end
                    end
                else v.sandwichHeld.x = v.x v.sandwichHeld.y = v.y end

                if v.health <= 0 then
                    if v.sandwichHeld ~= nil then v.sandwichHeld.stolen = false v.sandwichHeld = nil end
                    if v.type ~= "blank" and v.type ~= "empty" then gameResults.enemies = gameResults.enemies + 1 end
                    table.remove(line.riders, i)
                    gun.removeEnemy(v)
                end
            end

            for i, v in ipairs(line2.riders) do
                for index, letter in ipairs(submittedLetters) do
                    if DistanceBetween(v.x, v.y, letter.x, letter.y) <= v.radius + 15 then
                        local hitByCount = 0
                    
                        if letter.canPierce == false then table.remove(submittedLetters, index)
                        else
                            for _, l in ipairs(v.hitBy) do if l == letter then hitByCount = hitByCount + 1 end end
                            if hitByCount ~= letter.pierceCount then table.insert(v.hitBy, letter) end
                        end

                        if letter.canPierce == false or hitByCount ~= letter.pierceCount then
                            local power = letter.value * letter.jadeMultiplier
                            v.health = v.health - power
                            local font = (power >= 30 and f_game_powerBigNum or f_game_powerNum)
                            table.insert(VFX, DamageNumber(math.ceil(power), v.x, v.y, font))

                            if power > 30 then if sfx_game_bigHit:isPlaying() then sfx_game_bigHit:stop() end sfx_game_bigHit:play()
                            else if sfx_game_hit:isPlaying() then sfx_game_hit:stop() end sfx_game_hit:play() end
                        end
                        break
                    end
                end

                if v.sandwichHeld == nil then
                    for _, s in ipairs(Level.sandwiches) do
                        if s.stolen == false and math.abs(v.x - s.x) < 20 and v.y == s.y and v.sandwichHeld == nil then
                            s.stolen = true
                            v.sandwichHeld = s
                            if v.speed < 0 then v.speed = -v.speed end
                            break
                        end
                    end
                else v.sandwichHeld.x = v.x v.sandwichHeld.y = v.y end

                if v.health <= 0 then
                    if v.sandwichHeld ~= nil then v.sandwichHeld.stolen = false v.sandwichHeld = nil end
                    if v.type ~= "blank" and v.type ~= "empty" then gameResults.enemies = gameResults.enemies + 1 end
                    table.remove(line2.riders, i)
                    gun.removeEnemy(v)
                end
            end

            for i, v in ipairs(line3.riders) do
                for index, letter in ipairs(submittedLetters) do
                    if DistanceBetween(v.x, v.y, letter.x, letter.y) <= v.radius + 15 then
                        local hitByCount = 0
                    
                        if letter.canPierce == false then table.remove(submittedLetters, index)
                        else
                            for _, l in ipairs(v.hitBy) do if l == letter then hitByCount = hitByCount + 1 end end
                            if hitByCount ~= letter.pierceCount then table.insert(v.hitBy, letter) end
                        end

                        if letter.canPierce == false or hitByCount ~= letter.pierceCount then
                            local power = letter.value * letter.jadeMultiplier
                            v.health = v.health - power
                            local font = (power >= 30 and f_game_powerBigNum or f_game_powerNum)
                            table.insert(VFX, DamageNumber(math.ceil(power), v.x, v.y, font, 3))

                            if power > 30 then if sfx_game_bigHit:isPlaying() then sfx_game_bigHit:stop() end sfx_game_bigHit:play()
                            else if sfx_game_hit:isPlaying() then sfx_game_hit:stop() end sfx_game_hit:play() end
                        end
                        break
                    end
                end

                if v.sandwichHeld == nil then
                    for _, s in ipairs(Level.sandwiches) do
                        if s.stolen == false and math.abs(v.x - s.x) < 20 and v.y == s.y and v.sandwichHeld == nil then
                            s.stolen = true
                            v.sandwichHeld = s
                            if v.speed > 0 then v.speed = -v.speed end
                            break
                        end
                    end
                else v.sandwichHeld.x = v.x v.sandwichHeld.y = v.y end

                if v.health <= 0 then
                    if v.sandwichHeld ~= nil then v.sandwichHeld.stolen = false v.sandwichHeld = nil end
                    if v.type ~= "blank" and v.type ~= "empty" then gameResults.enemies = gameResults.enemies + 1 end
                    table.remove(line3.riders, i)
                    gun.removeEnemy(v)
                end
            end

            for i, v in ipairs(VFX) do v.update(dt) if v.gone == true then table.remove(VFX, i) end end
            
            t_game_wordText:set(word)
            t_game_wordFoundText:set("Word found: "..tostring(wordFound))
            t_game_wordValueText:set("Word value: "..tostring(wordValue))

            successfullyStolenSandwiches = 0
            for _, s in ipairs(Level.sandwiches) do if s.stolen == true and s.x < 0 and s.y < 200 then successfullyStolenSandwiches = successfullyStolenSandwiches + 1 end end
            
            if magalaManager ~= nil then
                for _, m in ipairs(magalaManager) do
                    if m.escaped == true then
                        m.escaped = false
                        m.sandwichHeld.x = -200
                        m.sandwichHeld = nil

                        line.addRider(m)
                        gun.addEnemy(m)
                    end
                end
            end

            -- Win Condition
            if done == false and Level.over == true and #gun.enemies == 1 then
                done = true
                Fade.start(function () gameState = result end, Level.music, bgm_menu)
            end

            -- Lose Condition
            if done == false and successfullyStolenSandwiches == #Level.sandwiches then
                done = true
                alive = false
                Fade.start(function () gameState = result end, Level.music, bgm_menu)
            end

            gameResults.stolenSandwiches = successfullyStolenSandwiches
            gameResults.time = gameResults.time + dt
        end


        -- Game State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_game_background, 0, 0, 0, 0.5, 0.5)
            love.graphics.draw(i_game_bench, 18, 580, 0, 0.5, 0.5)
            love.graphics.draw(i_game_inputAndChambers, 8, 603, 0, 0.5, 0.5)
            love.graphics.draw(i_game_icon, 960, 660, 0, 0.5, 0.5)
            love.graphics.draw(i_game_sBox, 963, 416, 0, 0.5, 0.5)
    
            line.draw()
            line2.draw()
            line3.draw()

            for i, v in ipairs(typedLetters) do
                v.draw()
                --[[
                love.graphics.setColor(0, 0, 0)
                local text = tostring(v.value * v.jadeMultiplier * v.pierceCount)
                love.graphics.print(text, 900, 200 + (i - 1) * 30)
                love.graphics.setColor(1, 1, 1)
                ]]
            end
            for i, v in ipairs(submittedLetters) do v.draw() end
            for i, v in ipairs(chambers) do v.draw() end

            gun.draw()

            for _, s in ipairs(Level.sandwiches) do s.draw() end

            for _, v in ipairs(VFX) do v.draw() end
        end
    end

    -- RESULT state
    result = function ()
        -- Initialize Result State
        canPause = false

        local timeFormat = "%i:%i"
        if math.fmod(gameResults.time, 60) < 10 then timeFormat = "%i:0%i" end

        t_result_timeTitle:set("Time:  ")
        t_result_time:set(string.format(timeFormat, gameResults.time / 60, math.fmod(gameResults.time, 60)))

        t_result_sandwichTitle:set("Sandwiches Lost:  ")
        t_result_sandwich:set(tostring(gameResults.stolenSandwiches).."/"..tostring(gameResults.totalSandwiches))
        t_result_enemiesTitle:set("Squids Repelled:  ")
        t_result_enemies:set(tostring(gameResults.enemies).."/"..tostring(gameResults.totalEnemies))
        t_result_bestWordTitle:set("Best Word:  ")
        t_result_bestWord:set("("..tostring(math.ceil(gameResults.bestValue))..")")

        if Act == 4 and alive == true then
            t_result_tipTitle:set("You Won!")
            t_result_tip:set("Thanks for playing this demo! (^v^)\nYou are awesome.\nSorry, it's a bit of a mess.\nDevelopment is still in progress.\nCongratulations on making it \nhere regardless!\nPlay again now if you want to \nkeep everything in your Storage \nfor next run.")
        else
            local w, tText = f_result_tip:getWrap(gameResults.tip[2], 375)
            local tipString = ""
            for i, v in ipairs(tText) do tipString = tipString..v.."\n" end
    
            t_result_tipTitle:set(string.upper(gameResults.tip[1]))
            t_result_tip:set(tipString)
        end

        for i, l in ipairs(gameResults.bestWord) do
            l.y =  515
            l.x = 100 + t_result_bestWordTitle:getWidth() - l.radius + l.radius * i * 2 + 5

            if l.canPierce == true then for _, v in ipairs(gameResults.bestWord) do v.canPierce = true end end
            if l.jadeMultiplier > 1 then for _, v in ipairs(gameResults.bestWord) do if l.jadeMultiplier > v.jadeMultiplier then v.jadeMultiplier = l.jadeMultiplier end end end
        end

        local nextFunc = function ()
            if alive == true then
                if Act ~= 4 then -- Normal Progression
                    Fade.start(function () gameState = progress end)

                    -- Put dropped Glorbs into Storage
                    local glorbReward = Act * Difficulty
                    for i = 1, glorbReward do
                        if #Storage ~= 25 then
                            table.insert(Storage, Letter("?", 0, 0, "glorb"))
                        else break end
                    end

                    if Act == 3 and Difficulty == 4 then unlocked = true end

                    Act = Act + 1
                else -- Big Win
                    Fade.start(function () gameState = start end)
                    Act = 1
                    Difficulty = 2
                    started = false
                    unlocked = false

                    Deck = nil
                end
            else -- Restart Game
                Fade.start(function () gameState = start end)
                alive = true
                Act = 1
                Difficulty = 2
                started = false
                unlocked = false

                Deck = nil
                Storage = nil

            end
            
            if sfx_confirm:isPlaying() then sfx_confirm:stop() end
        end

        local nextButton = Button(350, 700, 470, 175, nextFunc, i_b_result_next, i_b_result_nextHovered)


        -- Result State Loop
        gameState = function (dt)
            nextButton.update(dt)
        end


        -- Result State Draw Instructions
        drawState = function ()
            love.graphics.draw(i_result_background, 0, 0, 0, 0.5, 0.5)

            love.graphics.draw(t_result_tipTitle, 900 - t_result_tipTitle:getWidth() / 2, 100)
            love.graphics.draw(t_result_tip, 700, 155)
            love.graphics.draw(t_result_timeTitle, 100, 210, 0)
            love.graphics.draw(t_result_time, 100 + t_result_timeTitle:getWidth(), 210, 0)
            love.graphics.draw(t_result_sandwichTitle, 100, 300, 0)
            love.graphics.draw(t_result_sandwich, 100 + t_result_sandwichTitle:getWidth(), 300, 0)
            love.graphics.draw(t_result_enemiesTitle, 100, 390, 0)
            love.graphics.draw(t_result_enemies, 100 + t_result_enemiesTitle:getWidth(), 390, 0)

            if #gameResults.bestWord > 2 then
                love.graphics.draw(t_result_bestWordTitle, 100, 480, 0)
                for _, l in ipairs(gameResults.bestWord) do l.draw() end
                love.graphics.draw(t_result_bestWord, gameResults.bestWord[#gameResults.bestWord].x + gameResults.bestWord[#gameResults.bestWord].radius * 2, 480, 0)
            end

            nextButton.draw()
        end
    end

    self.load = function ()
        require("game.input")
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
        require("game.animation")

        require("game.vfx.numbers")

        require("game.levels.act1_easy")
        require("game.levels.act1_normal")
        require("game.levels.act1_hard")
        require("game.levels.act1_insane")
        require("game.levels.act2_easy")
        require("game.levels.act2_normal")
        require("game.levels.act2_hard")
        require("game.levels.act2_insane")
        require("game.levels.act3_easy")
        require("game.levels.act3_normal")
        require("game.levels.act3_hard")
        require("game.levels.act3_insane")
        require("game.levels.act4_easy")
        require("game.levels.act4_normal")
        require("game.levels.act4_hard")
        require("game.levels.act4_insane")
        require("game.levels.act4_party")
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