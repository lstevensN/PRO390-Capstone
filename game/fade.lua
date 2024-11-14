function Fader()
    local self = {}
    self.fading = false

    local fadeOpacity = 0
    local fadeTimer = 0.6
    local fadeIn = true
    local fader

    local cron = require "cron"

    self.start = function (sceneTransition)
        self.fading = true
        fadeIn = true

        local fadeFunc = function ()
            sceneTransition()
            fadeIn = false
        end

        fader = cron.after(fadeTimer, fadeFunc)
    end

    self.update = function (dt)
        if self.fading == true then
            if fadeIn == true then fadeOpacity = fadeOpacity + (1 / fadeTimer * dt)
            else fadeOpacity = fadeOpacity - (1 / fadeTimer * dt) end

            if fadeOpacity > 1 then fadeOpacity = 1 end
            if fadeOpacity <= 0 then fadeOpacity = 0 self.fading = false end

            fader:update(dt)
        end
    end

    self.draw = function ()
        love.graphics.setColor(0, 0, 0, fadeOpacity)
        love.graphics.rectangle("fill", -2, -2, 1202, 902)
        love.graphics.setColor(1, 1, 1)
    end

    return self
end