-- What has to be initialized in doors
--   state - locked or unlocked
--   x, y
--   xOpen, yOpen - place to where it moves when opening
--   openLength - time that it takes to be opened

local T = {}

local states = {
  unlocked = {},
  opening = {},
  closing = {},
  opened = {},
  locked = {},
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
  self.state = self.state or states.unlocked
  self.openProgress = 0
  return self
end
    
function T:update(dt, actor)

  -- if door is opening, advance in move 
  if self.state == states.opening then
    self.openProgress = self.openProgress + dt
    if self.openProgress >= self.openLength then
      self.state = states.opened
    end
  -- advance in move also if its closing
  elseif self.state == states.closing then
    self.openProgress = self.openProgress - dt
    if self.openProgress <= 0 then
      self.state = states.unlocked
  end

end

-- If player walks into unlocked door - start opening it 
function T:handleCollision(actor, dx, dy) 
  if actor.x + dx == self.x and actor.y + dy == self.y then
    if self.state == states.opening then
      return 0, 0
    elseif self.state == states.opened then
      return dx, dy
    elseif self.state == states.unlocked then
      self.state == state.opening
      return 0, 0
    end
  end
end

function T:draw()
  local size = _tileSize * _scale
  local t = self.openProgress / self.openTime 
  self.xDraw = lume.lerp(self.x, self.xOpen, t) * size
  self.yDraw = lume.lerp(self.y, self.yOpen, t) * size
  love.graphics.rectangle("fill", self.xDraw - size, self.yDraw - size, size, size) 
end

return T