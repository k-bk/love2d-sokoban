local T = {}

local states = {
  idle = {},
  moving = {},
}

local interactive = require("interactive")

T.__index = T
T.collision = true

setmetatable(T, { 
  __call =  function (o, ...) 
    return o.new(...)
  end,
})

function T.new(init)
  local self = setmetatable(init, T)
  interactive.add(self) 
  self.state = states.idle
  return self
end
    
function T:update(dt, actor)

  -- if entity is moving, advance its step
  if self.state == states.moving then
    self.stepProgress = self.stepProgress + dt
    if self.stepProgress >= self.stepTime then
      self.x = self.xTo
      self.y = self.yTo
      self.stepProgress = 0
      self.state = states.idle
    end
  end

end

-- Standard function evoken for every collision = true entity
function T:handleCollision(actor, dx, dy) 
  if actor.x + dx == self.x and actor.y + dy == self.y then
    dx, dy = self:move(dx, dy)
  end
  return dx, dy
end

function T:move(dx, dy)

  if dx ~= 0 or dy ~= 0 then
    self.xFrom = self.x
    self.yFrom = self.y

    if map.checkFlag(self.x + dx, self.y + dy) ~= 1 then
      local canmove = true
      for _,entity in pairs(interactive.entities) do
        if entity.collision and entity ~= self then
          if entity.x == self.x + dx and entity.y == self.y + dy then
            dx, dy = 0, 0
            canmove = false
            break
          end
        end
      end

      if canmove then
        self.xTo = self.x + dx
        self.yTo = self.y + dy
        self.state = states.moving
      end
    end
  end

  return dx, dy
end


function T:draw()
  local size = _tileSize * _scale
  local t = T.stepTrogress / T.stepLength 
  T.xDraw = lume.lerp(T.xFrom, T.xTo, t) * size
  T.yDraw = lume.lerp(T.yFrom, T.yTo, t) * size
  love.graphics.rectangle("line", T.xDraw - size, T.yDraw - size, size, size) 
end

return T