local Sprite = { x = 0, y = 0, speed = 0 }  -- Remember to add Image property!

function Sprite:new(o)  -- Here too
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

return Sprite