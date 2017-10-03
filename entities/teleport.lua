-- What has to be initialized in teleport
--  x, y - position on map (tiles)
--  destination.x, destination.y
--  destination.map (string)

local T = {}

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
  return self
end
    
function T:update(dt, actor)
  if actor.x == self.x and actor.y == self.y then 
    actor.x = self.destination.x
    actor.y = self.destination.y
    if self.destination.map ~= map.name or self.destination.map == "remain" then
      map.load(self.destination.map)
    end
  end
return T

function T:draw()
  local size = _tileSize * _scale
  love.graphics.rectangle("line", self.x * size, self.y * size, size, size) 
end