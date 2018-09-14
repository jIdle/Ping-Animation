-- Ping-Animation

function love.load()
	MIN = math.exp(9)
	MAX = math.exp(17)
	NORM = math.sqrt(math.pow(MIN, 2) + math.pow(MAX, 2))
	ping = {
		x = 0,
		y = 0,
		radius = 0,
	}
	function ping:draw()
		if self.radius > math.exp(17) then
			return 0
		end
		
		love.graphics.setColor(255, 255, 255)
		if 10*math.log(self.radius) < 90 then
			self.radius = self.radius + 1
		else
			normRad = self.radius/NORM
			self.radius = self.radius - (self.radius * (normRad * 0.7 + .0015625))
		end
		love.graphics.circle("line", self.x, self.y, 10*math.log(self.radius), 10000)
		return 1
	end
	ping.__index = ping
	pArray = {}
end

function love.update(dt)
end

function love.draw()
	for i = 1, #pArray do
		if pArray[i]:draw() == 0 then
			pArray[i] = nil
		end
	end
end

function love.wheelmoved(x, y)
	mouseX = love.mouse.getX()
	mouseY = love.mouse.getY()
	for i = 1, #pArray do
		mouseDist = math.sqrt(math.pow((mouseX-pArray[i].x), 2) + math.pow((mouseY-pArray[i].y), 2))
		if mouseDist <= 10*math.log(pArray[i].radius) then
			if y < 0 then
				pArray[i].radius = pArray[i].radius - (pArray[i].radius * (0.5))
			elseif y > 0 then
				pArray[i].radius = pArray[i].radius + (pArray[i].radius * (0.5))
			end
			
		end
	end
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		local ping = setmetatable({}, ping)
		ping.x = x
		ping.y = y
		pArray[#pArray + 1] = ping
	end
end