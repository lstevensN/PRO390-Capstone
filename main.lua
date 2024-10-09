if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end

local state

-- General Config
love.graphics.setDefaultFilter('nearest', 'nearest')

function love.resize(w, h)
    -- Resolution stuff here?
end

function love.load()
    state = require "game.state"
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
