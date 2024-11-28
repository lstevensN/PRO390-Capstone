-- ASSETS
    local i_squid_basic = love.graphics.newImage("game/assets/squid_sprite.png")
    local i_squid_basic_flipped = love.graphics.newImage("game/assets/squid_sprite_flip.png")
    local i_magala = love.graphics.newImage("game/assets/squid_magala.png")
    local i_magala_flipped = love.graphics.newImage("game/assets/squid_magala_flip.png")

function Enemy(xpos, ypos, t, s)
    local self = {}
    self.x = xpos or 0
    self.y = ypos or 0
    self.progress = 0
    self.type = t or "empty"
    self.hitBy = {}
    self.sandwichHeld = nil
    self.escaped = false

    local initialize = function ()
        if self.type == "empty" then return 0, 0, 1000, nil, nil
        elseif self.type == "basic" then return 150, 35, 40, Animation(i_squid_basic, 280, 280, 0.35, "basic"), Animation(i_squid_basic_flipped, 280, 280, 0.35, "basic")
        elseif self.type == "fast" then return 250, 25, 20, Animation(i_squid_basic, 280, 280, 0.2, "fast"), Animation(i_squid_basic_flipped, 280, 280, 0.2, "fast")
        elseif self.type == "strong" then return 100, 50, 80, Animation(i_squid_basic, 280, 280, 0.5, "strong"), Animation(i_squid_basic_flipped, 280, 280, 0.5, "strong")
        elseif self.type == "magala" then return 200, 100, 480, Animation(i_magala, 560, 560, 0.5, "magala"), Animation(i_magala_flipped, 560, 560, 0.5, "magala")
        elseif self.type == "blank" then return 0, 0, 0, nil, nil end
    end

    self.speed, self.radius, self.health, self.sprite, self.sprite_flipped = initialize()
    if s ~= nil then self.speed = s end
    local maxHP = self.health

    self.update = function (dt) if self.sprite ~= nil then self.sprite.update(dt) end if self.sprite_flipped ~= nil then self.sprite_flipped.update(dt) end end

    self.draw = function ()
        if self.sprite ~= nil and self.speed > 0 then
            if self.type == "fast" then self.sprite.draw(self.x - 35, self.y - 35)
            elseif self.type == "basic" then self.sprite.draw(self.x - 50, self.y - 50)
            elseif self.type == "strong" then self.sprite.draw(self.x - 70, self.y - 70)
            elseif self.type == "magala" then self.sprite.draw(self.x - 100, self.y - 130)
            end
        elseif self.sprite_flipped ~= nil and self.speed < 0 then
            if self.type == "fast" then self.sprite_flipped.draw(self.x - 35, self.y - 35)
            elseif self.type == "basic" then self.sprite_flipped.draw(self.x - 50, self.y - 50)
            elseif self.type == "strong" then self.sprite_flipped.draw(self.x - 70, self.y - 70)
            elseif self.type == "magala" then self.sprite_flipped.draw(self.x - 100, self.y - 130)
            end
        end

        love.graphics.setColor(0.75, 0, 0)
        love.graphics.rectangle("fill", self.x - (self.type == "magala" and 0.4 or 1) * maxHP / 2, self.y + 10 + self.radius, (self.type == "magala" and 0.4 or 1) * maxHP, 6)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.x - (self.type == "magala" and 0.4 or 1) * maxHP / 2, self.y + 10 + self.radius, (self.type == "magala" and 0.4 or 1) * maxHP * (self.health / maxHP), 6)

        love.graphics.setColor(1, 1, 1)
    end

    return self
end