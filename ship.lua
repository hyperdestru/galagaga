local Ship = {}

Ship.sprite = nil
Ship.width = nil
Ship.height = nil
Ship.x = 0
Ship.y = 0
Ship.vx = 0
Ship.vy = 0
Ship.speed = 5
Ship.shoot = false
Ship.laser = nil

function Ship.Load()
	GAME_WIDTH = love.graphics.getWidth()
	GAME_HEIGHT = love.graphics.getHeight()

	Ship.sprite = love.graphics.newImage('images/heros.png')
	Ship.width = Ship.sprite:getWidth()
	Ship.height = Ship.sprite:getHeight()

	Ship.x = GAME_WIDTH / 2
	Ship.y = GAME_HEIGHT - (Ship.height * 2)

	Ship.laser = love.graphics.newImage('images/laser1.png')
	Ship.laserWidth = Ship.laser:getWidth()
	Ship.laserHeight = Ship.laser:getWidth()
end

function Ship.Update(dt)
	Ship.vx = Ship.speed + (60 * dt)
	Ship.vy = Ship.speed + (60 * dt) 

	----SHIP CONTROL AND SHIP WORLD COLLISION
	if love.keyboard.isDown('right') and Ship.x < GAME_WIDTH then
		Ship.x = Ship.x + Ship.vx
	end

	if love.keyboard.isDown('down') and Ship.y < GAME_HEIGHT then
		Ship.y = Ship.y + Ship.vy
	end

	if love.keyboard.isDown('left') and Ship.x > 0 then
		Ship.x = Ship.x - Ship.vx
	end

	if love.keyboard.isDown('up') and Ship.y > 0 then
		Ship.y = Ship.y - Ship.vy
	end
	----
end

function Ship.Draw()
	love.graphics.draw(Ship.sprite, Ship.x, Ship.y, 0, 2, 2, Ship.width / 2, Ship.height / 2)

	if Ship.shoot == true then
		love.graphics.draw(Ship.laser, Ship.x, Ship.y - Ship.height - Ship.laserWidth, 0, 2, 2, Ship.laserWidth / 2, Ship.laserHeight / 2)
	end
end

function Ship.Keypressed(key)
	if key == 'space' and Ship.shoot == false then
		Ship.shoot = true
	else
		Ship.shoot = false
	end
end

return Ship