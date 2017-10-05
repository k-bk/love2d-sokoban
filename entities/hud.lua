-- Hhat has to be initialized in hud 
--  steps - stepcount (loose condition for level) 
--  levelName - name displayed in the bottom

local H = {}
local interactive = require("interactive")

H.__index = H
setmetatable(H, { 
  __call =  function (o, ...) 
    return o.new(...)
  end,
})

function H.new(init)
  local self = setmetatable(init, H)
  interactive.add(self) 
  self.stepsLeft = self.steps
  return self
end
    
function H:update(dt)
  if gameEvents.check(events.playerStep) then
    self.stepsLeft = self.stepsLeft - 1
  end
end

function H:draw()
end

return H