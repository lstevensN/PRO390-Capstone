function Enemy(xpos, ypos, t, h)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.progress = 0
    self.type = t or "empty"
    self.hitBy = {}
    self.sandwichHeld = nil
    self.escaped = false

    local initialize = function ()
        if self.type == "empty" then return 0, 0, 1000, nil
        elseif self.type == "basic" then return 150, 35, 30, Animation("game/assets/squid_sprite.png", 280, 280, 0.35, "basic"), Animation("game/assets/squid_sprite_flip.png", 280, 280, 0.35, "basic")
        elseif self.type == "fast" then return 250, 25, 20, Animation("game/assets/squid_sprite.png", 280, 280, 0.2, "fast"), Animation("game/assets/squid_sprite_flip.png", 280, 280, 0.2, "fast")
        elseif self.type == "strong" then return 100, 50, 100, Animation("game/assets/squid_sprite.png", 280, 280, 0.5, "strong"), Animation("game/assets/squid_sprite_flip.png", 280, 280, 0.5, "strong")
        elseif self.type == "magala" then return 250, 50, 2500, Animation("game/assets/squid_magala.png", 560, 560, 0.2, "magala"), Animation("game/assets/squid_magala_flip.png", 560, 560, 0.2, "magala")
        elseif self.type == "blank" then return 0, 0, 0, nil end
    end

    self.speed, self.radius, self.health, self.sprite, self.sprite_flipped = initialize()
    if h ~= nil then self.health = h end
    local maxHP = self.health

    self.update = function (dt) if self.sprite ~= nil then self.sprite.update(dt) end if self.sprite_flipped ~= nil then self.sprite_flipped.update(dt) end end

    self.draw = function ()
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