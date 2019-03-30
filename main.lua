function CreateSprite(pName, px, py, pvx, pvy)
    sprite = {}
    sprite.img = love.graphics.newImage('images/' .. pName .. '.png')
    sprite.x = px
    sprite.y = py
    sprite.vx = pvx
    sprite.vy = pvy
    sprite.width = sprite.img:getWidth()
    sprite.height = sprite.img:getHeight()
    sprite.kill = false

    table.insert(Sprites, sprite)

    return sprite
end

function love.load()
    game_width = love.graphics.getWidth()
    game_height = love.graphics.getHeight()

    --Sprites will contain every sprites of the game (hero, enemies, lasers etc) : we'll only have one Sprites loop in the draw()
    Sprites = {}
    --Will contain every lasers shoot
    Tirs = {}

    ship = CreateSprite('ship', game_width / 2, game_height / 2, 0, 0)
    ship.y = game_height - ship.height * 2
    ship.speed = 5

    laser = {}
    laser.speed = 10
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

    laser.vy = laser.speed + (60 * dt)

    local n
    for n = #Tirs, 1, -1 do
        local tir = Tirs[n]
        tir.y = tir.y - laser.vy
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
    local n
    for n = 1, #Sprites do
        local s = Sprites[n]
        love.graphics.draw(s.img, s.x, s.y, 0, 2, 2, s.width / 2, s.height / 2)
    end
end

function love.keypressed(key)
    if key == 'space' then
        local tir = CreateSprite('laser1', ship.x, ship.y - ship.width, 0, 0)
        table.insert(Tirs, tir)
        laser.sound:play()
    end
end