io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")

hero = {}

math.randomseed(love.timer.getTime())

-- Listes d'éléments
liste_sprites = {}
liste_tirs = {}
liste_aliens = {}

niveau = {
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
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
	{ 0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,3,3,3,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,3,3,3,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,3,3,3,3,3,3,0,0,0,0,0 },
	{ 0,0,0,0,3,3,3,3,3,3,3,3,0,0,0,0 },
	{ 0,0,0,3,3,3,3,3,3,3,3,3,3,0,0,0 },
	{ 0,0,3,3,3,3,3,3,3,3,3,3,3,3,0,0 },
	{ 0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,0 },
	{ 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 }
}

-- Camera
camera = {}
camera.y = 0
camera.vitesse = 1

----Gestion des ecrans
screens = {}
screens.menuImg = love.graphics.newImage('images/galagaga-menu.png')
screens.gameoverImg = love.graphics.newImage('images/galagaga-gameover.png')
screens.victoryImg = love.graphics.newImage('images/victory.jpg')
screens.menu = 'menu'
screens.gameover = 'gameover'
screens.victory = 'victory'
screens.game = 'game'
screens.current = screens.menu
----

----Chargement images des tuiles
imgTuiles = {}
local n
for n = 1, 3 do
	imgTuiles[n] = love.graphics.newImage("images/tuile_"..n..".png")
end
----

sound_shoot = love.audio.newSource('sounds/shoot.wav', 'static')
sound_explode = love.audio.newSource('sounds/explosion.wav', 'static')
sound_gameover = love.audio.newSource('sounds/game-over.wav', 'static')

--#####################################HOMEMADE FUNCTIONS###############################################################

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

function CreateAlien(pType, pX, pY)
	local nomImage = ""

	if pType == 1 then
	    nomImage = "enemy1"
	elseif pType == 2 then
	    nomImage = "enemy2"
	elseif pType == 3 then
	    nomImage = "tourelle"
	end

	local alien = CreateSprite(nomImage, pX, pY)
	alien.type = pType
	alien.sleep = true
	alien.chronoTir = 0

	if pType == 1 then
		alien.vy = 2
		alien.vx = 0
		alien.energy = 1
	elseif pType == 2 then
		alien.vy = 2
		alien.energy = 2
		local direction = math.random(1,2)

		if direction == 1 then
		  alien.vx = 1
		else
		  alien.vx = -1
		end

	elseif pType == 3 then
		alien.energy = 3
		alien.vx = 0
		alien.vy = camera.vitesse
	end

	table.insert(liste_aliens, alien)
end

function CreateSprite(pNomImage, pX, pY)  
    sprite = {}
    sprite.x = pX
    sprite.y = pY
    sprite.supprime = false
    sprite.image = love.graphics.newImage("images/"..pNomImage..".png")
    sprite.l = sprite.image:getWidth()
    sprite.h = sprite.image:getHeight()

    table.insert(liste_sprites, sprite)

    return sprite
end

function CreateLaser(pType, pName, px, py, pvx, pvy)
    local tir = CreateSprite(pName, px, py)
    tir.vx = pvx
    tir.vy = pvy
    tir.type = pType
    table.insert(liste_tirs, tir)  
    sound_shoot:play()
end

function collide(a1, a2)
	if (a1 == a2) then 
		return false 
	end

	local dx = a1.x - a2.x
	local dy = a1.y - a2.y
	if (math.abs(dx) < a1.image:getWidth() + a2.image:getWidth()) then
		if (math.abs(dy) < a1.image:getHeight() + a2.image:getHeight()) then
			return true
		end
	end

	return false
end

function NewGame()
    hero.x = largeur / 2
    hero.y = hauteur - (hero.h*2)
    hero.speed = 9
    hero.life = 10
    hero.gameover = false

    ----Création des aliens
    local ligne = 4
    CreateAlien(1, largeur/2, -(64/2)-(64*(ligne-1)))
    ligne = 10
    CreateAlien(2, largeur/2, -(64/2)-(64*(ligne-1)))
    ligne = 11
    CreateAlien(3, 3.5*64, -(64/2)-(64*(ligne-1)))
    ligne = 22
    CreateAlien(3, 3.5*64, -(64/2)-(64*(ligne-1)))
    CreateAlien(1, 8*64, -(64/2)-(64*(ligne-1)))
    ligne = 32
    CreateAlien(1, largeur/2, -(64/2)-(64*(ligne-1)))
    CreateAlien(1, 5*64, -(64/2)-(64*(ligne-1)))
    CreateAlien(1, 11*64, -(64/2)-(64*(ligne-1)))
    CreateAlien(2, 2*64, -(64/2)-(64*(ligne-1)))
    CreateAlien(2, 14*64, -(64/2)-(64*(ligne-1)))
    ----

    --RAZ de la Caméra
    camera.y = 0
end

function UpdateGame()
	--Avance la camera
	camera.y = camera.y + camera.vitesse

	----Traitement du hero
	if hero.life <= 0 then
		hero.gameover = true
		sound_gameover:play()
		screens.current = screens.gameover
		--table.remove(liste_sprites, hero)
	end
	----

	----Traitement des tirs
	local n
	for n = #liste_tirs, 1, -1 do

	    local tir = liste_tirs[n]
	    tir.y = tir.y + tir.vy
	    tir.x = tir.x + tir.vx

	    if tir.type == 'alien' then
	    	if collide(hero, tir) == true then
	    		print("Boom I'm hit!")
	    		hero.life = hero.life - 1
	    		tir.supprime = true
	    		table.remove(liste_tirs, n)
	    	end
	    end

	    if tir.type == 'hero' then
	    	local n_alien
	    	for n_alien = #liste_aliens, 1, -1 do

	    		local alien = liste_aliens[n_alien]

	    		if collide(tir, alien) then

	    			alien.energy = alien.energy - 1
	    			tir.supprime = true
	    			table.remove(liste_tirs, n)

	    			if alien.energy <= 0 then

	    				alien.supprime = true
	    				sound_explode:play()
	    				table.remove(liste_aliens, n_alien)
	    			
	    			end
	    		end
	    	end
	    end	       	

	    -- Vérifier si le tir n'est pas sorti de l'écran
	    if (tir.y < 0 or tir.y > hauteur) and tir.supprime == false then
	        -- Marque le sprite pour le supprimer plus tard
	        tir.supprime = true
	        table.remove(liste_tirs, n)
	  
	    end
	end
	----

	----Traitement des aliens
	for n = #liste_aliens, 1, -1 do
	    local alien = liste_aliens[n]

	    if alien.y > 0 then
	        alien.sleep = false
	    end

	    if alien.sleep == false then

	        alien.x = alien.x + alien.vx
	        alien.y = alien.y + alien.vy

	        if alien.type == 1 or alien.type == 2 then

	            alien.chronoTir = alien.chronoTir - 1

	            if alien.chronoTir <= 0 then
	                alien.chronoTir = math.random(60, 100)
	                CreateLaser('alien','laser2', alien.x, alien.y, 0, 10)
	            end

	        elseif alien.type == 3 then

	            alien.chronoTir = alien.chronoTir - 1

	            if alien.chronoTir <= 0 then
	              	alien.chronoTir = math.random(20, 30)
	              	local vx, vy
	              	local angle
	              	angle = math.angle(alien.x, alien.y, hero.x, hero.y)
	              	vx = 10 * math.cos(angle)
	              	vy = 10 * math.sin(angle)
	            	CreateLaser('alien','laser2', alien.x, alien.y, vx, vy)
	            end
	        end

	    else
	      alien.y = alien.y + camera.vitesse
	    end

	    if alien.y > hauteur then
	      alien.supprime = true
	      table.remove(liste_aliens, n)
	    end
	end
	----

	----Purge des sprites à supprimer
	for n = #liste_sprites, 1, -1 do
	    if liste_sprites[n].supprime == true then
	     	table.remove(liste_sprites,n)
	    end
	end
	----

	----Traitement du vaisseau
	if love.keyboard.isDown("right") and hero.x < largeur then
		hero.x = hero.x + hero.speed
	end

	if love.keyboard.isDown("left") and hero.x > 0 then
		hero.x = hero.x - hero.speed
	end

	if love.keyboard.isDown("up") and hero.y > 0 then
		hero.y = hero.y - hero.speed
	end

	if love.keyboard.isDown("down") and hero.y < hauteur then
		hero.y = hero.y + hero.speed
	end
	----	
end

function DrawGame()

	----DRAWING THE MAP
	local nbLignes = #niveau
	local ligne,colonne
	local x,y

	x = 0
	y = (0-64) + camera.y

	for ligne = nbLignes, 1, -1 do
		for colonne = 1, 16 do
			-- Dessine la tuile
			local tuile = niveau[ligne][colonne]
			if tuile > 0 then
				love.graphics.draw(imgTuiles[tuile],x,y,0,2,2)
			end

			x = x + 64
		end
		x = 0
		y = y - 64
	end
	----
  
	----Dessin de tous les sprites
	local n
	for n = 1, #liste_sprites do
		local s = liste_sprites[n]
		love.graphics.draw(s.image, s.x, s.y, 0, 2, 2, s.l/2, s.h/2)
	end
	----

	love.graphics.print("LIFE : " .. tostring(hero.life), 10, 10, 0, 2, 2)
  
	--love.graphics.print("Nombre de tirs = "..#liste_tirs.." Nombre de sprites = "..#liste_sprites.." Nombre d'aliens = "..#liste_aliens,10,10)
end

--####################################################################################################

function love.load()

    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()

    hero = CreateSprite("ship", largeur/2, hauteur/2)

    NewGame()

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
  
end

function love.keypressed(key)
  	
  	if screens.current == screens.game then
		if key == "space" then
			CreateLaser('hero', 'laser1', hero.x, hero.y - (hero.h * 2) / 2, 0, -10)
		end
	elseif screens.current == screens.menu then
		if key == 'space' then
			screens.current = screens.game
		end
	end
  
end
  

