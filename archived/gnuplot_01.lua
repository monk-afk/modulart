-- gnuplot.lua
-- This needs to be re-written to support new init.lua which doesn't write to file.data
local function plot_graph(data)
  local data_file = "data/mod_phi.data"

  if data then
    local file = io.open(data_file, "w")
    file:write(
      table.concat(data[0], " "), "\n")
    for step_size = 1, #data do
      local step_data = data[step_size]

      for step = 1, #step_data do
        file:write(
          table.concat(step_data[step], " "), "\n")
      end
    end
    file:close()
  end

  local exe_cute = [[
    gnuplot -e "set terminal pngcairo background '#000000' size 1600, 900;\
      set output 'y_frequency_plot.png';\
      set border;\
      set key autotitle columnhead textcolor rgb '0xFFFFFF';\
      set grid ytics mytics xtics lc rgb '0xFFFFFF';\

      set xlabel tc rgb '0xFFFFFF';\
      set xtics nomirror tc rgb '0xFFFFFF';\

      set ylabel tc rgb '0xFFFFFF';\
      set ytics nomirror tc rgb '0xFFFFFF';\

      set autoscale y;\
      set samples 100;\
      set isosamples 60;\
      unset view;\
      plot
        '< cat ]] .. data_file .. [[' using 1 axes x1y1 lt 0 lc rgb '0x00FF00' with p"\
    ]]
  os.execute(exe_cute)
end

-- can run without re-calculating data, just run `$ gnuplot.lua foo` to trigger condition
-- return arg[1] and plot_graph() or plot_graph

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