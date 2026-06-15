--[[
Core:
  sample = ((z * y) % X) % M + 1

Observations:
  - palette index placement radically changes macro patterns
  - early sparse palettes appear embedded in later dense palettes
    > pallet activation indexes overlap, eg: BBCBCBBB = BBCBBBBB + BBBBCBBB
  - sequential browsing creates apparent animation
  - X changes pattern family
]]

local output_dir = "/tmp/modulart_images"

local function ensure_output_dir()
  local ok = os.execute("mkdir -p " .. output_dir)

  if ok ~= true and ok ~= 0 then
    error("Could not create output directory: " .. output_dir)
  end
end


local function generate_modulart(name, X, colors, img_width, img_height)
  local M = #colors
  local nodes = {}

  for z = 1, img_width do
    for y = 1, img_height do
      local sample = ( ( z * y ) % X ) % M + 1  -- original formula
      -- print(sample)
      local c = colors[sample]
      nodes[y] = nodes[y] or {}
      nodes[y][z + 1] = { r = c.r, g = c.g, b = c.b }
    end
  end

  local file_name = output_dir .. "/modulart" .. name .. ".ppm"
  local ppm = assert(io.open(file_name, "wb"))
  ppm:write("P6\n", img_width, " ", img_height, "\n255\n")

  for y = 1, img_height do
    for z = 1, img_width do
      local v = nodes[y] and nodes[y][z] or { r = 0, g = 0, b = 0 }
      local r, g, b = v.r, v.g, v.b
      ppm:write(string.char(r, g, b))
    end
  end

  ppm:close()
end


local black      = { r =   0, g =   0, b =   0 }
local dark_grey  = { r =  77, g =  77, b =  77 }
local grey       = { r =  97, g =  97, b =  97 }
local light_grey = { r = 121, g = 121, b = 121 }
local white      = { r = 205, g = 205, b = 210 }

local red     = { r = 200, g =   0, b =   0 }
local magenta = { r = 200, g =   0, b = 200 }
local blue    = { r =   0, g =   0, b = 200 }
local cyan    = { r =   0, g = 200, b = 200 }
local green   = { r =   0, g = 200, b =   0 }

local color = red

local function palette_code(colors)
  local out = {}

  for i, c in ipairs(colors) do
    if c.r == 0 and c.g == 0 and c.b == 0 then
      out[i] = "B"
    else
      out[i] = "C"
    end
  end

  return table.concat(out)
end


local function make_palette(n, marked)
  local is_marked = {}
  for _, idx in ipairs(marked) do
    is_marked[idx] = true
  end

  local colors = {}
  for i = 1, n do
    colors[i] = is_marked[i] and color or black
  end

  return colors
end


local function make_palette_from_mask(mask)
  local colors = {}

  for i = 1, #mask do
    local c = mask:sub(i, i)
    colors[i] = c == "C" and color or black
  end

  return colors
end


local function combinations(n, k, visit)
  local picked = {}

  local function rec(start, depth)
    if depth > k then
      visit(picked)
      return
    end

    for i = start, n - (k - depth) do
      picked[depth] = i
      rec(i + 1, depth + 1)
    end
  end

  rec(1, 1)
end


-- command line args
local cli = {}
-- Assign the file name and path
cli[0] = string.gsub(arg[0], "^([%w/]-/?)([%w%.]+)$",
    function(path, file)
      cli[file] = path
      return file, path
    end)
-- Evaluate arguments after the file
for p = 1, #arg do
  cli[p] = string.gsub(arg[p], "^%-*(%a[%w_-]*)=?(%S*)$",
    function(param, val)
      cli[param] = val == "" or tonumber(val) or val
      return param, val
    end)
end


local min_X = tonumber(cli.min) or 40
local max_X = tonumber(cli.max) or 50

local img_width  = tonumber(cli.w) or 128
local img_height = tonumber(cli.h) or 128

local palette_mask = type(cli.mask) == "string" and cli.mask:match("^[BC][BC]+$")

local palette_size = not palette_mask and (tonumber(cli.palette) or 8) or #palette_mask

ensure_output_dir()

if palette_mask then
  local colors = make_palette_from_mask(palette_mask)

  for X = min_X, max_X do
    local name = string.format("_X%d_%s", X, palette_code(colors))
    generate_modulart(name, X, colors, img_width, img_height)
  end

else
  for X = min_X, max_X do
    for k = 1, palette_size do
      combinations(palette_size, k, function(marked)
        local colors = make_palette(palette_size, marked)
        local name = string.format("_X%d_%s", X, palette_code(colors))
        generate_modulart(name, X, colors, img_width, img_height)
      end)
    end
  end
end
