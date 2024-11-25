function Gun(xpos, ypos, mode)
    local self = {}
    self.ammo = {}
    self.mode = mode or "first"
    self.enemies = {}
    local image = love.graphics.newImage("game/assets/gun.png")
    local x = xpos or 0
    local y = ypos or 0
    local dx = 0
    local dy = 0
    local canShoot = false
    local letterIndex = 1
    local targetIndex = 1
    local bulletSpeed = 4000

    local whoosh = love.audio.newSource("game/audio/whoosh.mp3", "static")

    local next = next

    local blindSpots = function (enemy)
        if enemy.x < 0 or enemy.x > 1200 then return true
        else return false end
    end

    local getDirection = function ()
        local xdir = self.enemies[targetIndex].x + self.enemies[targetIndex].speed / 10 - x
        local ydir = self.enemies[targetIndex].y - y

        local length = math.sqrt(xdir ^ 2 + ydir ^ 2)

        return xdir / length, ydir / length
    end

    self.changeMode = function (newMode) self.mode = newMode end

    self.addEnemy = function (enemy) table.insert(self.enemies, enemy) end

    self.removeEnemy = function (enemy) for i, v in ipairs(self.enemies) do if v == enemy then table.remove(self.enemies, i) return end end end

    self.fire = function (dt)
        if canShoot == true and next(self.ammo) ~= nil then
            -- fire letter bullet
            if next(self.ammo[1]) ~= nil then
                self.ammo[1][letterIndex].x = x
                self.ammo[1][letterIndex].y = y

                local xdir, ydir = getDirection()

                self.ammo[1][letterIndex].xvel = xdir * bulletSpeed
                self.ammo[1][letterIndex].yvel = ydir * bulletSpeed

                letterIndex = letterIndex + 1
            end

            if letterIndex > #self.ammo[1] then
                table.remove(self.ammo, 1)
                letterIndex = 1
            end

            if whoosh:isPlaying() then whoosh:stop() end whoosh:play()
        end
    end

    self.aim = function ()
        if #self.enemies > 0 then
            targetIndex = 1

            if self.mode == "first" then
                for i, v in ipairs(self.enemies) do
                    if v.progress > self.enemies[targetIndex].progress and blindSpots(v) == false then targetIndex = i end
                end
            elseif self.mode == "last" then
                for i, v in ipairs(self.enemies) do
                    if v.progress < self.enemies[targetIndex].progress and blindSpots(v) == false then targetIndex = i end
                end
            end

            dx = self.enemies[targetIndex].x - x
            dy = -(self.enemies[targetIndex].y - y)

            if targetIndex ~= 1 then canShoot = true else canShoot = false end
        end
    end

    self.draw = function ()
        love.graphics.draw(image, x, y, math.atan2(dx, dy), 0.5, 0.5, 205, 325)
    end

    return self
end