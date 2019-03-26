local Game = {}

Game.Ship = require('ship')

function Game.Load()
	Game.Ship.Load()
end

function Game.Update(dt)
	Game.Ship.Update(dt)
end

function Game.Draw()
	Game.Ship.Draw()
end

function Game.Keypressed(key)
	Game.Ship.Keypressed(key)
end

return Game