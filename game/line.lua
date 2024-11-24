function Line(x1, x2, y, s, r)
    local self = {}
    local startX = x1 or 0
    local endX = x2 or 0
    local locationY = y or 0
    local rebound = r or false
    local shown = s or false
    self.riders = {}
    self.prevLine = {}
    self.nextLine = {}

    local next = next

    self.addRider = function (rider)
        if rider.speed < 0 then rider.x = endX
        else rider.x = startX end
        rider.y = locationY

        table.insert(self.riders, rider)
    end

    self.removeRider = function (riderIndex)
        local rider = self.riders[riderIndex]
        rider.speed = -rider.speed

        if     rebound == true and next(self.prevLine) ~= nil then self.prevLine.addRider(rider)
        elseif rider.speed > 0 and next(self.nextLine) ~= nil and next(self.prevLine) ~= nil then self.nextLine.addRider(rider)
        elseif rider.speed < 0 and next(self.prevLine) ~= nil then self.prevLine.addRider(rider)
        elseif rider.speed < 0 and next(self.nextLine) ~= nil then self.nextLine.addRider(rider) end
        
        table.remove(self.riders, riderIndex)
    end

    self.update = function (dt)
        for i, v in ipairs(self.riders) do
            v.update(dt)

            v.x = v.x + v.speed * dt
            v.progress = v.progress + math.abs(v.speed) / 100
    
            if (rebound == true and v.x >= endX) then
                v.speed = -v.speed
                v.x = endX
            elseif (v.x < startX or v.x > endX + 3) then self.removeRider(i) end
        end
    end

    self.draw = function ()
        if shown then
            love.graphics.line(startX, locationY, endX, locationY)
        end
    
        -- Draw Riders
        for i, v in ipairs(self.riders) do v.draw() end
    end

    return self
end