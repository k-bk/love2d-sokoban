local teleport = require("entities/teleport")
local welcome = require("entities/welcome")
local hud = require("entities/hud")
local movable = require("entities/movable")
local spikes = require("entities/spikes")
local weightedButton = require("entities/weightedButton")

weightedButton {
  x = 3,
  y = 8,
  resetTime = 1,
  doors = {}
}

movable {
  x = 4,
  y = 7,
}

teleport {
  x = 3,
  y = 14,
  destination = {
    x = 9,
    y = 4,
    map = "level_1",
  }
}

teleport {
  x = 4,
  y = 14,
  destination = {
    x = 9,
    y = 4,
    map = "level_1",
  }
}

welcome {
  message = "Dobranoc. Pchły na noc.",
  time = 3,
  fading = 0.5,
}

hud {
  steps = 50,
  levelName = "Poziom 1",
}

movable {
  x = 11,
  y = 11,
}
movable {
  x = 12,
  y = 11,
}

spikes {
  x = 7,
  y = 10,
  timeUp = 3,
  timeDown = 2,
  damage = 2,
}

spikes {
  x = 5,
  y = 9,
  timeUp = 3,
  timeDown = 2,
  damage = 2,
}

spikes {
  x = 5,
  y = 8,
  timeUp = 3,
  timeDown = 2,
  damage = 2,
}

spikes {
  x = 6,
  y = 8,
  timeUp = 3,
  timeDown = 2,
  damage = 2,
}

spikes {
  x = 4,
  y = 8,
  timeUp = 3,
  timeDown = 2,
  damage = 2,
}