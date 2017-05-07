---------------------- Room system -----------------------
-- Should contain a group of entities
-- both player entity and all kinds of enemies
-- platforms, powerups, coins, items

entitySystem = require('ul-base.EntitySystem')

local next = next
local ROOM =
{
	ROOM_ID = "",
	ENTITIES = {},
	id_counter = 1,
	active = false
}


--- Create new Room
function ROOM:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Creates new entity in room, for internal use
function ROOM:newEntity(entity, id)
	id = id or self.id_counter
	self.ENTITIES[id] = entity:new()
	self.id_counter = self.id_counter + 1
	return self.ENTITIES[id]
end

function ROOM:placeBox(x,y,w,h)
	o = self:placeEntity(ent,x,y)
	o:createBBox(w,h)
	o.SOLID = true
	o.FIXED = true
	return o
end

--- For creating an entity in the new room
function ROOM:placeEntity(entity,x,y)
	e = self:newEntity(entity)
	e:place(x,y)
	return e
end

--- Adds existing entity to the room
function ROOM:addEntity(entity, id)
	id = id or self.id_counter
	self.ENTITIES[id] = entity
	self.id_counter = self.id_counter + 1
	return id
end

function ROOM:setActive()
	self.active = true
end

function ROOM:setInactive()
	self.active = false
end

function ROOM:getEntity(id)
	return self.ENTITIES[id]
end

function ROOM:getEntityCount()
	local count = 0
  	for _ in pairs(self.ENTITIES) do count = count + 1 end
  	return count
end

--- Updates all entities in the room to be called in love.update(dt)
function ROOM:update(dt)
	if not (next(self.ENTITIES) == nil) and self.active then
		for key,value in pairs(self.ENTITIES) do
			self.ENTITIES[key]:movement(dt)			
			self.ENTITIES[key]:gravity(dt)			
			for key2,value2 in pairs(self.ENTITIES) do
				if not (key2 == key) then
					self.ENTITIES[key]:collision(self.ENTITIES[key2])
				end
			end
			self.ENTITIES[key]:step(dt)
		end
	end
end

function ROOM:draw()
	if not (next(self.ENTITIES) == nil) and self.active then
		for key,value in pairs(self.ENTITIES) do
			self.ENTITIES[key]:draw()
		end
	end
end


return ROOM
