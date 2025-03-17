-- init.lua
local function sample_mod_phi(max_width, max_height, Z)
  local sqrt = math.sqrt
  local abs = math.abs
  local log10 = math.log10
  local insert = table.insert
  local sub = string.sub
  local draw = dofile("pixmap.lua")(max_width, max_height)

  local color_keys = {}

  local function phi_variant(n)
    local n = abs(log10(n + sqrt(n + 1)) / 2 + n)
    local i = n % 1
    return n - i * i
  end

  for layer = 1, max_height do
    for n = 0, math.huge, layer do
      local nchar = tostring(phi_variant(n))
      if nchar then
        insert(color_keys, {
            sub(nchar, -3, -3),
            sub(nchar, -2, -2),
            sub(nchar, -4, -4)
        })
      end

      if #color_keys == max_width then
        color_keys = draw(color_keys)
        break 
      end
    end
    if not dofile("signal.lua") then break end
  end
  return draw(false) -- false will close the ppm file
end


local function init(arg)
  local max_width = arg and tonumber(arg[1]) or 80
  local max_height = arg and tonumber(arg[2]) or 8100

  return sample_mod_phi(max_width, max_height)
end

io.open("signal.lua", "w"):write("return true"):close()

return init(arg)

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