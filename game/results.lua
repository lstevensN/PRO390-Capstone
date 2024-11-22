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
        local num = 2 -- math.random(1, 3)

        -- 175 character limit
        if num == 1 then
            title = "Iron Letters"
            tip = "Primary squid deterrent.\n\nAEIRS - 5 power\nDGLONT - 10 power\nBCHMPU - 15 power\nFKVWY - 20 power\nJQXZ - 25 power"
        elseif num == 2 then
            title = "Pierce Letters"
            tip = "Enables powerful multi-hits.\n\nAEIRS - Hits multiple squids\nDGLONT - Hits squids 2x\nBCHMPU - Hits squids 3x\nFKVWY - Hits squids 4x\nJQXZ - Hits squids 5x"
        elseif num == 3 then
            title = "Jade Letters"
            tip = "Boosts word power.\n\nAEIRS - 1.2x multiplier\nDGLONT - 1.4x multiplier\nBCHMPU - 1.6x multiplier\nFKVWY - 1.8x multiplier\nJQXZ - 2.0x multiplier"
        end

        return {title, tip}
    end

    self.tip = generateTip()

    return self
end