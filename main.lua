require('exampleGame.room1')
require('exampleGame.globalVar')

function love.load()
	--defaults
	def_col = {0,0,0,255}
	quitKey = "escape"
	restartKey = "l"
	setupRoom1()
end

function love.update(dt)
	if love.keyboard.isDown(quitKey) then
		love.event.quit()
	end
	if love.keyboard.isDown(restartKey) then
		love.event.quit("restart")
	end
	updateRoom1(dt)
end

function love.draw()
	drawRoom1()
end
