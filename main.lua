io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")

myGame = require('game')

function love.load()
	myGame.Load()
end

function love.update(dt)
	myGame.Update(dt)
end

function love.draw()
	myGame.Draw()
end

function love.keypressed(key)
	myGame.Keypressed(key)
end

