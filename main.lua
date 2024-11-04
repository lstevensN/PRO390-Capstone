local state
local rs = require "resolution_solution" ---@type ResolutionSolution

local screenX, screenY = 1200, 900

local XOffset = 0
local ScaleFactor = 0

local mouseX, mouseY = 0, 0

local bars = love.graphics.newImage("game/assets/lancer_placeholder.png")

function love.resize(w, h) end

function love.load()
    require("game.state")

    state = GameState()
    state.load()

    love.window.setTitle('PRO-390 Capstone')

    local _, _, flags = love.window.getMode()

    local width, height = love.window.getDesktopDimensions(flags.display)

    if screenX > width or screenY > height then love.window.setMode(width, height, {resizable = true})
    else love.window.setMode(screenX, screenY, {resizable = true}) end
end

-- Main Game Loop
function love.update(dt)
    -- Update game here
    state.update(dt)

    mouseX, mouseY = love.mouse.getPosition()

    ScaleFactor = love.graphics.getHeight() / screenY
    XOffset = (love.graphics.getWidth() - screenX) / 2
end

function love.draw()
    love.graphics.push()
        love.graphics.setColor(1, 1, 1)
        love.graphics.setBackgroundColor(0, 0, 0)

        love.graphics.print('Here goes nothing! (^v^)', 10 + XOffset, 10 * ScaleFactor)
        love.graphics.print("mouse x: "..tostring(mouseX), 10 + XOffset, 40 * ScaleFactor)
        love.graphics.print("mouse y: "..tostring(mouseY), 10 + XOffset, 60 * ScaleFactor)

        -- love.graphics.print("offset x: "..tostring(XOffset), 10 + XOffset, 90 * ScaleFactor)
        -- love.graphics.print("scale factor: "..tostring(ScaleFactor), 10 + XOffset, 110 * ScaleFactor)

        love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 1090 + XOffset, 10 * ScaleFactor)

        state.draw()
    love.grpahics.pop()

    --love.graphics.setColor(0, 0, 0)
    --love.graphics.rectangle("fill", 0, 0, XOffset, love.graphics.getHeight())
    --love.graphics.rectangle("fill", screenX + XOffset, 0, XOffset, love.graphics.getHeight())
    --love.graphics.draw(bars, 0, 0, 0, 1, screenY / 500 * ScaleFactor)
end
