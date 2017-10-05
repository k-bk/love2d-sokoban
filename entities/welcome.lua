-- What has to be initialized in welcome message
--  message 
--  time (seconds)

local W = {}
local interactive = require("interactive")

W.__index = W
setmetatable(W, { 
  __call =  function (o, ...) 
    return o.new(...)
  end,
})

function W.new(init)
  local self = setmetatable(init, W)
  interactive.add(self) 
  self.alpha = 255
  return self
end
    
function W:update(dt)
  self.time = self.time - dt
  if self.time < 0 then 
    self.alpha = self.alpha - 255 * dt / self.fading
    if self.alpha < 0 then
      self.delete = true
    end
  end
end

function W:draw()
  local r,g,b,a = love.graphics.getColor()
  local scrWidth
  love.graphics.setColor(255,255,255,self.alpha)
  love.graphics.printf(self.message,
    0, 
    love.graphics.getHeight() * 0.1, 
    love.graphics.getWidth(), 
    "center")
  love.graphics.setColor(r, g, b, a) 
end

return W