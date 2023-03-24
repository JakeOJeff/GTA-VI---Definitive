
require('middleclass')
require('libraries/anim')
local img = love.graphics.newImage("characters/npcs/blood.png")

local blood = love.graphics.newParticleSystem(img, 32)
 blood:setParticleLifetime(2,5)
 blood:setLinearAcceleration(-5, -5, 50, 100)
currentbulletX = 0
currentbulletY = 0

function newNPC(name,x,y,dialog,img,dead,hasMission,mission,health)
    npc = {}
    npc.name = name
    npc.x = x 
    npc.y = y 
    npc.dialog = dialog 
    npc.img = img
    npc.destroyed = false
    npc.dead = dead
    npc.died = false
    npc.hasMission = hasMission
    npc.health = 100 or health
    if npc.hasMission == true then
        npc.mission = mission
        npc.missionaccepted = false
        npc.failed = false
    end

    table.insert(npcs,npc) 
    return npc
end

function updateNPC(dt, id)
    blood:update(dt)

    -- Proximity
    local npcPrompt = false
    if math.vdist(char.x,char.y,id.x,id.y) < 50 then 
        npcPrompt = true 
    else
        npcPrompt = false
    end
    for a,b in ipairs(bullets) do
        
        if b.x > id.x + 10 and b.x < (id.x + id.img:getWidth()) - 10 and b.y > id.y and b.y < id.y + id.img:getHeight() and not id.died then
            table.remove(bullets,a)
             id.health = id.health - 5
             setBullet(b.x + bulletD() ,b.y)
             emit()

        end
        
     end

     if npcpromptenabled == true then
        id.missionaccepted = true
     end
    if id.health < 0 then
        id.died = true
        if id.missionaccepted == true then 
           npc.failed = true
        end
    end
     
    return npcPrompt
end

function drawNpc(id, npcprompt, npcpromptenabled)
    if not id.died then
if npcprompt == true and npcpromptenabled == false then
    love.graphics.setColor(0,0,0)

 love.graphics.print("Press 'e' to talk to "..id.name,id.x,id.y - 50)
 love.graphics.setColor(1,1,1)

end
end
if not id.died then
 love.graphics.draw(id.img,id.x,id.y)
else
    love.graphics.draw(id.dead,id.x,id.y)
end
love.graphics.draw(blood, currentbulletX, currentbulletY)

end

function displayNPC(id)
    if not id.died then
    if math.vdist(char.x,char.y,id.x,id.y) < 50 then
    love.graphics.print(id.dialog,id.x,id.y - 50)
    end
end
end

function emit()
    blood:emit(512)
end

function setBullet(x,y)
    currentbulletX = x
    currentbulletY = y
end

function loadNPCS()
    bcg = newNPC("BCG",1000,char.y,
        "Hey there rookie, i want you to kill the following \n - ELITE \n - GALAXY \n - MIKE",
        love.graphics.newImage("characters/npcs/bcg.png"),love.graphics.newImage("characters/npcs/bcgdead.png"),true,
        {mission1 = {type = "assasination",target = "ELITE"}})
    bcgpromptenabled = false
end