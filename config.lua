require('car')
function loadCars()

    -- ======================================
    -- This is where you load the Cars

    van = car:new()
    van.body = love.graphics.newImage("cars/car-full.png")
    van.wheel = love.graphics.newImage("cars/wheel.png")
    van.destructed = love.graphics.newImage("cars/car-destroyed.png")
    van.y = love.graphics.getHeight() - 100

    mustang = car:new()
    mustang.body = love.graphics.newImage("cars/mustang.png")
    mustang.wheel = love.graphics.newImage("cars/mustangWheel.png")
    mustang.destructed = love.graphics.newImage("cars/mustangDestroyed.png")
    mustang.wheel1y = mustang.y + 60
    mustang.wheel2y = mustang.y + 60
    mustang.wheel2x = mustang.x + 50
    mustang.x = 1200

    
end

function mapConfig()

    -- ======================================
    -- This is where you draw the map ( drawMap(img, starting position, ending position))
    drawBg(skyImg, 0, 10)
    drawBg(skylunargradient, 11, 11)
    drawBg(lunarskyImg, 12, 27)
    drawBg(skyreverselunargradient, 28, 28)
    drawBg(skyImg, 29, 50)

    drawMap(roadImg, 0, 2)
    drawMap(roadgradient, 3, 3)
    drawMap(roaddesert, 4, 7)
    drawMap(roadreversegradient, 8, 8)
    drawMap(roadImg, 9, 10)
    drawMap(roadlunargradient, 11, 11)
    drawMap(roadlunar, 12, 27)
    drawMap(roadreverselunargradient, 28, 28)
    drawMap(roadImg, 29, 50)

    drawPermObj(moon, 11.5, 27.5)

    drawObj(building1, 13,13)


end