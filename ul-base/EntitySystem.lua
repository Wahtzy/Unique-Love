---Entity system
local ENTITY = 
{
	pos_x = 0,
	pos_y = 0,
	hsp = 0,
	vsp = 0,
	colFloor = 500,
	
	BBOX = {},
	
	SOLID = false,
	FIXED = false,
	GRAVITY = false,
	GROUNDED = false,
	HIT = false
}

local bboxsys = require('ul-base.BoundingBox')
local next = next

--- Returns the sign value of given value
function sign(n)
	if n < 0 then return -1
	else return 1
	end
end

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
--@param x x-coordinate to place entity at
--@param y y-coordinate to place entity at
function ENTITY:place(x,y)
	self.pos_x = x
	self.pos_y = y
end

--- Creates a bounding box for the entity
--@param w Width of the bbox
--@param h Height of the bbox
function ENTITY:createBBox(w,h)
	self.BBOX = bboxsys:new()
	self.BBOX.w = w
	self.BBOX.h = h
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
	if other.SOLID == true and not (next(other.BBOX) == nil) then
		if self.BBOX:CheckBBoxColl(self.pos_x,self.pos_y,other) then
			print("Inside object, moving up")
			while (self.BBOX:CheckBBoxColl(self.pos_x,self.pos_y+1,other)) do
				self.pos_y = self.pos_y - 1
			end
		end


		if self.BBOX:CheckBBoxColl(self.pos_x+self.hsp,self.pos_y,other) then
			while not self.BBOX:CheckBBoxColl(self.pos_x + sign(self.hsp),self.pos_y,other) do
				self.pos_x = self.pos_x + sign(self.hsp)
			end
			self.hsp = 0
		end
		if self.BBOX:CheckBBoxColl(self.pos_x,self.pos_y+self.vsp,other) then
			while not (self.BBOX:CheckBBoxColl(self.pos_x,self.pos_y + sign(self.vsp),other)) do
				self.pos_y = self.pos_y + sign(self.vsp)
			end
			self.vsp = 0
			self.GROUNDED = true
		end

		

	end
	--print("HSP: " .. self.hsp .. " VSP: " .. self.vsp)
end



--- Applies gravity to the object
function ENTITY:gravity(dt)
	if self.vsp < globalVar.gravityMax and self.GRAVITY == true then
		self.vsp = self.vsp + math.ceil(globalVar.gravityAccel * dt)
	end
end

---Step function, to be called each frame this entity should be updated
function ENTITY:step(dt)
	if not (self.FIXED == true) then
		self.pos_x = self.pos_x + self.hsp
		self.pos_y = self.pos_y + self.vsp
	end
end

--- Function to do movement calculations in
function ENTITY:movement(dt)

end

--- Function to define what is drawn for this entity
function ENTITY:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", self.pos_x, self.pos_y, self.BBOX.w, self.BBOX.h)
end


---This function is called when the entity is destroyed
function ENTITY:destroy()
	self = nil
end





return ENTITY
