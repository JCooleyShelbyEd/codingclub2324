player = {}

function player:new()
	self.size = 25
	self.x = 50
	self.y = 50
	self.xSpeed = 0
	self.ySpeed = 0
	self.airborne = false
	self.apex = 150
	self.xDirection = 0
	self.dead = false
	self.idle = false
	self.jumping = false
	self.yStartJump = 0
	self.yDirection = 0
	return self
end

function player:jump()
	self.airborne = true
	self.jumping = true
	self.ySpeed = 3
	self.yStartJump = self.y
	self.yDirection = 1
end

function player:moveX(direction)
	self.xDirection = direction
	if self.xDirection == 0 then
		self.xSpeed = -5
	end
	if self.xDirection == 1 then
		self.xSpeed = 5
	end
end

function player:stopMovingX()
	self.xSpeed = 0
end

local myPlayer = player:new()

[[Will love.keypressed() fire every frame as long as it's held down or only on the first frame it's pressed?
Also, would it make more sense to check for user input in the Update function so that it runs those checks every frame?]]

function love.keypressed(key, scancode) 
	if key == "a" then
		myPlayer:moveX(0)
	end
	if key == "d" then
		myPlayer:moveX(1)
	end
	if key == "q" then
		love.event.quit()
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
	if key == "space" then
		myPlayer:jump()
	end
end

screenWidth = 500
screenHeight = 500

-- Load graphics on screen
function love.load()
	p1 = love.graphics.newImage("player.png") -- I assume this is just placeholder text for when we have the file and directory
	myPlayer.x = (screenWidth * myPlayer.x) / 100
	myPlayer.y = (screenHeight * myPlayer.y) / 100
	love.window.setMode(screenWidth, screenHeight)
	myPlayer.yStartJump = myPlayer.y
end

[[In the Update function, it's often best to avoid directly setting a variable like myPlayer.x because Update runs every frame.
This can cause the program to set a value for that frame before input is received in love.keypressed() and love.keyreleased().
Instead, it may be better to check for user input with if statements in Update(), then call the separate MoveX() and Jump() functions
which handle the movement. In my experience with Unity, Update() is mostly used for checking input and checking states, then calling
other functions to do what you want based on the results of those checks. The logic for setting variables and values should probably
be in separate functions. Again, love2D may handle this entirely differently though.]]

function love.update()
	myPlayer.x = myPlayer.x + myPlayer.xSpeed
	if myPlayer.yDirection == 1 then
		myPlayer.y = myPlayer.y - myPlayer.ySpeed
	end
	if myPlayer.yDirection == 0 then
		myPlayer.y = myPlayer.y + myPlayer.ySpeed
	end
	if myPlayer.jumping and myPlayer.y < myPlayer.yStartJump - myPlayer.apex then
		myPlayer.yDirection = 0
		myPlayer.falling = true -- I don't see this variable defined in the player:new() function
		myPlayer.jumping = false
	end
	if myPlayer.falling and myPlayer.y == myPlayer.yStartJump then
		myPlayer.ySpeed = 0
	end
end

function love.draw()
	love.graphics.draw(p1, myPlayer.x, myPlayer.y)
end
