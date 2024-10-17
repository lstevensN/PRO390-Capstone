local state
local rs = require "resolution_solution" ---@type ResolutionSolution

local screenX, screenY = 1200, 900

XScaleFactor = 0
YScaleFactor = 0

local mouseX, mouseY = 0, 0

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

    XScaleFactor = love.graphics.getWidth() / screenX
    YScaleFactor = love.graphics.getHeight() / screenY
end

function love.draw()   
    love.graphics.print('Here goes nothing! (^v^)', 10 * XScaleFactor, 10 * YScaleFactor)
    love.graphics.print("mouse x: "..tostring(mouseX), 10 * XScaleFactor, 40 * YScaleFactor)
    love.graphics.print("mouse y: "..tostring(mouseY), 10 * XScaleFactor, 60 * YScaleFactor)

    love.graphics.print("scale x: "..tostring(XScaleFactor), 10 * XScaleFactor, 90 * YScaleFactor)
    love.graphics.print("scale y: "..tostring(YScaleFactor), 10 * XScaleFactor, 110 * YScaleFactor)

    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 1090 * XScaleFactor, 10 * YScaleFactor)

    state.draw()
end
