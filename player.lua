local P = {}

function P.load(x, y)
  P.x = x or 1
  P.y = y or 1
  P.xDraw = x
  P.yDraw = y
  P.speed = 10
  P.layer = 3
end

function P.update(dt)
  local dest_x = (P.x - 1) * _tileSize
  local dest_y = (P.y - 1) * _tileSize
  P.xDraw = P.xDraw - ((P.xDraw - dest_x) * P.speed * dt)
  P.yDraw = P.yDraw - ((P.yDraw - dest_y) * P.speed * dt)
end

function P.teleport()
  P.xDraw = (P.x - 1) * _tileSize
  P.yDraw = (P.y - 1) * _tileSize
end

function P.keypressed(key)

  local movex,movey = 0,0
  if key == "up" then
    movey = movey - 1
  end
  if key == "down" then
    movey = movey + 1
  end
  if key == "left" then
    movex = movex - 1
  end
  if key == "right" then
    movex = movex + 1
  end

  if Map.checkFlag(P.x + movex, P.y + movey) ~= 1 then 
    P.x = P.x + movex
    P.y = P.y + movey
  end

end

function P.draw()
  local size = _tileSize * _scale 
  love.graphics.rectangle("fill", P.xDraw * _scale, P.yDraw * _scale, size, size) 
end

return P
