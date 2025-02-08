-- init.lua
local function sample_mod_phi(max_width, max_height, Z)
  local file = io.open("data/mod_phi.data", "a+")

  local math_sqrt = math.sqrt
  local math_abs = math.abs

  local function get_x(n)
    return math_abs(
        (n + math_sqrt(1 + n)) / 2 + n
      ) % 1 == 0.5
  end

  local data = {}
  local table_concat = table.concat
  local table_insert = table.insert
  local string_sub = string.sub

  for layer = 1, max_height do
    Z = Z + 1
    for n = 0, math.huge, Z do

      if get_x(n) then
        table_insert(data, string_sub(tostring(n - 0.5), -3, -3))
      end

      if #data == max_width then
        break 
      end

    end

    file:write(table_concat(data), "\n"):flush()

    for k = 1, #data do data[k] = nil end

    if not dofile("signal.lua") then break end
  end
  file:close()

  return dofile("pixmap.lua")
end


local function init(arg)
  local max_width
  local max_height = arg and tonumber(arg[2]) or 8100

  local Z = 0
  local data = io.open("data/mod_phi.data", "r")
  if data then
    for line in data:lines() do
      Z = Z + 1
      if not max_width then
        max_width = #line
      end
    end
    data:close()
  end

  if not max_width then
    max_width = arg and tonumber(arg[1]) or 80
  end

  io.open("signal.lua", "w"):write("return true"):close()

  return sample_mod_phi(max_width, max_height, Z)
end

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