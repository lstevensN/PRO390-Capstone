function Sandwich(x, y)
    local self = {}
    self.x = x or 1000
    self.y = y or 430
    self.image = love.graphics.newImage("game/assets/sandwich.png")
    self.stolen = false

    self.draw = function ()
        if self.image == nil then
            love.graphics.setColor(0, 1, 0)
            love.graphics.circle("fill", self.x, self.y, 20)
            love.graphics.setColor(1, 1, 1)
        else love.graphics.draw(self.image, self.x, self.y, 0, 0.1) end
    end

    return self
end