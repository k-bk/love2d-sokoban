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
  self.stepProgress = 0
  self.stepLength = 0.5
  self.xTo = self.x
  self.yTo = self.y
  self.xFrom = self.x
  self.yFrom = self.y
  return self
end
    
function T:update(dt, actor)

  -- if entity is moving, advance its step
  if self.state == states.moving then
    self.stepProgress = self.stepProgress + dt
    if self.stepProgress >= self.stepLength then
      self.x = self.xTo
      self.y = self.yTo
      self.xFrom = self.x
      self.yFrom = self.y
      self.stepProgress = 0
      self.state = states.idle
    end
  end

end

-- Standard function evoken for every collision = true entity
function T:handleCollision(actor, dx, dy) 
  if actor.x + dx == self.x and actor.y + dy == self.y then
    self.stepLength = actor.stepLength
    dx, dy = self:move(dx, dy)
  end
  return dx, dy
end

function T:move(dx, dy)

  if dx ~= 0 or dy ~= 0 then
    self.state = states.moving
    if map.checkFlag(self.x + dx, self.y + dy) ~= 1 then
      for _,entity in pairs(interactive.entities) do
        if entity.collision and entity ~= self then
          if entity.x == self.x + dx and entity.y == self.y + dy then
            dx, dy = 0, 0
            self.state = states.idle
            break
          end
        elseif entity.activeOnWeight then
          entity:handleCollision(self, dx, dy)
        end
      end

    -- if collides with static map
    else
      dx, dy = 0, 0
      self.state = states.idle
    end
  end

  self.xTo = self.x + dx
  self.yTo = self.y + dy
  self.xFrom = self.x
  self.yFrom = self.y

  return dx, dy
end


function T:draw()
  local size = _tileSize * _scale
  local t = self.stepProgress / self.stepLength 
  self.xDraw = lume.lerp(self.xFrom, self.xTo, t) * size
  self.yDraw = lume.lerp(self.yFrom, self.yTo, t) * size
  love.graphics.rectangle("fill", self.xDraw - size, self.yDraw - size, size, size) 
end

return T