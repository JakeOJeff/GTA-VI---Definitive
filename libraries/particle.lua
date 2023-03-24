local class = require('libraries/middleclass')
local Particle = class('Particle')

function Particle:initialize(x, y, vx, vy, lifetime, color)
  self.x = x
  self.y = y
  self.vx = vx
  self.vy = vy
  self.lifetime = lifetime
  self.color = color or {255, 255, 255}
  self.age = 0
end

function Particle:update(dt)
  self.age = self.age + dt
  self.x = self.x + self.vx * dt
  self.y = self.y + self.vy * dt
end

function Particle:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self.x, self.y, 5)
end

local ParticleSystem = class('ParticleSystem')

function ParticleSystem:initialize()
  self.particles = {}
end

function ParticleSystem:addParticle(x, y, vx, vy, lifetime, color)
  local p = Particle:new(x, y, vx, vy, lifetime, color)
  table.insert(self.particles, p)
end

function ParticleSystem:update(dt)
  for i, p in ipairs(self.particles) do
    p:update(dt)
    if p.age > p.lifetime then
      table.remove(self.particles, i)
    end
  end
end

function ParticleSystem:draw()
  for _, p in ipairs(self.particles) do
    p:draw()
  end
end

function ParticleSystem:stop()
  self.particles = {}
end

return {
  Particle = Particle,
  ParticleSystem = ParticleSystem,
}
