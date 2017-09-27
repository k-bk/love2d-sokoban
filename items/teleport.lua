local T = {}
T.__index = T

function T.new(init)
  local self = setmetatable({}, T)
  self.value = init
  return self
end
