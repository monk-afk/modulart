-- init.lua
local function sample_mod_phi(step_size_end, max_step_count)
  local data = {
    [0] = {"Z", "c", "n", "x", "Ln", "Lx", "y"}
  }

  for Z = 1, step_size_end do
    local c = 0  -- number of times we encounter x.5
    local y = 0  -- steps between x.5
    data[Z] = {}

    for n = 0, max_step_count, Z do
      y = y + 1

      local x = (n + math.sqrt(1 + n)) / 2 + n  -- incremental phi variation

      if math.abs(x) % 0.5 == 0 then
        local Ln = tostring(n):sub(-1) -- the last digit of n
        local Lx = tostring(x):sub(-3,-3) -- the last integer of x.5
        c = c + 1

        data[Z][c] = {Z, c, n, x, Ln, Lx, y}

        y = 0
      end
    end
  end
  return data
end


local frame_multiplier = 1 -- to generate symmetrical pixmap (anything over 3 takes a long time)
local step_size_end = 9 * (4 ^ frame_multiplier)
local max_step_count = 8100 * (4 ^ (2 * frame_multiplier))

local data = sample_mod_phi(step_size_end, max_step_count)

io.write(
  table.concat(data[0], "\t"), "\n")

for step_size = 1, #data do
  local step_data = data[step_size]

  for step = 1, #step_data do
    io.write(
      table.concat(step_data[step], "\t"), "\n")
  end
end
io.stdout:flush()

-- uncomment to generate images
-- dofile("pixmap.lua")(data)
-- dofile("gnuplot.lua")(data)




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