-- Player
local entitySystem = require('ul-base.EntitySystem')
local PLAYER = entitySystem:new()

function PLAYER:place(x, y)
	-- Player
	self.speed = 200
	self.jumpSpeed = 12
	self.jumpTimes = 2
	self.tempJump = 0

	self.jumpFlag = false
	self.jKeyPressed = false
	self.JUMPING = false

	self.pos_x = x
	self.pos_y = y
	self.GRAVITY = true
	
	-- Bounding box
	self:createBBox(8,16)
	
	-- Player sprite
	self.player_w = self.BBOX.w
	self.player_h = self.BBOX.h
	self.player_color = {255, 255, 255, 255}

	-- Debug
	self.step_size = 1
	
	
end

function PLAYER:setPlayer(n)
	self.num = n
	
	self.left_key = "a"
	self.right_key = "d"
	self.jump_key = "space"

	self.debug_up = "up"
	self.debug_down = "down"
	self.debug_left = "left"
	self.debug_right = "right"
	
	self.debug_stepUp = "u"
	self.debug_stepDown = "j"

	self.debug_gravity = "p"
	self.debug_return = "k"
end

function PLAYER:debug()
	if love.keyboard.isDown(self.debug_up) then
		self.pos_y = self.pos_y - self.step_size
	end
	if love.keyboard.isDown(self.debug_down) then
		self.pos_y = self.pos_y + self.step_size
	end
	if love.keyboard.isDown(self.debug_right) then
		self.pos_x = self.pos_x + self.step_size
	end
	if love.keyboard.isDown(self.debug_left) then
		self.pos_x = self.pos_x - self.step_size
	end
	if love.keyboard.isDown(self.debug_stepUp) then
		self.step_size = self.step_size + 1
	end
	if love.keyboard.isDown(self.debug_stepDown) then
		self.step_size = self.step_size - 1
	end
	if love.keyboard.isDown(self.debug_gravity) then
		self.GRAVITY = not self.GRAVITY
	end
	if love.keyboard.isDown(self.debug_return) then
		self.pos_x = 100
		self.pos_y = 100
	end	


end


function PLAYER:movement(dt)
	self.mov = 0
	if love.keyboard.isDown(self.left_key) then
		self.mov = self.mov - 1
	end
	if love.keyboard.isDown(self.right_key) then
		self.mov = self.mov + 1
	end


	self:jump()

	
	self.hsp = self.mov * math.ceil(self.speed * dt)
end

function PLAYER:jump()
	
	self.jKeyHeld = love.keyboard.isDown(self.jump_key)
	if love.keyboard.isDown(self.jump_key) and not (self.jKeyPressed) then
		self.jKey = true
		self.jKeyPressed = true
	elseif love.keyboard.isDown(self.jump_key) then
		self.jKey = false
	else
		self.jKey = false
		self.jKeyPressed = false
	end

	--set vars
	if not (self.vsp == 0) then
		self.GROUNDED = false
	end

	if self.GROUNDED then
		self.HIT = false
		self.JUMPING = false
		self.tempJump = self.jumpTimes
		self.jumpFlag = true
	end
	

	if not (self.vsp == 0) and not self.JUMPING and self.jumpFlag then
		self.tempJump = self.tempJump - 1
		self.jumpFlag = false
	end

	if self.jKey and self.tempJump > 0 and not HIT then
		self.j = self.jumpSpeed
		self.vsp = -self.j
		self.JUMPING = true
		self.tempJump = self.tempJump - 1
	end
	
	if self.vsp < 0 and not self.jKeyHeld and self.JUMPING then
		self.vsp = math.max(self.vsp, -self.jumpSpeed/3)
	end

	
	
end

function PLAYER:draw()
	love.graphics.setColor(self.player_color)
	love.graphics.rectangle("fill", self.pos_x, self.pos_y, self.player_w, self.player_h)
end

return PLAYER
