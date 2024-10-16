local state
local rs = require "resolution_solution" ---@type ResolutionSolution

local mouseX, mouseY = 0, 0

ResScale = 1

rs.conf({
    game_width = 800,
    game_height = 600,
    scale_mode = rs.ASPECT_MODE
})

rs.setMode(rs.game_width, rs.game_height, {resizable = true})

local game_canvas = love.graphics.newCanvas(rs.get_game_size())

function love.resize(w, h)
    rs.resize(w, h)
end

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
    ResScale = rs.scale_width
end

function love.draw()
    love.graphics.setCanvas(game_canvas)
    love.graphics.clear(0, 0, 0, 1)
    
    love.graphics.print('Here goes nothing! (^v^)', 10, 10)
    love.graphics.print("mouse x: "..tostring(mouseX / ResScale), 10, 40)
    love.graphics.print("mouse y: "..tostring(mouseY / ResScale), 10, 60)

    state.draw()

    love.graphics.setCanvas()

    rs.push()
        love.graphics.draw(game_canvas)
    rs.pop()
end
