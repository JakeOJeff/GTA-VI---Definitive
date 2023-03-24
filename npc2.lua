local class = require("middleclass")
npc = class("npc")
local npcs = {}



function npc:initialize(name,x,y,dialog,img,dead,hasMission,mission,health)
    self.name = name
    self.x = x 
    self.y = y 
    self.dialog = dialog 
    self.img = img
    self.destroyed = false
    self.dead = dead
    self.died = false
    self.hasMission = hasMission
    self.health = 100 or health
    if self.hasMission == true then
        self.mission = mission
        self.missionaccepted = false
        self.failed = false
    end
    table.insert(npcs,self) 
    return self
end

function npc:update(dt)
    blood:update(dt)

    -- Proximity
    local npcPrompt = false
    if math.vdist(char.x,char.y,id.x,id.y) < 50 then 
        npcPrompt = true 
    else
        npcPrompt = false
    end
    for a,b in ipairs(bullets) do
        
        if b.x > id.x and b.x < id.x + id.img:getWidth() and b.y > id.y and b.y < id.y + id.img:getHeight() and not id.died then
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