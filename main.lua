local state

local screenX, screenY = 1200, 900

XOffset = 0
ScaleFactor = 0

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

        love.graphics.print('Here goes nothing! (^v^)', 10, 10)
        love.graphics.print("mouse x: "..tostring(mouseX), 10, 40)
        love.graphics.print("mouse y: "..tostring(mouseY), 10, 60)

        -- love.graphics.print("offset x: "..tostring(XOffset), 10, 90)
        -- love.graphics.print("scale factor: "..tostring(ScaleFactor), 10, 110)

        love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 1090, 10)
    love.graphics.pop()

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, XOffset - 1, love.graphics.getHeight())
    love.graphics.rectangle("fill", screenX * ScaleFactor + XOffset + 1, 0, XOffset - 1, love.graphics.getHeight())
end
