-- General Config
love.graphics.setDefaultFilter('nearest', 'nearest')

function love.resize(w, h)
    -- Resolution stuff here?
end

function love.load()
    require("game.print")
    require("game.input")

    love.window.setTitle('PRO-390 Capstone')

    love.keyboard.keysPressed = {}
end

-- Main Game Loop
function love.update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.print('Here goes nothing! (^v^)', 10, 10)
    drawWord()
end
