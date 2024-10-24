function Button(xpos, ypos, w, h, onclick)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.width = w or 1
    self.height = h or 1
    self.pressed = false
    -- Image Property?

    self.onClick = onclick or function () end

    self.update = function (dt)
        if love.mouse.isDown(1) then
            local x, y = love.mouse.getPosition()

            if self.pressed == false and
            (x >= (self.x - self.width / 2) + XOffset and x <= (self.x - self.width / 2 + self.width) + XOffset) and
            (y >= (self.y - self.height / 2) * ScaleFactor and y <= (self.y - self.height / 2 + self.height) * ScaleFactor) then
                self.onClick()
                self.pressed = true
            end
        else self.pressed = false
        end
    end

    self.draw = function ()
        love.graphics.rectangle("fill", (self.x - self.width / 2) + XOffset, (self.y - self.height / 2) * ScaleFactor, self.width * ScaleFactor, self.height * ScaleFactor)
    end

    return self
end