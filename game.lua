    -- ================================================================
    -- GTA VI : Definitive FANMADE | JakeOJeff#0001 Licensed
    -- ================================================================
    local game = {}
    local menu = require('menu')

    function game.init()
        -- Importing libraries
        window = require ("zam")
        require('libraries/anim')
        require('libraries/custommath')
        require('npc')
        require('car')
        require('acceleration')
        require('map')
        require('config')
    
        character = "trevor" -- Choose your main character here
        body = love.graphics.newImage("characters/"..character.."/body.png") -- Extract chosen characters assets
        flipped = 1 -- Whether character is flipped ( A token value for direction )
        char = {
           x = body:getWidth(),
           y = love.graphics.getHeight() - body:getHeight() - 30,
           direction = "right", -- Direction the character faces
           speedy = 0,
           speed = 0,
           acceleration = 5,
           maxSpeed = 200,
           walk = true,
           isGrounded = false -- Add a flag to know if the character is on the ground
        }
    
        -- INITIALISATION for jumping
        bodyY = char.y 
        bodyX = char.x
    
        -- Loading basic libraries
        npcs = {}
        window:load()
        loadAnim()
        loadCars()
        loadNPCS()
        loadMap()
    
        gravity = 9.8 * 51.020408163265 -- Gravity Global Vars
        shoot = false
        bullets = {}
        ticktime = 0
        font = love.graphics.newFont("fonts/RubberNippleFactoryBlack.ttf", 15)
    
        -- NPC Particle effects
        local img = love.graphics.newImage("characters/npcs/blood.png")
        charBlood = love.graphics.newParticleSystem(img, 32)
        charBlood:setParticleLifetime(1,3)
        charBlood:setLinearAcceleration(-150, char.y + body:getHeight(), 50, bodyY)
        charBlood:setSpeed(32)
    

    end
    
    function game.update(dt)
        -- ================================================================
        -- Updation of Libraries

        bodyX = char.x
        window:update(dt)
        uCars(dt,bullets)
        charBlood:update(dt)
    
        ticktime = ticktime + 1 *dt
        -- ENABLE WALKING AND DRIVING ( SINCE SAME CONTROLS )
        if love.keyboard.isDown("d")  then
            char.direction = "right" flipped = 1
            accelerateVehicle(dt)
            walkN,currentWalkAnim = anim(walk,walkN,currentWalkAnim,dt) -- Setting anims for walk
            gunwalkN,currentgunWalkAnim = anim(gunwalk,gunwalkN,currentgunWalkAnim,dt) -- Setting anims for walking with gun
        elseif love.keyboard.isDown("a") and char.x > body:getWidth() then
            char.direction = "left" flipped = -1
            retardVehicle(dt)   
            walkN,currentWalkAnim = anim(walk,walkN,currentWalkAnim,dt) -- Setting anims for walk
            gunwalkN,currentgunWalkAnim = anim(gunwalk,gunwalkN,currentgunWalkAnim,dt) -- Setting anims for walking with gun
        elseif love.keyboard.isDown("w") then
            jumpN,currentJumpAnim = anim(jump,jumpN,currentJumpAnim,dt)    -- JUMP Anim 
        else
            autoRetard(dt)
            walkN = 1
            gunwalkN = 1
        end
        
        -- Updation of character gravity
        char.speedy = char.speedy + gravity * dt
        -- Update position
        char.y = char.y + char.speedy * dt
        bodyY = bodyY + char.speedy * 2 * dt
        if allenteredCar() then char.x = char.x + char.speed * 10 * dt end
        if char.y > love.graphics.getHeight() - body:getHeight() - 30 then
            char.y = love.graphics.getHeight() - body:getHeight() - 30
            bodyY = char.y
            char.isGrounded = true
        else
            char.isGrounded = false
        end 
    
        -- Gun Animation visibility
        if love.mouse.isDown(1) then
            shoot = true
            gunshootN = 1
            currentgunshoot = gunshoot[gunshootN] -- Animation for shooting
        elseif love.mouse.isDown(2) then
            shoot = true
            gunshootN = 1
            currentgunshoot = gunshoot[gunshootN]
        else
            shoot = false
        end
        -- Bullet Shooting + Updation
        for i = 1,#bullets,1 do
            bullets[i].x = bullets[i].x + bullets[i].speedx * bullets[i].d * dt
        end
        -- Check collision [ Selective npc defintion ( TEMPORARY )]
        bcgprompt = updateNPC(dt, bcg)
    
    end
    
    function game.draw()
        --=====================================================
        -- Drawing
        window:draw() -- Drawing camera movement
        buildMap()
    
        love.graphics.setFont(font)
        dCars1() -- Cars [  Drawing the actual Car ]
        drawNpc(bcg,bcgprompt,bcgpromptenabled)
        if char.visible == true then
        love.graphics.draw(charBlood, bodyX , bodyY + body:getHeight())    
        love.graphics.draw(body, char.x, bodyY,rotation,flipped,1) -- Drawing character body
        if char.walk == true then
        love.graphics.draw(currentWalkAnim, char.x, char.y,rotation,flipped,1) -- Making animation visible
        end
        if shoot == false then -- Determining whether gun animation should be played
        love.graphics.draw(currentgunWalkAnim, bodyX - (5* flipped), bodyY + 20 ,rotation,flipped,1) -- Simple gun walk
        else
            love.graphics.draw(currentgunshoot, bodyX - (5 * flipped), bodyY + 23,rotation,flipped,1) -- Gun is pointed
        end
    
        -- DRAWING the bullets
        for i = 1,#bullets,1 do 
            love.graphics.circle("fill",bullets[i].x,bullets[i].y,1)
        end  
            -- Enabling npc if boolean displays true
        if bcgpromptenabled then
            displayNPC(bcg)
        end
        -- INDIVIDUAL DRAWING ( OR WONT WORK ) , Cars [  Drawing the prompt ]
        van:draw2()
        mustang:draw2()
        end
        -- INDIVIDUAL DRAWING ( OR WONT WORK : Character display is dependent on this ), Cars [  Drawing the character ]
        van:draw3()
        mustang:draw3()
        if allenteredCar() then love.graphics.print(math.floor(char.speed).." kmh \n kms "..math.floor(char.x/10000), char.x + 50 , char.y - 300) end -- Drawing character body
    
    
    end
    
    function game.Umousepressed(x, y, button)
        -- ============================================
        -- SHOOTING GUNS and movement of tiles(camera)
        if button == 1 then -- Checks if is not in car while Gun input is given
            newBullet()   -- Shoot the bullet
            print("Pew")
            gunshootN = 2 -- Setting gunshot animation id
            currentgunshoot = gunshoot[gunshootN]
        elseif button == 2 and not allenteredCar() then -- Checks same input, goal is to point the gun
            gunshootN = 2 -- Setting gunshot pointing animation id
            currentgunshoot = gunshoot[gunshootN]
        
        end
    end
    
    
    function game.Ukeypressed(key)
        -- ================================
        -- Keypressed functions ( Jumping, Entering Car, Chatting w/ NPCS )
        if key == "w" and char.isGrounded and not allenteredCar() then -- Add jump if on the ground  
            char.speedy = -200 -- Pushes off ground
            emitBlood()
            bodyY = char.y
            char.isGrounded = false
        elseif key == "f" and not allisDestroyed() then -- Car entering function
            enterCorrespondingCar() -- Exits or enters nearby cars
        elseif key == "r"  then -- Car entering function
            fixCorrespondingCar() -- Exits or enters nearby cars
        elseif key == "e"  then -- NPC Chat
           if bcgprompt == true then -- Chats if (temporary) npc BCG is there
              bcgpromptenabled = true
           end
        elseif key == "escape" then
            myButt.code()
            menu.init(true)

        end
    end
    
    -- ======================
    -- Blood emition function
    function emitBlood()
        charBlood:emit(512)
    end
    
    
    
return game
    
