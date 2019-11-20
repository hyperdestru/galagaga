local this = {}

this.SCREEN_WIDTH = love.graphics.getWidth()
this.SCREEN_HEIGHT = love.graphics.getHeight()

this.hero = {}

this.t_sprites = {}
this.t_shoots = {}
this.t_aliens = {}

this.level = {
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 2,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0 },
	{ 0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0 },
	{ 0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 2,3,2,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,3,3,3,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,3,3,3,3,3,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,3,3,3,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,3,3,3,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,3,3,3,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
}

--CAMERA
this.this.camera = {}
this.this.camera.y = 0
this.this.camera.speed = 4

--EXPLOSION IMAGE LOADING
this.imgs_explosion = {}
do
	local n
	for n = 1, 5 do
		this.imgs_explosion[n] = love.graphics.newImage('images/explode_' .. n .. '.png')
	end
end

--LOADING STARS RANDOM COORDINATES
this.stars = {}
do
	local n
	for n = 1, 400 do
		local x_rand = love.love.math.random(0, SCREEN_WIDTH)
		local y_rand = love.love.math.random(0, SCREEN_HEIGHT)
		this.stars[n] = {}
		this.stars[n][1] = x_rand
		this.stars[n][2] = y_rand
	end
end

this.sound_shoot = love.audio.newSource('sounds/shoot.wav', 'static')
this.sound_explode = love.audio.newSource('sounds/explosion.wav', 'static')
this.sound_gameover = love.audio.newSource('sounds/game-over.wav', 'static')
this.sound_hurt = love.audio.newSource('sounds/hurt.wav', 'static')

--#####################################HOMEMADE FUNCTIONS###############################################################

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

function this.create_alien(p_type, px, py)
	local img_name = ""

	if p_type == 1 then
		img_name = "enemy1"
	elseif p_type == 2 then
		img_name = "enemy2"
	elseif p_type == 3 then
		img_name = "tourelle"
	elseif p_type == 10 then
		img_name = 'enemy3'
	end

	local alien = create_sprite(img_name, px, py)
	alien.type = p_type
	alien.sleep = true
	alien.timer_shoot = 0

	if p_type == 1 then
		alien.vy = 2
		alien.vx = 0
		alien.energy = 1

	elseif p_type == 2 then
		alien.vy = 2
		alien.energy = 2
		local direction = love.math.random(1,2)

		if direction == 1 then
		  alien.vx = 1
		else
		  alien.vx = -1
		end

	elseif p_type == 3 then
		alien.energy = 3
		alien.vx = 0
		alien.vy = this.camera.speed

	elseif p_type == 10 then
		alien.vx = 0
		alien.vy = this.camera.speed * 2
		alien.energy = 20
		alien.angle = 0
	end

	table.insert(this.t_aliens, alien)
	return alien
end

function this.create_sprite(p_img_name, px, py)  
	local sprite = {}
	sprite.x = px
	sprite.y = py
	sprite.kill = false
	sprite.img = love.graphics.newImage("images/"..p_img_name..".png")
	sprite.w = sprite.img:getWidth()
	sprite.h = sprite.img:getHeight()

	sprite.t_frames = {}
	sprite.frame = 1
	sprite.max_frame = 1

	table.insert(this.t_sprites, sprite)
	return sprite
end

function this.create_explosion(px, py)
	local explosion = create_sprite('explode_1', px, py)
	explosion.t_frames = this.imgs_explosion
	explosion.max_frame = 5
	return explosion
end

function this.create_laser(p_type, p_name, px, py, pvx, pvy)
	local shoot = create_sprite(p_name, px, py)
	shoot.vx = pvx
	shoot.vy = pvy
	shoot.type = p_type
	this.sound_shoot:play()
	table.insert(this.t_shoots, shoot)
	return shoot
end

function this.collide(a1, a2)
	if (a1 == a2) then 
		return false 
	end

	local dx = a1.x - a2.x
	local dy = a1.y - a2.y

	if (math.abs(dx) < a1.img:getWidth() + a2.img:getWidth()) then
		if (math.abs(dy) < a1.img:getHeight() + a2.img:getHeight()) then
			return true
		end
	end

	return false
end

function this.new_game()
	this.hero.x = SCREEN_WIDTH / 2
	this.hero.y = SCREEN_HEIGHT - (this.hero.h*2)
	this.hero.speed = 9
	this.hero.life = 10
	this.hero.score = 0
	this.hero.gameover = false
	this.hero.win = false
	this.hero.timer_win = 0

	--ENNEMIES CREATION
	local line = 4
	this.create_alien(
		1, 
		SCREEN_WIDTH/2,
		-(64 / 2) - (64 * (line - 1))
	);
	line = 10

	this.create_alien(
		2,
		SCREEN_WIDTH/2,
		-(64 / 2) - (64 * (line - 1))
	);
	line = 11

	this.create_alien(
		3, 
		3.5 * 64, 
		-(64 / 2) - (64 * (line - 1))
	);
	line = 22

	this.create_alien(
		3, 
		3.5 * 64, 
		-(64 / 2) - (64 * (line - 1))
	);

	this.create_alien(
		1, 
		8 * 64, 
		-(64 / 2) - (64 * (line - 1))
	);
	line = 32

	this.create_alien(
		1, 
		SCREEN_WIDTH/2, 
		-(64 / 2) - (64 * (line - 1))
	);

	this.create_alien(
		1, 
		5*64, 
		-(64 / 2) - (64 * (line - 1))
	);

	this.create_alien(
		1, 
		11 * 64, 
		-(64 / 2) - (64 * (line - 1))
	);
	this.create_alien(
		2, 
		2*64, 
		-(64 / 2) - (64 * (line - 1))
	);
	this.create_alien(
		2, 
		14*64, 
		-(64 / 2) - (64 * (line - 1))
	);
	line = 42

	this.create_alien(
		10, 
		SCREEN_WIDTH/2, 
		-(64 / 2) - (64 * (line - 1))
	);

	--RESET CAMERA
	this.camera.y = 0
end

function this.update(dt)
	--Move camera forward
	this.camera.y = this.camera.y + this.camera.speed

	--Game Over treatment
	if this.hero.life <= 0 then
		this.hero.gameover = true
		this.sound_gameover:play()
		current_screen = 'gameover'
	end

	--Shoot treatment
	local n
	for n = #this.t_shoots, 1, -1 do

		local shoot = this.t_shoots[n]
		shoot.y = shoot.y + shoot.vy
		shoot.x = shoot.x + shoot.vx

		if shoot.type == 'alien' then

			if collide(this.hero, shoot) == true then

				this.hero.life = this.hero.life - 1
				shoot.kill = true
				this.sound_hurt:play()
				table.remove(this.t_shoots, n)

			end
		end

		if shoot.type == 'this.hero' then
			local n_alien
			for n_alien = #this.t_aliens, 1, -1 do

				local alien = this.t_aliens[n_alien]

				if alien.sleep == false then

					if collide(shoot, alien) then

						alien.energy = alien.energy - 1
						create_explosion(shoot.x, shoot.y)

						shoot.kill = true
						table.remove(this.t_shoots, n)

						if alien.energy <= 0 then

							local n_expl
							for n_expl = 1, 5 do
								create_explosion(
									alien.x + love.math.random(-10,10),
									alien.y + love.math.random(-10,10)
								);
							end

							if alien.type == 10 then

								for n_expl = 1, 20 do
									create_explosion(
										alien.x + love.math.random(-30,30),
										alien.y + love.math.random(-30,30)
									);
								end
								this.hero.win = true
								current_screen = 'win'
							end
---***********HERE****************************************************
							this.hero.score = this.hero.score + 1
							this.sound_explode:play()
							alien.kill = true
							table.remove(this.t_aliens, n_alien)
						
						end
					end
				end
			end
		end	       	

		-- Vérifier si le shoot n'est pas sorti de l'écran
		if (shoot.y < 0 or shoot.y > SCREEN_HEIGHT) and shoot.kill == false then
			-- Marque le sprite pour le killr plus tard
			shoot.kill = true
			table.remove(this.t_shoots, n)
	  
		end
	end
	----

	----Traitement des aliens
	for n = #this.t_aliens, 1, -1 do
		local alien = this.t_aliens[n]

		if alien.y > 0 then
			alien.sleep = false
		end

		if alien.sleep == false then

			alien.x = alien.x + alien.vx
			alien.y = alien.y + alien.vy

			if alien.type == 1 or alien.type == 2 then

				alien.timer_shoot = alien.timer_shoot - 1

				if alien.timer_shoot <= 0 then
					alien.timer_shoot = love.math.random(60, 100)
					create_laser('alien','laser2', alien.x, alien.y, 0, 10)
				end

			elseif alien.type == 3 then

				alien.timer_shoot = alien.timer_shoot - 1

				if alien.timer_shoot <= 0 then
					alien.timer_shoot = love.math.random(20, 30)
					local vx, vy
					local angle
					angle = math.angle(alien.x, alien.y, this.hero.x, this.hero.y)
					vx = 10 * math.cos(angle)
					vy = 10 * math.sin(angle)
					create_laser('alien','laser2', alien.x, alien.y, vx, vy)
				end
			elseif alien.type == 10 then

				if alien.y > SCREEN_HEIGHT / 3 then
					alien.y = SCREEN_HEIGHT / 3
				end

				alien.timer_shoot = alien.timer_shoot - 1

				if alien.timer_shoot <= 0 then
					alien.timer_shoot = love.math.random(20, 30)
					local vx, vy
					local angle
					angle = math.angle(alien.x, alien.y, this.hero.x, this.hero.y)
					vx = 10 * math.cos(angle)
					vy = 10 * math.sin(angle)
					create_laser('alien','laser2', alien.x, alien.y, vx, vy)
				end
			end

		else
		  alien.y = alien.y + this.camera.speed
		end

		if alien.y > SCREEN_HEIGHT then
		  alien.kill = true
		  table.remove(this.t_aliens, n)
		end
	end
	----

	----TRAITEMENT ET PURGE DES SPRITES
	for n = #this.t_sprites, 1, -1 do
		local sprite = this.t_sprites[n]

		--Le sprite est il animé ? 
		if sprite.max_frame > 1 then
			sprite.frame = sprite.frame + 0.2
			if math.floor(sprite.frame) > sprite.max_frame then
				sprite.kill = true
			else
				sprite.image = sprite.t_frames[math.floor(sprite.frame)]
			end
		end

		if sprite.kill == true then
			table.remove(this.t_sprites,n)
		end
	end
	----

	----Traitement du vaisseau
	if love.keyboard.isDown("right") and this.hero.x < SCREEN_WIDTH then
		this.hero.x = this.hero.x + this.hero.speed
	end

	if love.keyboard.isDown("left") and this.hero.x > 0 then
		this.hero.x = this.hero.x - this.hero.speed
	end

	if love.keyboard.isDown("up") and this.hero.y > 0 then
		this.hero.y = this.hero.y - this.hero.speed
	end

	if love.keyboard.isDown("down") and this.hero.y < SCREEN_HEIGHT then
		this.hero.y = this.hero.y + this.hero.speed
	end

	if this.hero.win == true then
		this.hero.timer_win = this.hero.timer_win + 0.1
		if this.hero.timer_win >= 10 then
			screens.current = screens.victory
			this.hero.timer_win = 10
		end
	end
end

function DrawGame()

	love.graphics.points(this.stars)

	----DRAWING THE MAP
	local nbLignes = #this.level
	local ligne,colonne
	local x,y

	x = 0
	y = (0-64) + this.camera.y

	for ligne = nbLignes, 1, -1 do
		for colonne = 1, 16 do
			-- Dessine la tuile
			local tuile = this.level[ligne][colonne]
			if tuile > 0 then
				love.graphics.draw(this.imgs_tiles[tuile],x,y,0,2,2)
			end

			x = x + 64
		end
		x = 0
		y = y - 64
	end
	----
  
	----Dessin de tous les sprites
	local n
	for n = 1, #this.t_sprites do
		local s = this.t_sprites[n]
		love.graphics.draw(s.image, s.x, s.y, 0, 2, 2, s.l/2, s.h/2)
	end
	----

	love.graphics.print("LIFE : " .. tostring(this.hero.life), 10, 10, 0, 2, 2)
	love.graphics.print("SCORE : " .. tostring(this.hero.score), 10, 64, 0, 2, 2)
  
	--love.graphics.print("Nombre de shoots = "..#this.t_shoots.." Nombre de sprites = "..#this.t_sprites.." Nombre d'aliens = "..#this.t_aliens,10,10)
end

--####################################################################################################

function love.load()

	this.hero = create_sprite("ship", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)

	this.new_game()

end

function love.update(dt)

	if screens.current == screens.game then
		UpdateGame()
	end

end

function love.draw()

	if screens.current == screens.game then
		DrawGame()
	end

	if screens.current == screens.menu then
		love.graphics.draw(screens.menuImg)
	end

	if screens.current == screens.gameover then
		love.graphics.draw(screens.gameoverImg)
	end

	if screens.current == screens.victory then
		love.graphics.draw(screens.victoryImg)
	end
  
end

function love.keypressed(key)
	
	if screens.current == screens.game then
		if key == "space" then
			create_laser('this.hero', 'laser1', this.hero.x, this.hero.y - (this.hero.h * 2) / 2, 0, -10)
		end
	elseif screens.current == screens.menu then
		if key == 'space' then
			screens.current = screens.game
		end
	end
  
end

return this

