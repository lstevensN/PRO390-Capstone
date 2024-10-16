function Gun(xpos, ypos, mode)
    local self = {}
    self.ammo = {}
    self.mode = mode or "first"
    local image = love.graphics.newImage("game/assets/faketurret.png")
    local x = xpos or 0
    local y = ypos or 0
    local dx = 0
    local dy = 0

    self.changeMode = function (newMode) self.mode = newMode end

    self.aim = function (enemies)
        if #enemies > 0 then
            if self.mode == "first" then
                dx = enemies[1].x - x
                dy = -(enemies[1].y - y)
            end
        end
    end

    self.draw = function ()
        love.graphics.draw(image, x, y, math.atan2(dx, dy), 0.5, 0.5, image:getWidth() / 2, image:getHeight() / 2 + 50)
    end

    return self
end