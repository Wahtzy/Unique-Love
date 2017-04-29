---Entity system
local ENTITY = 
{
	pos_x = 0,
	pos_y = 0,
	hsp = 0,
	vsp = 0,
	bbox_w = 0,
	bbox_h = 0,
	colFloor = 500,
	
	TAGS = {}
}
require('BoundingBox')

---Creates new entity
--@param o object to initialize as an entity
--@return Returns initialized object
function ENTITY:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

---Places the entity at a coordinate
--@param x x-coordinate to create entity at
--@param y y-coordinate to create entity at
function ENTITY:place(x,y)
	self.pos_x = x
	self.pos_y = y
end


---Take a hit
--@param n amount of damage to take
function ENTITY:hit(n)
	self.hp = self.hp - n
end

---Checks for collisions with other entities
--@param other other entity to check collisions with
--@return Returns true if collided and false if not
function ENTITY:collision(other)
	return CheckCollision	(self.pos_x, self.pos_y, self.width, self.height,
							other.pos_x, other.pos_y, other.width, other.height)
end

---
function ENTITY:gravity(dt)
	if self.vsp < globalVar.gravityMax then
		self.vsp = self.vsp + (globalVar.gravityAccel * dt)
	end
	
	if self.pos_y + self.vsp >= self.colFloor then
		if self.vsp > 0 then
			while 1 + self.pos_y < self.colFloor do
				self.pos_y = self.pos_y + 1
			end
		elseif self.vsp < 0 then
			while -1 + self.pos_y < self.colFloor do
				self.pos_y = self.pos_y - 1
			end
		end
		self.vsp = 0
	end
end

---Step function, to be called each frame this entity should be updated
function ENTITY:step(dt)
	if not self.TAGS['FIXED'] == true then
		self:gravity(dt)
		self.pos_x = self.pos_x + self.hsp
		self.pos_y = self.pos_y + self.vsp
	end
end


---This function is called when the entity is destroyed
function ENTITY:destroy()
	self = nil
end

function ENTITY:getX()
	return self.pos_x
end

function ENTITY:setX(n)
	self.pos_x = n
end

function ENTITY:getY()
	return self.pos_y
end

function ENTITY:setY(n)
	self.pos_y = n
end


---Sets a tag to this entity
--@param name String with name of the tag to set
--@param n Boolean to set the tags state to
--@return boolean if tag was set
function ENTITY:setTag(name, n)
	self.TAGS[name] = n
	if not n == nil then
		return true
	else
		return false
	end
end

---Gets a set tag from this entity
--@param name Name of tag to get
--@return boolean with state of tag
function ENTITY:getTag(name)
	return self.TAGS[name]
end



return ENTITY
