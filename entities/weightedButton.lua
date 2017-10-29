-- adjustable properties of weighted plate
--    * resetTime - time that takes the weighted plate to reset after stepping out of it
--    * doors - pointers to doors connected with button

local T = {}

local states = {
  empty = {},
  weighted = {},
}

local interactive = require("interactive")

T.__index = T
T.activeOnWeight = true
--T.collision = true

setmetatable(T, { 
  __call =  function (o, ...) 
    return o.new(...)
  end,
})

function T.new(init)
  local self = setmetatable(init, T)
  interactive.add(self) 
  self.state = states.empty

  local size = _tileSize * _scale
  self.xDraw = self.x * size
  self.yDraw = self.y * size
  return self
end
    
function T:update(dt, actor)

end

function T:collisionCheck(actor, dx, dy)
  if self.x == actor.x + dx and self.y == actor.y + dy then
      return true
  end
  return false
end

function T:handleCollision(actor, dx, dy)

  if self.state == states.empty then
    if self:collisionCheck(actor, dx, dy) then
      self.state = states.weighted
      screen.flash(255, 0, 100, 100, 0.3)
    end
  elseif self.state == states.weighted then
    if self:collisionCheck(actor, 0, 0) then
      screen.flash(0, 255, 10, 100, 0.3)
      self.state = states.empty
    end
  end
  return dx, dy
end

function T:draw()
  local size = _tileSize * _scale
  if self.state == states.empty then
    love.graphics.rectangle("line", self.xDraw - size, self.yDraw - size, size, size) 
  end
end

return T