local menu = {}
require('button')
menufont = love.graphics.newFont("fonts/RubberNippleFactoryBlack.ttf", 15)
menuBG = love.graphics.newImage("world/bg.png")

function menu.init(state)
   menu.v = state
   myButt = button:new()
   music = love.audio.newSource( 'music/theroad.mp3', 'stream' )

   if music:isPlaying() then
      music:stop()
   end

   myButt.text = "Play"

   myButt.x = love.graphics.getWidth()/2 - myButt.width/2
   myButt.y = love.graphics.getHeight()/2 - myButt.height/2

   options = button:new()
   options.text = "⚙️Options"

   options.x = love.graphics.getWidth()/2 - myButt.width/2 
   options.y = love.graphics.getHeight()/2 - myButt.height/2 + 45

   myButt.code = 
   function()
    menu.v = false
    if music:isPlaying() then
      music:stop()
    else
      music:play()
   end
   end
end

function menu.update(dt)
   myButt:update(dt)
   options:update(dt)

end

function menu.draw()
   love.graphics.setFont(menufont)
    if menu.v == true then
      love.graphics.draw(menuBG,0,0)

       myButt:draw()
       options:draw()

    end
end

    
return menu
