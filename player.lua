local P = {}

local states = {
  idle = {},
  walking = {},
}

setmetatable(states, {__index = function (k) print(k .. " is not a state.") return nil end })

function P.load(x, y)
  P.x = x or 1
  P.y = y or 1
  P.xFrom = P.x
  P.yFrom = P.y
  P.xTo = P.x
  P.yTo = P.y
  P.dir = 0
  P.xDraw = x
  P.yDraw = y
  P.stepLength = 0.3 
  P.stepProgress = 0
  P.state = states.idle
  P.layer = 3
  P.canMove = true
end

function P.update(dt)
  local dx, dy = P.input()

  -- Move only in one direction even if two keys pressed
  if dx ~= 0 and dy ~= 0 then
    if P.lastKey == "vertical" then
      dx = 0
    else
      dy = 0
    end
  end

  -- Update players position
  if P.state == states.walking then
    P.stepProgress = P.stepProgress + dt
    if P.stepProgress >= P.stepLength then
      P.x = P.xTo
      P.y = P.yTo
      P.xFrom = P.x
      P.yFrom = P.y
      P.stepProgress = 0 
      P.state = states.idle
    end
  end

  if P.state == states.idle then
    if dx ~= 0 or dy ~= 0 then
      dx, dy = P.collisionCheck(dx, dy)
      P.xFrom = P.x
      P.yFrom = P.y
      P.xTo = P.x + dx
      P.yTo = P.y + dy
      P.state = states.walking
      P.stepProgress = 0
    end
  end

end

function P.collisionCheck(dx, dy)
    -- Check collisions
    if map.checkFlag(P.x + dx, P.y) == 1 then
      dx = 0
    end
    if map.checkFlag(P.x, P.y + dy) == 1 then
      dy = 0
    end

    for _,entity in pairs(interactive.entities) do
      if entity.collision or entity.activeOnWeight then
        dx, dy = entity:handleCollision(P, dx, dy)
      end
    end
    return dx, dy
end

function P.input()

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

  return movex, movey

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
  local t = P.stepProgress / P.stepLength 
  P.xDraw = lume.lerp(P.xFrom, P.xTo, t) * size
  P.yDraw = lume.lerp(P.yFrom, P.yTo, t) * size
  love.graphics.rectangle("fill", P.xDraw - size, P.yDraw - size, size, size) 
end

return P
