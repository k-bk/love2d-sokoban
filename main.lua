_tileSize = 64
map = require("map")

function love.load ()
  map.load("level_2")
end

function love.update (dt)

end

function love.keypressed (space, space)
  if map.name == "level_1" then 
    map.load("level_2")
  else
    map.load("level_1")
  end
end


function love.draw ()
  map.draw(0, 0, 0.5)
end
