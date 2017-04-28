require('keybind')
player = require('Player')

local Player1 = player:new()
local Player2 = player:new()


globalVar = 
{
	gravityMax = 20,
	gravityAccel = 45,
}


function love.load()
	setup_keys_defaults()
	
	Player1:place(200, 100)
	Player1:setPlayer(1)
	
	--defaults
	def_col = {0,0,0,255}
	quitKey = "escape"
	restartKey = "l"
	
	
end

function love.update(dt)
	if love.keyboard.isDown(quitKey) then
		love.event.quit()
	end
	if love.keyboard.isDown(restartKey) then
		love.event.quit( "restart" )
	end
	
	
	Player1:step(dt)
	Player2:step(dt)

end

function love.draw()
	Player1:draw()
	Player2:draw()
end