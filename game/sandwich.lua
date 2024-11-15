function Sandwich()
    local self = {}
    self.x = 1000
    self.y = 430
    self.image = nil
    self.stolen = false

    self.draw = function ()
        if self.image == nil then
            love.graphics.setColor(0, 1, 0)
            love.graphics.circle("fill", self.x, self.y, 20)
            love.graphics.setColor(1, 1, 1)
        end
    end

    return self
end