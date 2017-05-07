-- Should create a boundingbox that can be assigned to an entity
-- a method should be able to check collision with current objects bbox
-- and other objects bbox

BBOX = 
{
	w = 0,
	h = 0
}

function BBOX:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Checks collisions with other bbox
function BBOX:CheckBBoxColl(x,y, other)
	return x < other.pos_x + other.BBOX.w and
		x + self.w > other.pos_x and
		y < other.pos_y + other.BBOX.h and
		y + self.h > other.pos_y
end

--- Checks if a point is in others bbox
function BBOX:CheckPointColl(x,y, other)
	return x < other.pos_x + other.BBOX.w and
		x > other.pos_x and
		y < other.pos_y + other.BBOX.h and
		y > other.pos_y
end

--- Checks if a horizontal line is in others bbox
function BBOX:CheckHLineColl(x,y,w, other)
	return self:CheckPointColl(x,y, other) and
		x + w > other.pos_x
end

--- Checks if a vertical line is in ióthers bbox
function BBOX:CheckVLineColl(x,y,h, other)
	return self:CheckPointColl(x,y, other) and
		y + h > other.pos_y
end

return BBOX
