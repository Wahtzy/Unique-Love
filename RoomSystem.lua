---------------------- Room system -----------------------
-- Should contain a group of entities
-- both player entity and all kinds of enemies
-- platforms, powerups, coins, items

entitySystem = require('EntitySystem')

local next = next
local ROOM =
{
	ENTITIES = {}
	id_counter = 1
	active = false
}

function ROOM:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Creates new entity in room, for internal use
function newEnitity(entity, id)
	id = id or self.id_counter
	self.ENTITIES[id] = entity:new()
	id_counter = id_counter + 1
	return id
end

--- For creating an entity in the new room
function placeEntity(x,y,entity)
	e = newEntity(entity)
	e:place(x,y)
end


function getEntity(id)
	return self.ENTITIES[id]
end

--- Updates all entities in the room to be called in love.update(dt)
function updateRoom(dt)
	if not next(myTable) == nil and active then
		for key,value in pairs(self.ENTITIES) do
			self.ENTITIES[key]:step(dt)
		end
	end
end

