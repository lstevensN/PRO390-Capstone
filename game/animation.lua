function Animation(i, w, h, d)
    local self = {}

    self.sprite = love.graphics.newImage(i)
    self.width = w
    self.height = h
    self.duration = d or 1

    local setQuads = function ()
        local q = {}

        for y = 0, self.sprite:getHeight() - self.height, self.height do
            for x = 0, self.sprite:getWidth() - self.width, self.width do
                table.insert(q, love.graphics.newQuad(x, y, self.width, self.height, self.sprite:getDimensions()))
            end
        end

        return q
    end

    local quads = setQuads()
    local spriteNum = 0
    local currentTime = 0

    self.update = function (dt)
        currentTime = currentTime + dt
        if currentTime >= self.duration then currentTime = currentTime - self.duration end
        spriteNum = math.floor(currentTime / self.duration * #quads) + 1
    end

    self.draw = function (x, y) love.graphics.draw(self.sprite, quads[spriteNum], x, y, 0) end

    return self
end