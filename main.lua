_tileSize = 64
map = require("map")
player = require("player")
interactive = require("interactive") 

function love.load ()
  map.load("level_2")
  player.load(2,6)
end

function love.update (dt)
  interactive.update(dt)
  player.update(dt)
end

function love.keypressed (key)
  if key == "space" then
    if map.name == "level_1" then 
      map.load("level_2")
    else
      map.load("level_1")
    end
  end

  player.keypressed (key)
end


function love.draw ()
  local scale = 0.5
  map.draw(0, 0, scale)
  interactive.draw(scale)
  player.draw(scale)
end
