-- Player
local entitySystem = require('EntitySystem')
local PLAYER = entitySystem:new()

function PLAYER:place(x, y)
	-- Player
	self.speed = 150
	self.pos_x = x
	self.pos_y = y
	
	-- Bounding box
	self.bbox_w = 8
	self.bbox_h = 16
	
	-- Player sprite
	self.player_w = bbox_w
	self.player_h = bbox_h
	self.player_color = {255, 255, 255, 255}
	
	
end

function PLAYER:setPlayer(n)
	self.num = n
	
	self.left_key = "a"
	self.right_key = "d"
end

function PLAYER:step(dt)
	self.mov = 0
	if love.keyboard.isDown(self.left_key) then
		self.mov = self.mov - 1
	end
	if love.keyboard.isDown(self.right_key) then
		self.mov = self.mov + 1
	end
	self.hsp = self.mov * (self.speed * dt)
	
	
	self:gravity(dt)
	
	if not self.TAGS['FIXED'] == true then
		self.pos_x = self.pos_x + self.hsp
		self.pos_y = self.pos_y + self.vsp
	end
end

function PLAYER:draw()
	love.graphics.setColor(self.player_color)
	love.graphics.rectangle("fill", self.pos_x, self.pos_y, self.bbox_w, self.bbox_h)
end

return PLAYER