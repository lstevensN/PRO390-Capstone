function Fader()
    local self = {}
    self.fading = false

    local fadeOpacity = 0
    local fadeTimer = 0.6
    local fadeIn = true
    local fader

    local bgm, bgm2 = nil, nil

    local cron = require "cron"

    self.start = function (sceneTransition, music1, music2)
        bgm = nil
        bgm2 = nil

        self.fading = true
        fadeIn = true
        if music1 ~= nil and music2 ~= nil then bgm = music1 bgm2 = music2
        elseif music1 ~= nil then bgm = music1 end

        local fadeFunc = function ()
            sceneTransition()
            fadeIn = false

            if bgm ~= nil and bgm2 ~= nil then bgm:stop() bgm2:play()
            elseif bgm ~= nil then bgm:stop() end
        end

        fader = cron.after(fadeTimer, fadeFunc)
    end

    self.update = function (dt)
        if self.fading == true then
            if fadeIn == true then fadeOpacity = fadeOpacity + (1 / fadeTimer * dt)
            else fadeOpacity = fadeOpacity - (1 / fadeTimer * dt) end

            if fadeOpacity > 1 then fadeOpacity = 1 end
            if fadeOpacity <= 0 then fadeOpacity = 0 self.fading = false end

            if bgm ~= nil and bgm2 ~= nil then
                if fadeIn == true then bgm2:setVolume(fadeOpacity * MusicVolume * MainVolume)
                else bgm:setVolume(fadeOpacity * MusicVolume * MainVolume) end
            elseif bgm ~= nil then bgm:setVolume(fadeOpacity * MusicVolume * MainVolume) end

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