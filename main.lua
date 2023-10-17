player = {}

function player:new()
	self.size = 25
	self.x = 50
	self.y = 50
	self.xSpeed = 0
	self.ySpeed = 0
	self.airborne = false
	self.apex = 15
	self.direction = 0
	self.dead = false
	self.idle = false
	return self
end

function player:jump()
	local yStart = self.y
	self.airborne = true
	self.ySpeed = 3
	while self.ySpeed ~= 0 do
		if self.y == self.apex then
			self.ySpeed = -3
		end
		if self.y == yStart then
			self.airborne = false
			self.ySpeed = 0
		end
	end
end

function player:moveX(direction)
	self.direction = direction
	if self.direction == 0 then
		self.xSpeed = -5
	end
	if self.direction == 1 then
		self.xSpeed = 5
	end
end

function player:stopMovingX()
	self.xSpeed = 0
end

local myPlayer = player:new()

function love.keypressed(key, scancode)
	if key == "a" then
		myPlayer:moveX(0)
	end
	if key == "d" then
		myPlayer:moveX(1)
	end
	if key == "space" or key == "w" then
		myPlayer:jump()
	end
end

function love.keyreleased(key)
	if key == "a" then
		if myPlayer.xSpeed ~= 0 then
			myPlayer:stopMovingX()
		end
	end
	if key == "d" then
		if myPlayer.xSpeed ~= 0 then
			myPlayer:stopMovingX()
		end
	end
end

-- Load player onto screen
-- function love.load()
-- 	player = love.graphics.newImage("")
-- end
