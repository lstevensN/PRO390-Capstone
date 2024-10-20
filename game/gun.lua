function Gun(xpos, ypos, mode)
    local self = {}
    self.ammo = {}
    self.mode = mode or "first"
    self.enemies = {}
    local image = love.graphics.newImage("game/assets/faketurret.png")
    local x = xpos or 0
    local y = ypos or 0
    local dx = 0
    local dy = 0
    local canShoot = false
    local letterIndex = 1
    local targetIndex = 1

    local next = next

    local blindSpots = function (enemy)
        if enemy.x < 0 or enemy.x > love.graphics.getWidth() - XOffset * 2 then return true
        else return false end
    end

    self.changeMode = function (newMode) self.mode = newMode end

    self.addEnemy = function (enemy) table.insert(self.enemies, enemy) end

    self.fire = function (dt)
        if canShoot == true and next(self.ammo) ~= nil then
            -- fire letter bullet
            -- self.ammo[1][letterIndex]

            letterIndex = letterIndex + 1
            if letterIndex > #self.ammo then
                letterIndex = 1
                table.remove(self.ammo, 1)
            end
        end
    end

    self.aim = function ()
        if #self.enemies > 0 then
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
        love.graphics.draw(image, x + XOffset, y * ScaleFactor, math.atan2(dx, dy), 0.5 * ScaleFactor, 0.5 * ScaleFactor, image:getWidth() / 2, image:getHeight() / 2 + 50)
    end

    return self
end