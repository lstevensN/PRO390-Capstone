function Letter(letter, xpos, ypos, type)
    local self = {}
    
    self.x = xpos or 0
    self.y = ypos or 0
    self.xvel = 0
    self.yvel = 0

    local setValue = function ()
        if     letter == 'a' or letter == 'e' or letter == 'i' or letter == 'r' or letter == 's' then return 1
        elseif letter == 'd' or letter == 'g' or letter == 'l' or letter == 'o' or letter == 'n' or letter == 't' then return 2
        elseif letter == 'b' or letter == 'c' or letter == 'h' or letter == 'm' or letter == 'p' or letter == 'u' then return 3
        elseif letter == 'f' or letter == 'k' or letter == 'v' or letter == 'w' or letter == 'y' then return 4
        elseif letter == 'j' or letter == 'q' or letter == 'x' or letter == 'z' then return 5
        else return 0 end
    end

    self.letter = letter
    self.value = setValue()
    self.type = type or "blank"

    self.update = function(dt)
        
    end

    self.draw = function ()
        love.graphics.circle("line", self.x + XOffset, self.y * ScaleFactor, 5)
    end

    return self
end