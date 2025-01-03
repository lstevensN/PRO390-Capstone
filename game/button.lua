function Button(xpos, ypos, w, h, onclick, i, ip)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.width = w or 1
    self.height = h or 1
    self.pressed = false
    self.selected = false

    self.image = i or nil
    self.imagePressed = ip or nil

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

            if self.imagePressed ~= nil and ((x >= self.x - self.width / 2 and x <= self.x - self.width / 2 + self.width) and
            (y >= self.y - self.height / 2 and y <= self.y - self.height / 2 + self.height) or self.selected == true) then
                love.graphics.draw(self.imagePressed, self.x - self.width / 2, self.y - self.height / 2, 0, 0.25, 0.25)
            else love.graphics.draw(self.image, self.x - self.width / 2, self.y - self.height / 2, 0, 0.25, 0.25) end
        end
    end

    return self
end

function ButtonGear(xpos, ypos, r, onclick, f, b, bh)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.radius = r or 20
    self.pressed = false
    self.hoveredOver = false
    self.locked = true
    self.logo = false
    -- Image Property?

    self.front = f or nil
    self.back = b or nil
    self.backHovered = bh or nil

    local firstClick = false
    local rotation = 0

    self.onClick = onclick or function () end

    self.update = function (dt)
        local mouseX, mouseY = love.mouse.getPosition()
        mouseX = (mouseX - XOffset) / ScaleFactor
        mouseY = mouseY / ScaleFactor

        if DistanceBetween(self.x, self.y, mouseX, mouseY) < self.radius or self.logo == true then
            self.hoveredOver = true
            if self.locked == false then rotation = rotation + dt end
        else self.hoveredOver = false end

        if self.locked == false and love.mouse.isDown(1) then
            if firstClick == false then
                firstClick = true
                if DistanceBetween(self.x, self.y, mouseX, mouseY) < self.radius then self.onClick() end
            end
        else firstClick = false end
    end

    self.draw = function ()
        if self.front == nil then love.graphics.circle("fill", self.x, self.y, self.radius)
        else
            if self.hoveredOver == true and self.locked == false then love.graphics.draw(self.backHovered, self.x, self.y, -rotation / 2, 0.5, 0.5, 285, 285)
            else love.graphics.draw(self.back, self.x, self.y, -rotation / 2, 0.5, 0.5, 285, 285) end

            love.graphics.draw(self.front, self.x, self.y, rotation, 0.5, 0.5, 285, 285)
        end
    end

    return self
end