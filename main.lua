_tileSize = 64
map = require("map")

function love.load ()
  map.load("level_1")
end

function love.update (dt)

  if love.keypressed("space") then
    if map_name == "level_1" then 
      map.load("level_2")
    else 
      map.load("level_1")
    end
  end
end

function love.draw ()
  map.draw(0 ,0)
end
