-- pixmap.lua
local function generate_image(img_width, img_height)
  local file_dir = string.format("./images/phivar_new_%s", os.time())
  local img_file = io.open(file_dir, "wb")
  img_file:write("P6\n", img_width, " ", img_height, "\n255\n")

  local rgb_map = {}
  -- for n = 0,9 do  -- if the image is too saturated, reverse mapping order
  for n = 9,0,-1 do
    local c = 16 * (n+1)
    rgb_map[tostring(n)] = c
    --[[
      [9] = 160,
      [8] = 144,
      [7] = 128,
      [6] = 112,
      [5] = 96,
      [4] = 80,
      [3] = 64,
      [2] = 48,
      [1] = 32,
      [0] = 16,
    ]]
  end

  return function(color_keys)
    if not color_keys then
      return img_file:close()
    end

    for c = 1, #color_keys do
      local keys = color_keys[c]
      if type(keys) ~= "table" then
        error("Invalid color_keys format")
      end

      local r = rgb_map[keys[1]] or 0
      local g = rgb_map[keys[2]] or 0
      local b = rgb_map[keys[3]] or 0

      -- Values can be modified to adjust:
      -- local g = math.ceil((rgb_map[keys[2]] or 0) / 2) -- halves the value of Green

      img_file:write(string.char(r, g, b))
      color_keys[c] = nil
    end
    return color_keys
  end
end

return generate_image

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