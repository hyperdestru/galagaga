local this = {}

function this.load()
	this.bg = love.graphics.newImage('images/gameover.png')
end

function this.update(dt)
end

function this.draw()
	love.graphics.draw(this.bg)
end

function this.keypressed(key)
end

return this