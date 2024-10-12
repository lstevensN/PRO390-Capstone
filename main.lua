local state

-- General Config
love.graphics.setDefaultFilter('nearest', 'nearest')

function love.resize(w, h)
    -- Resolution stuff here?
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
    love.graphics.print('Here goes nothing! (^v^)', 10, 10)
    
    state.draw()
end
