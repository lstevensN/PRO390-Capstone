function Enemy(xpos, ypos, s)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.speed = s or 0
    self.progress = 0
    self.radius = 20
    self.health = 15
    -- Remember to add Image property!

    self.draw = function ()
        love.graphics.circle("line", self.x + XOffset, self.y * ScaleFactor, self.radius)
    end

    return self
end