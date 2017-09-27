-- -----------------------
-- Map:
--  outer functions:
--      - draw(tx, ty) - draws the map (all layers) starting from (tx, ty) coordinates
--      - load(map_name) - loads a ~/maps/name.map file and fills each layer
--      - updateCanvas(layer) - draws the layer n to canvas n (done with "static" layers in load)
--  inner functions:
--      - readTileset - reads the tileset, cuts it into quads
--      - readLayers(file) - reads map file to build layers into memory
--
--  Attention:
--      tileset is 0 based - if in .map file there is tile 0 it reads {(0,0), (size,size)} rectangle
--      map is 1 based - if I put player on 0,0 there will be an error
--      flags work the same as tileset, start from flag 0
--

Map = {
  width = nil,
  height = nil,
  name = nil,
  layers = {},
  tileset = {},
  flags = {}
}

function Map.load(map_name)

  Map.name = map_name
  io.input("maps/" .. map_name .. ".map")
  local file = io.read("*a")

  -- find tileset name
  local tileset_name = string.match(file, "tileset:%s*(%a+)")
  Map.readTileset(tileset_name)

  -- find map dimensions
  Map.width = string.match(file, "width:%s*(%d+)")
  Map.height = string.match(file, "height:%s*(%d+)")

  -- read layers to memory
  Map.readLayers(file)

  -- draw static layers to canvases
  for _, layer in ipairs(Map.layers) do
    if layer.tag == "static" then
      Map.updateCanvas(layer)
    end
  end
end

function Map.draw(tx, ty, scale)

  tx = tx or 0
  ty = ty or 0

  for _, layer in ipairs(Map.layers) do
    if layer.tag ~= "static" then
      Map.updateCanvas(layer)
    end
  end

  for _, layer in ipairs(Map.layers) do
    love.graphics.draw(layer.canvas, tx, ty, 0, scale, scale)
  end
end

function Map.readLayers(file)

  -- Clear layers 
  Map.layers = {}

  -- find layers tag (static/dynamic) and put into grid the "grid" chunk of file
  for tag, grid in string.gmatch(file, "layer:%s*(%a+)%s*{%s*(.-)%s*}") do

    -- make new layer every time keyword "layer:" is found
    table.insert(Map.layers, {})
    local layer = Map.layers[#Map.layers]
    layer.tag = tag

    -- go through the lines of grid
    for line in string.gmatch(grid, "[^\r\n]+") do
      table.insert(layer, {})
      row = layer[#layer]

      -- for every line of grid insert space separated numbers
      for value in string.gmatch(line, "%d+") do
        table.insert(row, tonumber(value))
      end

    end
  end
end

function Map.readTileset(tileset_name)

  io.input("maps/" .. tileset_name .. ".tile")
  local file = io.read("*a")

  -- find size of tileset
  local width = string.match(file, "width:%s*(%d+)")
  local height = string.match(file, "height:%s*(%d+)")

  -- load tile flags
  local flag_num = 0
  for c in string.gmatch(string.match(file, "{%s*(%d+)"), ".") do
    Map.flags[flag_num] = tonumber(c)
    flag_num = flag_num + 1
  end

  -- read image of tileset
  local image_name = string.match(file, "image:%s*(%a+%.%a+)")
  Map.tileset.image = love.graphics.newImage("gfx/" .. image_name)
  for i = 0, height - 1 do
    for j = 0, width - 1 do
      Map.tileset[i * width + j] = love.graphics.newQuad(
        j * _tileSize, 
        i * _tileSize, 
        _tileSize, 
        _tileSize, 
        Map.tileset.image:getDimensions()
        )
    end
  end
end

function Map.checkFlag(x, y, layer)
  -- returns the highest flag on x,y coordinate
  
  local maxi = 0
  for _, layer in ipairs(Map.layers) do
    maxi = math.max(maxi, Map.flags[layer[x][y]])
  end
  return maxi
end

function Map.updateCanvas(layer)

  layer.canvas = love.graphics.newCanvas(Map.width * _tileSize, Map.height * _tileSize)
  love.graphics.setCanvas(layer.canvas)

  for i = 1, Map.height do
    for j = 1, Map.width do
      love.graphics.draw(
        Map.tileset.image,
        Map.tileset[layer[i][j]], 
        (j - 1) * _tileSize,
        (i - 1) * _tileSize
        )
    end
  end

  -- return to basic canvas
  love.graphics.setCanvas()
end

return Map
