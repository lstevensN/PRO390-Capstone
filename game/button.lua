function Button(xpos, ypos, w, h, onclick)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.width = w or 1
    self.height = h or 1
    self.pressed = false
    -- Image Property?

    local firstClick = false

    self.onClick = onclick or function () end

    self.update = function (dt)
        if love.mouse.isDown(1) then
            if firstClick == false then
                firstClick = true
                local x, y = love.mouse.getPosition()

                if (x >= (self.x - self.width / 2) + XOffset and x <= (self.x - self.width / 2 + self.width) + XOffset) and
                (y >= (self.y - self.height / 2) * ScaleFactor and y <= (self.y - self.height / 2 + self.height) * ScaleFactor) then self.onClick() end
            end
        else firstClick = false
        end
    end

    self.draw = function ()
        love.graphics.rectangle("fill", (self.x - self.width / 2) + XOffset, (self.y - self.height / 2) * ScaleFactor, self.width * ScaleFactor, self.height * ScaleFactor)
    end

    return self
end

function ButtonCircle(xpos, ypos, r, onclick)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.radius = r or 20
    self.pressed = false
    -- Image Property?

    local firstClick = false

    self.onClick = onclick or function () end

    self.update = function (dt)
        if love.mouse.isDown(1) then
            if firstClick == false then
                firstClick = true
                local x, y = love.mouse.getPosition()

                if DistanceBetween(self.x + XOffset, self.y * ScaleFactor, x, y) < self.radius then self.onClick() end
            end
        else firstClick = false
        end
    end

    self.draw = function ()
        love.graphics.circle("fill", self.x + XOffset, self.y * ScaleFactor, self.radius * ScaleFactor)
    end

    return self
end