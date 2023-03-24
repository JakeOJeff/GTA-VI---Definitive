local menu = {}
require('button')


function menu.init()
   menu.v = true
   myButt = button:new()
   myButt.text = "Play"
   myButt.code = 
   function()
    menu.v = false
   end
end

function menu.update(dt)
   myButt:update(dt)
end

function menu.draw()
    if menu.v == true then
       myButt:draw()
    end
end

    
return menu