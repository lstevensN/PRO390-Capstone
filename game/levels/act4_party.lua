function Act4_Party()
    local self = {}
    self.canSpawn = true
    self.spawnTimer = 2
    self.over = false
    self.music = love.audio.newSource("game/audio/TheParty_Alt_Music.wav", "stream")
    self.sandwiches = {
        Sandwich(950, 430),
        Sandwich(970, 430),
        Sandwich(990, 430),
        Sandwich(1010, 430),
        Sandwich(1030, 430)
    }

    local enemies = {
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "magala", 1500),
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "blank"), -- break
        Enemy(0, 0, "fast"),
        Enemy(0, 0, "basic"),
        Enemy(0, 0, "strong"),
    }
    local spawnIndex = 1
    local time = 0

    self.spawnEnemy = function ()
        time = time + self.spawnTimer

        if spawnIndex <= #enemies then
            if spawnIndex ~= 60 or time > 168 then
                spawnIndex = spawnIndex + 1
                if spawnIndex > #enemies then self.canSpawn = false self.over = true end
                return enemies[spawnIndex - 1]
            else return Enemy(0, 0, "blank") end
        end
    end

    return self
end