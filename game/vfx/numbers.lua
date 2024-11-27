function DamageNumber(num, x, y, font, l)
    local self = {}

    self.x = x
    self.y = y
    self.opacity = 1
    self.fadeRate = 1
    self.gone = false

    local number = num
    local line = l or 0

    local text = love.graphics.newText(font, tostring(math.ceil(number)))

    self.update = function(dt)
        self.opacity = self.opacity - self.fadeRate * dt
        self.x = self.x - 10 * dt
        self.y = self.y - 10 * dt

        if self.opacity <= 0 then self.gone = true end
    end

    self.draw = function()
        if num > 30 then love.graphics.setColor(0.75, 0, 0, self.opacity)
        elseif line == 3 then love.graphics.setColor(0.75, 0.75, 0, self.opacity)
        else love.graphics.setColor(1, 1, 0, self.opacity) end

        love.graphics.draw(text, self.x - text:getWidth(), self.y - text:getHeight())
        
        love.graphics.setColor(1, 1, 1)
    end

    return self
end