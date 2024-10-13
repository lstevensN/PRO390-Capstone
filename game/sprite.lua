function Sprite(xpos, ypos, s)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.speed = s or 0
    -- Remember to add Image property!
    self.xvel = 0
    self.yvel = 0

    self.draw = function ()
        
    end

    return self
end