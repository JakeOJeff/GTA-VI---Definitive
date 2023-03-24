require('car')

function anim(table,inputN,currenttableval, dt, playing)
    local playing = playing or true
    if playing == true then 
    if inputN < #table then
        inputN = inputN + 8 * dt
        currenttableval = table[math.floor(inputN)]
    else
        inputN = 1
        currenttableval = table[inputN]
    end
end
    return inputN,currenttableval

end

function loadAnim()
    walk = {}
    for i = 1,4,1 do
        walk[i] = love.graphics.newImage("characters/"..character.."/walk/"..i..".png")
    end
    walkN = 1
    currentWalkAnim = walk[walkN]

    jump = {}
    for i = 1,1,1 do
        jump[i] = love.graphics.newImage("characters/"..character.."/jump/"..i..".png")
    end
    jumpN = 1
    currentJumpAnim = jump[jumpN]

    gunwalk = {}
    for i = 1,2,1 do
        gunwalk[i] = love.graphics.newImage("characters/"..character.."/gunwalk/"..i..".png")
    end
    gunwalkN = 1
    currentgunWalkAnim = gunwalk[gunwalkN]

    gunshoot = {}
    for i = 1,3,1 do
        gunshoot[i] = love.graphics.newImage("characters/"..character.."/shoot/"..i..".png")
    end
    gunshootN = 1
    currentgunshoot = gunshoot[gunshootN]

end

function newBullet()
    bullet = {}
    if char.direction == "left" then bullet.d = -1 else bullet.d = 1 end
    bullet.x = (char.x + body:getWidth() * bullet.d) - 10 * bullet.d
    bullet.y = char.y + 30 
    bullet.speedx = 300
    table.insert(bullets,bullet)
   return(bullet)
end

function bulletD()
 return bullet.d
end