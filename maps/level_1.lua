local teleport = require("entities/teleport")
local welcome = require("entities/welcome")
local hud = require("entities/hud")
local movable = require("entities/movable")
local spikes = require("entities/spikes")
local weightedButton = require("entities/weightedButton")

teleport {
  x = 14,
  y = 13,
  destination = {
    x = 3,
    y = 12,
    map = "level_1",
  }
}

welcome {
  message = "Karaluchy pod poduchy",
  time = 3,
  fading = 2,
}

spikes {
  x = 8,
  y = 10,
  timeUp = 3,
  timeDown = 2,
  damage = 2,
}

spikes {
  x = 8,
  y = 9,
  timeUp = 3,
  timeDown = 2,
  damage = 2,
}