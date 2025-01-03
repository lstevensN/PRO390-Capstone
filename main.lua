if arg[2] == "debug" then require("lldebugger").start() end

local state

local screenX, screenY = 1200, 900

XOffset = 0
ScaleFactor = 0

MainVolume = 100 / 100
MusicVolume = 100 / 100
SfxVolume = 100 / 100

local mouseX, mouseY = 0, 0

local f_debug = love.graphics.newFont("game/assets/fonts/NotoSerif-Regular.ttf", 15)

function love.resize(w, h) end

function love.load()
    require("game.state")

    state = GameState()
    state.load()
end

-- Main Game Loop
function love.update(dt)
    -- Update game here
    state.update(dt)

    mouseX, mouseY = love.mouse.getPosition()
    mouseX = (mouseX - XOffset) / ScaleFactor
    mouseY = mouseY / ScaleFactor

    ScaleFactor = love.graphics.getHeight() / screenY
    XOffset = (love.graphics.getWidth() - screenX * ScaleFactor) / 2
end

function love.draw()
    love.graphics.push()
        love.graphics.translate(XOffset, 0)
        love.graphics.scale(ScaleFactor)

        love.graphics.setColor(1, 1, 1)
        love.graphics.setBackgroundColor(0, 0, 0)
        
        state.draw()

        love.graphics.setColor(0, 0, 0, 0.35)
        love.graphics.setFont(f_debug)
        --love.graphics.print('Here goes nothing! (^v^)', 10, 10)
        --love.graphics.print("mouse x: "..tostring(mouseX), 10, 40)
        --love.graphics.print("mouse y: "..tostring(mouseY), 10, 60)

        -- love.graphics.print("offset x: "..tostring(XOffset), 10, 90)
        -- love.graphics.print("scale factor: "..tostring(ScaleFactor), 10, 110)

        --love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 1080, 10)
    love.graphics.pop()

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, XOffset - 1, love.graphics.getHeight())
    love.graphics.rectangle("fill", screenX * ScaleFactor + XOffset + 1, 0, XOffset - 1, love.graphics.getHeight())
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
