local P = {}

function P.load(x, y)
  P.x = x or 1
  P.y = y or 1
  P.dir = 0
  P.xDraw = x
  P.yDraw = y
  P.stepTime = 0.3 
  P.stepProgress = 0
  P.layer = 3
  P.canMove = true
end

function lerp(v0, v1, t)
  return (1 - t) * v0 + t * v1
end

function P.update(dt)
  P.input()

  if not P.canMove then
    P.stepProgress = P.stepProgress + dt
    if P.stepProgress >= P.stepTime then
      P.stepProgress = P.stepProgress - P.stepTime 
      P.canMove = true
    end
  end

  local dest_x = (P.x - 1) * _tileSize
  local dest_y = (P.y - 1) * _tileSize
  P.xDraw = lerp(P.xDraw, dest_x, P.stepProgress / P.stepTime)
  P.yDraw = lerp(P.yDraw, dest_y, P.stepProgress / P.stepTime)
end

function P.teleport()
  P.xDraw = (P.x - 1) * _tileSize
  P.yDraw = (P.y - 1) * _tileSize
end

function P.input()

  if P.canMove then
    local movex,movey = 0,0
    if love.keyboard.isDown("up") then
      movey = movey - 1
      P.dir = 0
    end
    if love.keyboard.isDown("down") then
      movey = movey + 1
      P.dir = 2
    end
    if love.keyboard.isDown("left") then
      movex = movex - 1
      P.dir = 1
    end
    if love.keyboard.isDown("right") then
      movex = movex + 1
      P.dir = 3 
    end

    local oldx, oldy = P.x, P.y
    if P.lastKey == "horizontal" then
      if Map.checkFlag(P.x + movex, P.y) ~= 1 then 
        P.x = P.x + movex
        P.canMove = false
      end
      if Map.checkFlag(oldx, P.y + movey) ~= 1 and Map.checkFlag(P.x, P.y + movey) ~= 1 then 
        P.y = P.y + movey
        P.canMove = false
      end
    else
      if Map.checkFlag(P.x, P.y + movey) ~= 1 then 
        P.y = P.y + movey
        P.canMove = false
      end
      if Map.checkFlag(P.x + movex, oldy) ~= 1 and Map.checkFlag(P.x + movex, P.y) ~= 1 then 
        P.x = P.x + movex
        P.canMove = false
      end
    end
  end

end

function P.keypressed(key)

  -- lastKey is used to check which direction is more important for
  -- players movement (last is better)
  if key == "up" or key == "down" then
    P.lastKey = "vertical"
  elseif key == "left" or key == "right" then
    P.lastKey = "horizontal"
  end

end

function P.draw()
  local size = _tileSize * _scale 
  love.graphics.rectangle("fill", P.xDraw * _scale, P.yDraw * _scale, size, size) 
end

return P
