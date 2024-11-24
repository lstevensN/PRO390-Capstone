function Enemy(xpos, ypos, t)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.progress = 0
    self.type = t or "empty"
    self.hitBy = {}
    self.sandwichHeld = nil

    self.sprite = nil

    local initialize = function ()
        if self.type == "empty" then return 0, 0, 1000
        elseif self.type == "basic" then return 150, 25, 30
        elseif self.type == "fast" then return 250, 25, 20
        elseif self.type == "strong" then return 100, 35, 120
        elseif self.type == "blank" then return 0, 0, 0 end
    end

    self.speed, self.radius, self.health = initialize()
    local maxHP = self.health

    self.update = function (dt) if self.sprite ~= nil then self.sprite.update(dt) end end

    self.draw = function ()
        love.graphics.setColor(0, 0, 0)
        love.graphics.circle("line", self.x, self.y, self.radius)
        if self.sprite ~= nil then self.sprite.draw(self.x - self.radius, self.y - self.radius) end

        love.graphics.setColor(0.75, 0, 0)
        love.graphics.rectangle("fill", self.x - 20, self.y + 35, 40, 6)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.x - 20, self.y + 35, 40 * (self.health / maxHP), 6)

        love.graphics.setColor(1, 1, 1)
    end

    return self
end