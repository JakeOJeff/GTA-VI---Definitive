local class = require("middleclass")
button = class("button")
local buttons = {}
lg = love.graphics


local normal = lg.newImage('world/myButtNormal.png')
local hover = lg.newImage('world/myButtHover.png')
local click = lg.newImage('world/myButtClick.png')

function button:initialize(text, code, x, y)

	self.code = code or (function() sampleCode = "hello" sampleCodeVal = sampleCodeVal + 1 end)
	self.text = text or "Button"
	self.x = x or 19
	self.y = y or 25

	self.font = love.graphics.getFont()
	self.width = normal:getWidth()
	self.height = normal:getHeight()

	self.image = normal
	table.insert(buttons, self)
	return self


end

function button:update()
	local x, y = love.mouse.getPosition()
	if x < self.x + self.width and x > self.x and y < self.y + self.height and y > self.y then 
		if not love.mouse.isDown(1) then
			self.image = hover
	        else
			love.timer.sleep(0.2)
			self.image = click
			self.code()
		end
	else
		self.image = normal
	end 
end

function button:draw()
	lg.draw(self.image,self.x,self.y)
	love.graphics.print(self.text, self.x + self.width/2 - (self.font:getWidth(self.text)/2) - 4, self.y + self.height/2 - (self.font:getHeight(self.text)/2))
	love.graphics.setColor(1,1,1)
end 

function update_buttons()
	for i, v in pairs(buttons) do
		v:update()
	end
end

function draw_buttons()
	for i, v in pairs(buttons) do
		v:draw()
	end 
end
