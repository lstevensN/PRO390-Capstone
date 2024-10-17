function Line(x1, x2, y, s, r)
    local self = {}
    local startX = x1 or 0
    local endX = x2 or 0
    local locationY = y or 0
    local rebound = r or false
    local shown = s or false
    self.riders = {}

    self.addRider = function (rider)
        if rider.speed < 0 then rider.x = endX
        else rider.x = startX end
        rider.y = locationY

        table.insert(self.riders, rider)
    end

    self.removeRider = function (riderIndex)
        table.remove(self.riders, riderIndex)
    end

    self.update = function (dt)
        for i, v in ipairs(self.riders) do
            v.xvel = v.speed * dt
            v.x = v.x + v.xvel
    
            if (rebound == true and v.x >= endX) then
                v.speed = -v.speed
                v.x = endX
            elseif (v.x < startX or v.x > endX + 3) then self.removeRider(i) end
        end
    end

    self.draw = function ()
        if shown then
            love.graphics.line(startX * XScaleFactor, locationY * YScaleFactor, endX * XScaleFactor, locationY * YScaleFactor)
        end
    
        -- Draw Riders
        for i, v in ipairs(self.riders) do
            love.graphics.circle("line", v.x * XScaleFactor, v.y * YScaleFactor, 5)
        end
    end

    return self
end