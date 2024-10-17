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
            (x >= (self.x - self.width / 2) * XScaleFactor and x <= (self.x - self.width / 2 + self.width) * XScaleFactor) and
            (y >= (self.y - self.height / 2) * YScaleFactor and y <= (self.y - self.height / 2 + self.height) * YScaleFactor) then
                self.onClick()
                self.pressed = true
            end
        else self.pressed = false
        end
    end

    self.draw = function ()
        love.graphics.rectangle("fill", (self.x - self.width / 2) * XScaleFactor, (self.y - self.height / 2) * YScaleFactor, self.width * XScaleFactor, self.height * YScaleFactor)
    end

    return self
end