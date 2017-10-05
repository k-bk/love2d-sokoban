local I = {}
I.entities = {}
I.map = nil

function I.load (map_name)
  I.entities = {}
  dofile("maps/" .. map_name .. ".lua")
end

function I.update (dt, player)
  for i, entity in pairs(I.entities) do
    entity:update(dt, player)
    if entity.delete then
      table.remove(I.entities, i)
    end
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