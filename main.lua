function love.load()
    game_width = love.graphics.getWidth()
    game_height = love.graphics.getHeight()

    ship = {}
    ship.image = love.graphics.newImage('images/heros.png')
    ship.width = ship.image:getWidth()
    ship.height = ship.image:getHeight()
    ship.x = game_width / 2
    ship.y = game_height - ship.height * 2
    ship.vx = 0
    ship.vy = 0
    ship.speed = 5
    ship.fire = false

    laser = {}
    laser.x = 0
    laser.y = 0
    laser.vx = 0
    laser.vy = 0
    laser.speed = 10
    laser.image = love.graphics.newImage('images/laser1.png')
    laser.width = laser.image:getWidth()
    laser.height = laser.image:getHeight()
    laser.sound = love.audio.newSource('sounds/shoot.wav', 'static')
end

function love.update(dt)
    ship.vx = ship.speed + (60 * dt)
    ship.vy = ship.speed + (60 * dt)

    ----SHIP CONTROL
    if love.keyboard.isDown('right') then
        ship.x = ship.x + ship.vx
    end

    if love.keyboard.isDown('down') then
        ship.y = ship.y + ship.vy
    end

    if love.keyboard.isDown('left') then
        ship.x = ship.x - ship.vx
    end

    if love.keyboard.isDown('up') then
        ship.y = ship.y - ship.vy
    end
    ----

    laser.x = ship.x
    laser.y = ship.y - ship.width

    if love.keyboard.isDown('space') then
        ship.fire = true
    else
        ship.fire = false
    end
end

function love.draw()
    love.graphics.draw(ship.image, ship.x, ship.y, 0, 2, 2, ship.width / 2, ship.height / 2)

    if ship.fire == true then
        love.graphics.draw(laser.image, laser.x, laser.y, 0, 2, 2, laser.width / 2, laser.height / 2)
    end
end