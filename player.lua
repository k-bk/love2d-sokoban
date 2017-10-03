local P = {}

function P.load(x, y)
  P.x = x or 1
  P.y = y or 1

  P.layer = 3
end

function P.update(dt)
-- nothin's here yet
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

function P.draw(scale)

  love.graphics.rectangle("fill", (P.x - 1) * _tileSize * scale, (P.y - 1) * _tileSize * scale, _tileSize * scale, _tileSize * scale, 0, 0, 10)
end

return P
