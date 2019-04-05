io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")

sprites = {}

ship = {}

lasers = {}
lasers.sound = nil

aliens = {}

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

function CreateAlien(pType, px, py, pvx, pvy)
    local name = 'enemy' .. pType
    local alien = CreateSprite(name, px, py, pvx, pvy)

    if pType == '1' then

        alien.vx = 0
        alien.vy = 2

    elseif pType == '2' then

        local direction = love.math.random(1, 2)

        if direction == 1 then
            alien.vx = 1
        elseif direction == 2 then
            alien.vx = -1
        end

        alien.vy = 2
    end

    table.insert(aliens, alien)

    return alien
end

function StartGame()
    ship.x = game_width / 2
    ship.y = game_height - ship.height * 2
    CreateAlien('1', game_width / 2 - 200, game_height / 2 - 100, 0, 0)
    CreateAlien('2', game_width / 2, game_height / 2 - 100, 0, 0)
end


function love.load()

    game_width = love.graphics.getWidth()
    game_height = love.graphics.getHeight()

    ship = CreateSprite('ship', game_width / 2, game_height / 2, 5, 5)

    lasers.sound = love.audio.newSource('sounds/shoot.wav', 'static')

    StartGame()

end

function love.update(dt)

    ----HERO SHIP
    do
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
    end
    ----

    ----LASERS
    do
        local n
        for n = #lasers, 1, -1 do
            local laser = lasers[n]
            laser.y = laser.y + laser.vy

            if laser.y < 0 or laser.y > game_height then
                laser.kill = true
                table.remove(lasers, n)
            end
        end
    end
    ----

    ----ALIENS
    do
        local n
        for n = #aliens, 1, -1 do
            local alien = aliens[n]
            alien.x = alien.x + alien.vx
            alien.y = alien.y + alien.vy

            if alien.y > game_height then
                alien.kill = true
                table.remove(aliens, n)
            end
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
        local laser = CreateSprite('laser1', ship.x, ship.y - ship.width, 0, -10)
        table.insert(lasers, laser)
        lasers.sound:play()
    end

end