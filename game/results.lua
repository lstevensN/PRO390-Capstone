function Results()
    local self = {}
    self.time = 0
    self.wordsUsed = 0
    self.totalEnemies = 0
    self.enemies = 0
    self.bestWord = {}
    self.bestValue = 0
    self.totalSandwiches = 0
    self.stolenSandwiches = 0

    local generateTip = function ()
        local title, tip = "title", "tip"
        local num = math.random(1, 1)

        -- 175 character limit
        if num == 1 then
            title = "Tip"
            tip = "simple dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a piss"
        end

        return {title, tip}
    end

    self.tip = generateTip()

    return self
end