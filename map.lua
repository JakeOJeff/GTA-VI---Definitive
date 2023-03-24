require('config')
function loadMap()
    -- ROAD
    roadImg = love.graphics.newImage("world/road.png")
    roadgradient = love.graphics.newImage("world/roadgradient.png")
    roadreversegradient = love.graphics.newImage("world/roadreversegradient.png")
    roaddesert = love.graphics.newImage("world/roaddesert.png")
    roadlunargradient = love.graphics.newImage("world/roadlunargradient.png")
    roadreverselunargradient = love.graphics.newImage("world/roadreverselunargradient.png")
    roadlunar = love.graphics.newImage("world/roadlunar.png")

    --SKY
    skyImg = love.graphics.newImage("world/sky.png")
    skylunargradient = love.graphics.newImage("world/skylunargradient.png")
    skyreverselunargradient = love.graphics.newImage("world/skyreverselunargradient.png")
    lunarskyImg = love.graphics.newImage("world/lunarsky.png")

    --OBJECTS
    moon = love.graphics.newImage("world/moon.png")
    building1 = love.graphics.newImage("world/building.png")

end

function drawMap(id, min, max)
    for i = min,max,1 do
        love.graphics.draw(id,id:getWidth()*i,0 - 100) -- Background
    end
end

function drawBg(id, min, max)
    for i = min,max,1 do
        love.graphics.draw(id,id:getWidth()*i,0 - 100) -- Background
     end
end

function drawObj(id, min, max)
    for i = min,max,1 do
        love.graphics.draw(id,id:getWidth()*i,0 - 100) -- Background
     end
end
function drawPermObj(id, min, max)
    if char.x > (min-1) * id:getWidth() and char.x < max  * id:getWidth() then
        love.graphics.draw(id,char.x - 600,0) -- Background
    else
        love.graphics.draw(id,max * id:getWidth() - 600,0) -- Background
    end
end
function buildMap()
    mapConfig()
end