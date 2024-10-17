local state
local rs = require "resolution_solution" ---@type ResolutionSolution

local screenX, screenY = 800, 600

XScaleFactor = 0
YScaleFactor = 0

local mouseX, mouseY = 0, 0

function love.resize(w, h) end

function love.load()
    require("game.state")

    state = GameState()
    state.load()

    love.window.setTitle('PRO-390 Capstone')
    love.window.setMode(screenX, screenY, {resizable = true})
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
    love.graphics.print('Here goes nothing! (^v^)', 10, 10)
    love.graphics.print("mouse x: "..tostring(mouseX), 10, 40)
    love.graphics.print("mouse y: "..tostring(mouseY), 10, 60)

    love.graphics.print("scale x: "..tostring(XScaleFactor), 10, 90)
    love.graphics.print("scale y: "..tostring(YScaleFactor), 10, 110)

    state.draw()
end
