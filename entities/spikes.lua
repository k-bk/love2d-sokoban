local T = {}

local states = {
  up = {},
  down = {},
}

local interactive = require("interactive")

T.__index = T

setmetatable(T, { 
  __call =  function (o, ...) 
    return o.new(...)
  end,
})

function T.new(init)
  local self = setmetatable(init, T)
  interactive.add(self) 
  self.state = states.down
  self.timeUp = self.timeUp or 1
  self.timeDown = self.timeDown or 2
  self.timer = 0
  return self
end
    
function T:update(dt, actor)

  self.timer = self.timer + dt
  if self.state == states.up then
    if self.timer >= self.timeUp then
      self.timer = 0
      self.state = states.down
    end
  elseif self.state == states.down then
    if self.timer >= self.timeDown then
      self.timer = 0
      self.state = states.up
    end
  end
end

function T:draw()
  local size = _tileSize * _scale
  if self.state == states.up then
    love.graphics.rectangle("line", (self.x - 1) * size, (self.y - 1) * size, size, size) 
  end
end

return T