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
        local num = math.random(1, 3)

        -- 175 character limit
        if num == 1 then
            title = "Iron Letters"
            tip = "Primary squid deterrent.\n\nA E I R S - 5 power\nD G L O N T - 10 power\nB C H M P U - 15 power\nF K V W Y - 20 power\nJ Q X Z - 25 power"
        elseif num == 2 then
            title = "Pierce Letters"
            tip = "Enables powerful multi-hits.\n\nA E I R S - Hits multiple squids\nD G L O N T - Hits squids 2x\nB C H M P U - Hits squids 3x\nF K V W Y - Hits squids 4x\nJ Q X Z - Hits squids 5x"
        elseif num == 3 then
            title = "Jade Letters"
            tip = "Boosts word power.\n\nA E I R S - 1.5x multiplier\nD G L O N T - 2.0x multiplier\nB C H M P U - 2.5x multiplier\nF K V W Y - 3.0x multiplier\nJ Q X Z - 3.5x multiplier"
        end

        return {title, tip}
    end

    self.tip = generateTip()

    return self
end