local E = {
  playerStep = {},
  playerHit = {},
  gamePaused = {},
}

local mt = {__index = function (t, k)
  print("No such event as: " .. k) 
  end
  }

setmetatable(E, mt)

return E
