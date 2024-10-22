function Letter(letter, xpos, ypos, type)
    local self = {}
    
    self.x = xpos or 0
    self.y = ypos or 0
    self.xvel = 0
    self.yvel = 0
    self.type = type or "blank"
    self.canPierce = false

    local setValue = function ()
        if     letter == 'a' or letter == 'e' or letter == 'i' or letter == 'r' or letter == 's' then return (self.type == "strong" and 5 or 1)
        elseif letter == 'd' or letter == 'g' or letter == 'l' or letter == 'o' or letter == 'n' or letter == 't' then return (self.type == "strong" and 10 or 2)
        elseif letter == 'b' or letter == 'c' or letter == 'h' or letter == 'm' or letter == 'p' or letter == 'u' then return (self.type == "strong" and 15 or 3)
        elseif letter == 'f' or letter == 'k' or letter == 'v' or letter == 'w' or letter == 'y' then return (self.type == "strong" and 20 or 4)
        elseif letter == 'j' or letter == 'q' or letter == 'x' or letter == 'z' then return (self.type == "strong" and 25 or 5)
        else return 0 end
    end

    self.letter = letter
    self.value = setValue()

    self.update = function(dt)
        self.x = self.x + self.xvel * dt
        self.y = self.y + self.yvel * dt
    end

    self.draw = function ()
        love.graphics.setColor(255, 255, 255, 1)
        love.graphics.circle("line", self.x + XOffset, self.y * ScaleFactor, 5)
    end

    return self
end