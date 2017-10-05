local G = {}
G.first = nil
G.last = nil
G.queue = {}

function G.push (event)
  G.first = G.first or 1
  G.last = (G.last or 0) + 1
  G.queue[G.last] = event
end

function G.pop ()
  G.first = G.first - 1
  return G.queue[G.first + 1]
end

function G.find (event)
  for i = G.first or 0, G.last or 0 do
    if G.queue[i] == event then
      return true
    end
  end
  return false
end

function G.check (event) 
  return G.find (event)
end

function G.reset ()
  G.queue = {}
  G.first = nil
  G.last = nil
end

return G
