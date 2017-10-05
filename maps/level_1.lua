local teleport = require("entities/teleport")
local welcome = require("entities/welcome")

teleport {
  x = 9,
  y = 3,
  destination = {
    x = 3,
    y = 13,
    map = "level_2",
  }
}

welcome {
  message = "Karaluchy pod poduchy.",
  time = 3,
  fading = 0.5,
}