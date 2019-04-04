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

    table.insert(sprites, sprite)

    return sprite
end

function CreateAlien(pType, px, py)
    local name = 'enemy' .. pType
    local alien = CreateSprite(name, px, py)
    table.insert(aliens, alien)
end

function love.load()
    game_width = love.graphics.getWidth()
    game_height = love.graphics.getHeight()

    --sprites will contain every sprites of the game (hero, enemies, lasers etc) : we'll only have one sprites loop in the draw()
    sprites = {}

    ----OUR HERO
    ship = {}
    ship = CreateSprite('ship', game_width / 2, game_height / 2, 0, 0)
    ship.y = game_height - ship.height * 2
    ship.speed = 5
    ----

    --Will contain every lasers shoot
    lasers = {}
    lasers.speed = 10
    lasers.sound = love.audio.newSource('sounds/shoot.wav', 'static')

    aliens = {}
    CreateAlien('1', game_width / 2, game_height / 2)

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

    ----LASERS
    lasers.vy = lasers.speed + (60 * dt)

    local n
    for n = #lasers, 1, -1 do
        local laser = lasers[n]
        laser.y = laser.y - lasers.vy
        if laser.y < 0 or laser.y > game_height then
            laser.kill = true
            table.remove(lasers, n)
        end
    end
    ----

    ----PURGING KILLED SPRITES
    for n = #sprites, 1, -1 do
        if sprites[n].kill == true then
            table.remove(sprites, n)
        end
    end
    ----
end

function love.draw()
    local n
    for n = 1, #sprites do
        local s = sprites[n]
        love.graphics.draw(s.img, s.x, s.y, 0, 2, 2, s.width / 2, s.height / 2)
    end
end

function love.keypressed(key)
    if key == 'space' then
        local laser = CreateSprite('laser1', ship.x, ship.y - ship.width, 0, 0)
        table.insert(lasers, laser)
        lasers.sound:play()
    end
end