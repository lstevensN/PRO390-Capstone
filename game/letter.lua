function Letter(letter, xpos, ypos, type, trans)
    local self = {}
    
    self.x = xpos or 0
    self.y = ypos or 0
    self.xvel = 0
    self.yvel = 0
    self.type = type or "blank"
    self.canPierce = false
    self.radius = 20
    self.clicked = false
    self.transmuteMode = trans or false
    self.bubbleHeight = 0
    self.transmuting = false
    self.locked = false

    local mouseInitialX = 0
    local mouseInitialY = 0
    local firstClick = false

    local setValue = function ()
        if self.type == "pierce" then self.canPierce = true end

        if     letter == 'a' or letter == 'e' or letter == 'i' or letter == 'r' or letter == 's' then return (self.type == "iron" and 5 or 1)
        elseif letter == 'd' or letter == 'g' or letter == 'l' or letter == 'o' or letter == 'n' or letter == 't' then return (self.type == "iron" and 10 or 2)
        elseif letter == 'b' or letter == 'c' or letter == 'h' or letter == 'm' or letter == 'p' or letter == 'u' then return (self.type == "iron" and 15 or 3)
        elseif letter == 'f' or letter == 'k' or letter == 'v' or letter == 'w' or letter == 'y' then return (self.type == "iron" and 20 or 4)
        elseif letter == 'j' or letter == 'q' or letter == 'x' or letter == 'z' then return (self.type == "iron" and 25 or 5)
        else return 0 end
    end

    self.letter = letter
    self.value = setValue()

    self.update = function(dt)
        if self.transmuteMode == true then
            if love.mouse.isDown(1) then
                if firstClick == false then
                    firstClick = true
                    mouseInitialX, mouseInitialY = love.mouse.getPosition()
                    if DistanceBetween(self.x + XOffset, self.y * ScaleFactor, mouseInitialX, mouseInitialY) < self.radius then self.clicked = true end
                elseif self.clicked == true then
                    local x, y = love.mouse.getPosition()
                    self.x = x - XOffset
                    self.y = y / ScaleFactor
                    self.xvel = 0
                    self.yvel = 0
                end
            else firstClick = false self.clicked = false end
        end

        self.x = self.x + self.xvel * dt
        self.y = self.y + self.yvel * dt
    end

    self.draw = function ()
        if self.type == "pierce" then love.graphics.setColor(138/255, 43/255, 226/255) else love.graphics.setColor(1, 1, 1) end
        love.graphics.circle(self.type == "iron" and "fill" or "line", self.x + XOffset, self.y * ScaleFactor, self.radius * ScaleFactor)

        if self.type == "iron" then
            love.graphics.setColor(0, 0, 0)
            love.graphics.print(tostring(self.value / 5), self.x + XOffset, self.y * ScaleFactor)
        else
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(tostring(self.value), self.x + XOffset, self.y * ScaleFactor)
        end

        love.graphics.setColor(1, 1, 1)
    end

    return self
end