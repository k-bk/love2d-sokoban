-- handles screen events like flash, shake

local S = {}
S.flashTable = {}

function S.flash(r, g, b, a, duration)

  local o = {}

  o.r = r
  o.g = g
  o.b = b
  o.a = a
  o.up = true
  o.time = 0
  o.duration = duration
  table.insert(S.flashTable, o)

end

function S.update(dt)
  for i,f in pairs(S.flashTable) do
    if f.up then
      f.time = f.time + dt
      if f.time > f.duration / 2 then
        f.up = false
      end
    else
      f.time = f.time - dt
      if f.time <= 0 then
        table.remove(S.flashTable, i)
      end
    end
  end
end

function S.draw()
  for i,f in pairs(S.flashTable) do
    r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(f.r, f.g, f.b, f.time/f.duration * f.a)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
    love.graphics.setColor(r,g,b,a)
  end
end

return S

