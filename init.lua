-- init.lua
local function sample_mod_phi(max_width, max_height, r, g, b)
  local insert = table.insert
  local sub = string.sub
  local draw = dofile("pixmap.lua")(max_width, max_height)

  local color_keys = {}

  for step_size = 1, max_height do
    for n = 0, math.huge, step_size do
        insert(color_keys, {
            sub(n, r, r),
            sub(n, g, g),
            sub(n, b, b)
        })
      if #color_keys == max_width then
        color_keys = draw(color_keys)
        break 
      end
    end
  end
  return draw(false) -- false will close the ppm file
end


local function init(clip)
  local max_width = tonumber(clip.w or clip.width) or 500
  local max_height = tonumber(clip.h or clip.height) or max_width
  local r = tonumber(clip.r) or tonumber(clip.red)   or -3
  local g = tonumber(clip.g) or tonumber(clip.green) or -3
  local b = tonumber(clip.b) or tonumber(clip.blue)  or -3

  sample_mod_phi(max_width, max_height, r, g, b)
end


local clip = dofile("clip.lua")

if clip.help then
  dofile("help.lua")
else
  init(clip)
end

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