function Letter(letter, type)
    local self = {}

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

    return self
end