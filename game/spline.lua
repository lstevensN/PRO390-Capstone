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

function Spline:direct()
    local x = self.endX - self.startX
    local y = self.endY - self.startY

    local length = math.sqrt(x ^ 2 + y ^ 2)

    self.direction = { x / length, y / length }
end

function Spline:update(dt)
    for i, v in ipairs(self.riders) do
        if v.x <= self.endX and v.x >= self.startX then v.x = v.x + self.direction[1] * v.speed * dt end
        if v.y <= self.endY and v.y >= self.startY then v.y = v.y + self.direction[2] * v.speed * dt end

        if (v.x > self.endX or v.x < self.startX) or (v.y > self.endY or v.y < self.startY) then self:removeRider(i) end
    end
end

function Spline:draw()
    if self.shown then 
        love.graphics.line(self.startX, self.startY, self.endX, self.endY)
        love.graphics.setColor(255, 0, 255, 1)
        love.graphics.print(tostring(self.direction[1]).." "..tostring(self.direction[2]), self.startX, self.startY - 20)
        love.graphics.setColor(255, 255, 255, 1)
    end

    for i, v in ipairs(self.riders) do
        love.graphics.circle("line", v.x, v.y, 5)
    end
end

function Spline:addRider(rider)
    if rider.speed < 0 then
        rider.x = self.endX
        rider.y = self.endY
    else
        rider.x = self.startX
        rider.y = self.startY
    end
    table.insert(self.riders, rider)
end

function Spline:removeRider(riderIndex) table.remove(self.riders, riderIndex) end

function Spline:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

return Spline