--Room 1
player = require('exampleGame.Player')
ent = require('ul-base.EntitySystem')
local room = require('ul-base.RoomSystem')
local Room1 = room:new()

function setupRoom1()
	Room1.ROOM_ID = "Room 1"
	print("Setting up room 1")
	Player1 = Room1:placeEntity(player,200,200)
	Player1:setPlayer(1)

	Floor = Room1:placeBox(0,500,600,100)
	Block = Room1:placeBox(100,400,90,90)

	Room1:setActive()
	print("Room 1 active:")
	print(Room1.active)

	p1grav = "false"

end

function updateRoom1(dt)
	Room1:update(dt)
	Player1:debug()
end

function drawRoom1()
	love.graphics.print( Room1.ROOM_ID .. ", Number of entities: " .. Room1:getEntityCount(), 10,10)
	love.graphics.print("Player coords: x:" .. Player1.pos_x .. " y:" .. Player1.pos_y, 10,25)
	love.graphics.print("Player hsp: " .. Player1.hsp .. " Player vsp: " .. Player1.vsp, 10,40)
	love.graphics.print("Step size: " .. Player1.step_size, 10,55)
	if (Player1.GRAVITY) then
		p1grav = "true"
	else 
		p1grav = "false"
	end
	love.graphics.print("Player gravity: " .. p1grav, 10,70)
	Room1:draw()
end
