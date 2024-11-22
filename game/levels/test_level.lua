function TestLevel()
    local self = {}
    self.canSpawn = true
    self.spawnTimer = 2
    self.over = false
    self.sandwiches = {
        Sandwich()
    }

    local enemies = {
        --Enemy(0, 0, "blank")
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "strong")
        --Enemy(0, 0, "blank"),
        --Enemy(0, 0, "blank"),
        --Enemy(0, 0, "fast"),
        --Enemy(0, 0, "basic"),
        --Enemy(0, 0, "fast"),
        --Enemy(0, 0, "blank"),
        --Enemy(0, 0, "basic"),
        --Enemy(0, 0, "fast"),
        --Enemy(0, 0, "strong")
    }
    local spawnIndex = 1

    self.spawnEnemy = function ()
        if spawnIndex <= #enemies then
            spawnIndex = spawnIndex + 1
            if spawnIndex > #enemies then self.canSpawn = false self.over = true end
            return enemies[spawnIndex - 1]
        end
    end

    return self
end