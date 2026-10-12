local map = require("core.map")

game = {
    
}

function love.load()
    game.map = map:create(10, 10, 32)
end

function love.update(dt)
    game.map:update(dt)
end

function love.draw()
    game.map:draw()
end

function love.wheelmoved(x, y)
    game.map:scroll(y)
end

function love.mousepressed(x, y, button)
    if button == 2 then
        game.map:rightClicked(x, y)
    end
end