function Button(xpos, ypos, w, h, onclick, i, ip)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.width = w or 1
    self.height = h or 1
    self.pressed = false
    -- Image Property?

    local setImage = function () if i ~= nil then return love.graphics.newImage(i) else return nil end end
    local setImagePressed = function () if ip ~= nil then return love.graphics.newImage(ip) else return nil end end

    self.image = setImage() or nil
    self.imagePressed = setImagePressed() or nil

    local firstClick = false

    self.onClick = onclick or function () end

    self.update = function (dt)
        if love.mouse.isDown(1) then
            if firstClick == false then
                firstClick = true
                local x, y = love.mouse.getPosition()
                x = (x - XOffset) / ScaleFactor
                y = y / ScaleFactor

                if (x >= self.x - self.width / 2 and x <= self.x - self.width / 2 + self.width) and
                (y >= self.y - self.height / 2 and y <= self.y - self.height / 2 + self.height) then self.onClick() end
            end
        else firstClick = false
        end
    end

    self.draw = function ()
        if self.image == nil then love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
        else
            local x, y = love.mouse.getPosition()
            x = (x - XOffset) / ScaleFactor
            y = y / ScaleFactor

            if (x >= self.x - self.width / 2 and x <= self.x - self.width / 2 + self.width) and
            (y >= self.y - self.height / 2 and y <= self.y - self.height / 2 + self.height) then
                love.graphics.draw(self.imagePressed, self.x - self.width / 2, self.y - self.height / 2, 0, 0.25, 0.25)
            else love.graphics.draw(self.image, self.x - self.width / 2, self.y - self.height / 2, 0, 0.25, 0.25) end
        end
    end

    return self
end

function ButtonCircle(xpos, ypos, r, onclick, i)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.radius = r or 20
    self.pressed = false
    -- Image Property?

    local setImage = function () if i ~= nil then return love.graphics.newImage(i) else return nil end end

    self.image = setImage() or nil

    local firstClick = false

    self.onClick = onclick or function () end

    self.update = function (dt)
        if love.mouse.isDown(1) then
            if firstClick == false then
                firstClick = true
                local x, y = love.mouse.getPosition()
                x = (x - XOffset) / ScaleFactor
                y = y / ScaleFactor

                if DistanceBetween(self.x, self.y, x, y) < self.radius then self.onClick() end
            end
        else firstClick = false
        end
    end

    self.draw = function ()
        if self.image == nil then love.graphics.circle("fill", self.x, self.y, self.radius)
        else love.graphics.draw(self.image, self.x - self.radius, self.y - self.radius, 0, 0.5, 0.5) end
    end

    return self
end