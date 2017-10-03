local I = {}
I.entities = {}

function I.update (dt)
  for entity in pairs(I.entities) do
    entity:update(dt)
  end
end

function I.draw ()
  for entity in pairs(I.entities) do
    entity:draw()
  end
end

function I.add (newEntity)
  table.insert(I.entities, newEntity)
end