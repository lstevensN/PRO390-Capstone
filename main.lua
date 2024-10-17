local state
local rs = require "resolution_solution" ---@type ResolutionSolution

local mouseX, mouseY = 0, 0

rs.conf({
    game_width = 1000,
    game_height = 800,
    scale_mode = rs.ASPECT_MODE
})

rs.setMode(rs.game_width, rs.game_height, {resizable = true})

local game_canvas = love.graphics.newCanvas(rs.get_game_size())

local mouse_getPosition = love.mouse.getPosition
love.mouse.getPosition = function ()
    local width, height = love.graphics.getDimensions()
    local original_width = 1000
    local original_height = 800
    local sx, sy = width / original_width, height / original_height
    local x, y = mouse_getPosition()
    x = x / sx
    y = y / sy
    return x, y
end

function love.resize(w, h) rs.resize(w, h) end

function love.load()
    require("game.state")

    state = GameState()
    state.load()

    love.window.setTitle('PRO-390 Capstone')
end

-- Main Game Loop
function love.update(dt)
    -- Update game here
    state.update(dt)

    mouseX, mouseY = love.mouse.getPosition()
end

function love.draw()
    love.graphics.setCanvas(game_canvas)
    love.graphics.clear(0, 0, 0, 1)
    
    love.graphics.print('Here goes nothing! (^v^)', 10, 10)
    love.graphics.print("mouse x: "..tostring(mouseX), 10, 40)
    love.graphics.print("mouse y: "..tostring(mouseY), 10, 60)

    state.draw()

    love.graphics.setCanvas()

    rs.push()
        love.graphics.draw(game_canvas)
    rs.pop()
end
