function love.load()
    game_width = love.graphics.getWidth()
    game_height = love.graphics.getHeight()

    ship = {}
    ship.image = love.graphics.newImage('images/ship.png')
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

    Sprites = {}
    Tirs = {}
end

function CreateSprite(pName, px, py)
    sprite = {}
    sprite.img = love.graphics.newImage('images/' .. pName .. '.png')
    sprite.x = px
    sprite.y = py
    sprite.w = sprite.img:getWidth()
    sprite.h = sprite.img:getHeight()
    sprite.kill = false

    table.insert(Sprites, sprite)

    return sprite
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

    local n
    for n = #Tirs, 1, -1 do
        local tir = Tirs[n]
        tir.y = tir.y + tir.v
        if tir.y < 0 or tir.y > game_height then
            tir.kill = true
            table.remove(Tirs, n)
        end
    end

    for n = #Sprites, 1, -1 do
        if Sprites[n].kill == true then
            table.remove(Sprites, n)
        end
    end
    
end

function love.draw()
    love.graphics.draw(ship.image, ship.x, ship.y, 0, 2, 2, ship.width / 2, ship.height / 2)

    local n
    for n = 1, #Sprites do
        local s = Sprites[n]
        love.graphics.draw(s.img, s.x, s.y, 0, 2, 2, s.w / 2, s.h / 2)
    end
end

function love.keypressed(key)
    if key == 'space' then
        local tir = CreateSprite('laser1', ship.x, ship.y - ship.width)
        tir.v = -laser.speed
        table.insert(Tirs, tir)
        laser.sound:play()
    end
end