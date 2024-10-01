-- General Config
love.graphics.setDefaultFilter('nearest', 'nearest')

function love.resize(w, h)
    -- Resolution stuff here?
end

function love.load()
    require("game.input")

    love.window.setTitle('PRO-390 Capstone')
end

-- Main Game Loop
function love.update(dt)
    -- Update game here
end

function love.draw()
    love.graphics.print('Here goes nothing! (^v^)', 10, 10)
    drawWord()
end
