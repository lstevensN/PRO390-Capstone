local Spline = 
{
    startX = 0,
    startY = 0,
    endX = 0,
    endY = 0,
    direction = { 0, 0 },

    shown = false,
    riders = {}
}

function Spline:update(dt)
    for i, v in ipairs(self.riders) do
        
    end
end

function Spline:draw()
    if self.shown then love.graphics.line(self.startX, self.startY, self.endX, self.endY) end

    for i, v in ipairs(self.riders) do
        love.graphics.circle("line", v.x, v.y, 5)
    end
end

function Spline:addRider(rider)
    rider.x = self.startX
    rider.y = self.startY
    table.insert(self.riders, rider)
end

function Spline:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

return Spline