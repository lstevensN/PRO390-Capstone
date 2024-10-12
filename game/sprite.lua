function Sprite(xpos, ypos, s)
    local self = {}
    local x = xpos or 0
    local y = ypos or 0
    local speed = s or 0
    -- Remember to add Image property!
    local xvel = 0
    local yvel = 0

    self.getSpeed = function () return speed end
    self.setSpeed = function (newSpeed) speed = newSpeed end

    return self
end