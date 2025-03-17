-- pixmap.lua
local function generate_image()
  local colors = {}
  for n = 1, 10 do
    local c = math.floor(23 * n)
    table.insert(colors, {c, 0, 0}) -- red gradient
  end

  local function to_rgb(value)
    return table.unpack(colors[value+1] or {0, 0, 0})
  end

  local img_width
  local img_height = 0

  for line in io.lines("data/mod_phi.data") do
    if not img_width then img_width = #line end
    img_height = img_height + 1
  end

  local img_file = io.open("temp.ppm", "wb")
  img_file:write("P6\n", img_width, " ", img_height, "\n255\n")

  for line in io.lines("data/mod_phi.data") do
    for c = 1, #line do
      local d = tonumber(string.sub(line,c,c))
      local r, g, b = to_rgb(d)
      img_file:write(string.char(r,g,b))
    end
  end

  img_file:close()
  -- os.execute("viewnior temp.ppm")
end

return generate_image()




------------------------------------------------------------------------------------
-- MIT License                                                                    --
--                                                                                --
-- Copyright © 2025 monk (Discord ID: 699370563235479624)                         --
--                                                                                --
-- Permission is hereby granted, free of charge, to any person obtaining a copy   --
-- of this software and associated documentation files (the "Software"), to deal  --
-- in the Software without restriction, including without limitation the rights   --
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      --
-- copies of the Software, and to permit persons to whom the Software is          --
-- furnished to do so, subject to the following conditions:                       --
--                                                                                --
-- The above copyright notice and this permission notice shall be included in all --
-- copies or substantial portions of the Software.                                --
--                                                                                --
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     --
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       --
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    --
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         --
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  --
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  --
-- SOFTWARE.                                                                      --
------------------------------------------------------------------------------------