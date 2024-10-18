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

    self.changeMode = function (newMode) self.mode = newMode end

    self.addEnemy = function (enemy) table.insert(self.enemies, enemy) end

    self.aim = function ()
        if #self.enemies > 0 then
            if self.mode == "first" then
                dx = self.enemies[#self.enemies].x - x
                dy = -(self.enemies[#self.enemies].y - y)
            elseif self.mode == "last" then
                dx = self.enemies[1].x - x
                dy = -(self.enemies[1].y - y)
            end
        end
    end

    self.draw = function ()
        love.graphics.draw(image, x * XScaleFactor, y * YScaleFactor, math.atan2(dx, dy), 0.5 * XScaleFactor, 0.5 * YScaleFactor, image:getWidth() / 2, image:getHeight() / 2 + 50)
    end

    return self
end