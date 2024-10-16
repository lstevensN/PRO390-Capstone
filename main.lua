local state
local rs = require "resolution_solution" ---@type ResolutionSolution

rs.conf({
    game_width = 800,
    game_height = 600,
    scale_mode = rs.ASPECT_MODE
})

rs.setMode(rs.game_width, rs.game_height, {resizable = true})

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
end

function love.draw()
    rs.push()
    local old_x, old_y, old_w, old_h = love.graphics.getScissor()
    love.graphics.setScissor(rs.get_game_zone())

    love.graphics.print('Here goes nothing! (^v^)', 10, 10)
    state.draw()

    love.graphics.setScissor(old_x, old_y, old_w, old_h)
    rs.pop()
end
