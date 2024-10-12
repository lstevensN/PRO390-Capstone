function Line(x1, x2, y, s, r)
    local self = {}
    local startX = x1 or 0
    local endX = x2 or 0
    local locationY = y or 0
    local rebound = r or false
    local shown = s or false
    local riders = {}

    self.addRider = function (rider)
        if rider.getSpeed() < 0 then rider.x = endX
        else rider.x = startX end
        rider.y = locationY

        table.insert(riders, rider)
    end

    self.removeRider = function (riderIndex)
        table.remove(riders, riderIndex)
    end

    self.update = function (dt)
        for i, v in ipairs(riders) do
            v.xvel = v.getSpeed() * dt
            v.x = v.x + v.xvel
    
            if (rebound == true and v.x >= endX) then
                v.setSpeed(-v.getSpeed())
                v.x = endX
            elseif (v.x < startX or v.x > endX + 3) then self.removeRider(i) end
        end
    end

    self.draw = function ()
        if shown then
            love.graphics.line(startX, locationY, endX, locationY)
        end
    
        -- Draw Riders
        for i, v in ipairs(riders) do
            love.graphics.circle("line", v.x, v.y, 5)
        end
    end

    return self
end