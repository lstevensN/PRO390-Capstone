function Enemy(xpos, ypos, t)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.progress = 0
    self.type = t or "empty"
    self.hitBy = {}
    self.sandwichHeld = nil

    local initialize = function ()
        if self.type == "empty" then return 0, 0, 1000, nil
        elseif self.type == "basic" then return 150, 35, 30, Animation("game/assets/squid_sprite.png", 280, 280, 0.35, "basic"), Animation("game/assets/squid_sprite_flip.png", 280, 280, 0.35, "basic")
        elseif self.type == "fast" then return 250, 25, 20, Animation("game/assets/squid_sprite.png", 280, 280, 0.2, "fast"), Animation("game/assets/squid_sprite_flip.png", 280, 280, 0.2, "fast")
        elseif self.type == "strong" then return 100, 50, 100, Animation("game/assets/squid_sprite.png", 280, 280, 0.5, "strong"), Animation("game/assets/squid_sprite_flip.png", 280, 280, 0.5, "strong")
        elseif self.type == "blank" then return 0, 0, 0, nil end
    end

    self.speed, self.radius, self.health, self.sprite, self.sprite_flipped = initialize()
    local maxHP = self.health

    self.update = function (dt) if self.sprite ~= nil then self.sprite.update(dt) end if self.sprite_flipped ~= nil then self.sprite_flipped.update(dt) end end

    self.draw = function ()
        --love.graphics.setColor(0, 0, 0)
        --love.graphics.circle("line", self.x, self.y, self.radius)
        if self.sprite ~= nil and self.speed > 0 then
            if self.type == "fast" then self.sprite.draw(self.x - 35, self.y - 35)
            elseif self.type == "basic" then self.sprite.draw(self.x - 50, self.y - 50)
            elseif self.type == "strong" then self.sprite.draw(self.x - 70, self.y - 70)
            end
        elseif self.sprite_flipped ~= nil and self.speed < 0 then
            if self.type == "fast" then self.sprite_flipped.draw(self.x - 35, self.y - 35)
            elseif self.type == "basic" then self.sprite_flipped.draw(self.x - 50, self.y - 50)
            elseif self.type == "strong" then self.sprite_flipped.draw(self.x - 70, self.y - 70)
            end
        end

        love.graphics.setColor(0.75, 0, 0)
        love.graphics.rectangle("fill", self.x - maxHP / 2, self.y + 10 + self.radius, maxHP, 6)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.x - maxHP / 2, self.y + 10 + self.radius, maxHP * (self.health / maxHP), 6)

        love.graphics.setColor(1, 1, 1)
    end

    return self
end