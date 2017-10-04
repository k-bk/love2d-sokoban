_tileSize = 64
_scale = 0.5
map = require("map")
player = require("player")
interactive = require("interactive") 

function love.load ()
  map.load("level_2")
  player.load(2,6)
end

function love.update (dt)
  interactive.update(dt, player)
  player.update(dt)
end

function love.keypressed (key)
  player.keypressed (key)
end


function love.draw ()
  map.draw(0, 0)
  interactive.draw()
  player.draw()
end
