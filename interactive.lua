local I = {}
I.entities = {}
I.map = nil

function I.update (dt, player)
  for _, entity in pairs(I.entities) do
    entity:update(dt, player)
  end
end

function I.draw ()
  for _, entity in pairs(I.entities) do
    entity:draw()
  end
end

function I.add (newEntity)
  table.insert(I.entities, newEntity)
end

return I