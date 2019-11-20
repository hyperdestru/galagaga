love.graphics.setDefaultFilter("nearest")

current_screen = 'menu'

local menu = require('menu')
local game = require('game')
local gameover = require('gameover')
local win = require('win')

function love.load()
	menu.load()
	game.load()
	gameover.load()
	win.load()
end

function love.update(dt)
	if current_screen == 'menu' then
		menu.update(dt)
	elseif current_screen == 'game' then
		game.update(dt)
	elseif current_screen == 'gameover' then
		gameover.update(dt)
	elseif current_screen == 'win' then
		win.update(dt)
	end
end

function love.draw()
	if current_screen == 'menu' then
		menu.draw(dt)
	elseif current_screen == 'game' then
		game.draw(dt)
	elseif current_screen == 'gameover' then
		gameover.draw(dt)
	elseif current_screen == 'win' then
		win.draw(dt)
	end
end

function love.keypressed(key)
	if current_screen == 'menu' then
		menu.keypressed(key)
	elseif current_screen == 'game' then
		game.keypressed(key)
	elseif current_screen == 'gameover' then
		gameover.keypressed(key)
	elseif current_screen == 'win' then
		win.keypressed(key)
	end
end