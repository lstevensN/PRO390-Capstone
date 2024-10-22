function TestLevel()
    local self = {}
    self.canSpawn = true
    self.spawnTimer = 2

    local enemies = {
        Enemy(200, -100, 0),  -- blank enemy
        Enemy(0, 0, 250),
        Enemy(0, 0, 300),
        Enemy(0, 0, 350)
    }
    local spawnIndex = 1

    self.spawnEnemy = function ()
        if spawnIndex <= #enemies then
            spawnIndex = spawnIndex + 1
            if spawnIndex == #enemies then self.canSpawn = false end
            return enemies[spawnIndex - 1]
        end
    end

    return self
end