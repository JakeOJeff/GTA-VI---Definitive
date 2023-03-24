require('car')
function accelerateVehicle(dt)
    if not allenteredCar() then
        char.x = char.x + 100 * dt
    else
        moveWheelsR(dt) -- Moving car wheels ( If in car ) [ RIGHT ]
        if char.speed < char.maxSpeed then
        if char.speed < 150 then
            char.speed = char.speed + char.acceleration * 3.5 * dt
        else
            char.speed = char.speed + char.acceleration * dt
        end
        end
    end
end


function retardVehicle(dt)
    if not allenteredCar() then
        char.x = char.x - 100 * dt
    else
        moveWheelsL(dt) -- Moving car wheels ( If in car ) [ LEFT ]
        if char.speed > 1 then
            char.speed = char.speed - (char.acceleration * 10) * dt
        else
            char.speed = char.speed - (char.acceleration/2) * dt
        end
    end    
end
function autoRetard(dt)
    if allenteredCar() then
        if char.speed > 1 then
            moveWheelsR(dt)
            char.speed = char.speed - char.acceleration * dt
        elseif char.speed < -1 then
            moveWheelsL(dt)
            char.speed = char.speed + char.acceleration * dt
        else
            char.speed = 0
        end
    end
end