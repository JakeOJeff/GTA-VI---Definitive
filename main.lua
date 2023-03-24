    -- ================================================================
    -- GTA VI : Definitive FANMADE | JakeOJeff#0001 Licensed
    -- ================================================================
local game = require('game')
local menu = require('menu')

function love.load()
   menu.init()
   game.init()
   m = menu

end

function love.update(dt)
    if not m.v then
       game.update(dt)
    end
    menu.update(dt)

end

function love.draw()
    if not m.v then
    game.draw()
    end
    menu.draw()

end

function love.mousepressed(x, y, button)
    if not m.v then
     game.Umousepressed(x, y, button)
    end
end

function love.keypressed(key)
    if not m.v then
      game.Ukeypressed(key)
    end
end





