function Enemy(xpos, ypos, t)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.progress = 0
    self.type = t or "empty"

    local initialize = function ()
        if self.type == "empty" then return 0, 0, 1000
        elseif self.type == "basic" then return 150, 25, 15
        elseif self.type == "fast" then return 250, 25, 15
        elseif self.type == "strong" then return 100, 35, 50
        elseif self.type == "blank" then return 0, 0, 0 end
    end
    
    self.speed, self.radius, self.health = initialize()

    self.draw = function ()
        love.graphics.circle("line", self.x + XOffset, self.y * ScaleFactor, self.radius)
    end

    return self
end