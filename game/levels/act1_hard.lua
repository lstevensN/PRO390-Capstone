function Act1_Hard()
    local self = {}
    self.canSpawn = true
    self.spawnTimer = 2.5
    self.over = false
    self.music = love.audio.newSource("game/audio/TheHunger_Music.wav", "stream")
    self.sandwiches = {
        Sandwich(970, 430),
        Sandwich(990, 430),
        Sandwich(1010, 430)
    }

    local enemies = {
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic")
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