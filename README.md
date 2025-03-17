# Modular Sampling of Incremental Phi Variation

The modular sampling behavior of a golden ratio (phi) variation.

By iteratively incrementing n in the formula:

> x = (n + √(n + 1)) / (n + 2)

Unique patterns can be observed when we sample digits and apply them to a RGB map.

Included with this repo is a Lua implemenation of Phi Variance and observed from explored curiosities.

[Gallery](/GALLERY.md)

<img src="./images/phivar_mid_section_closeup_full_color.png" alt="images/phivar mid section closeup full color" width="512"/>

___

## How to

Run init.lua from terminal, optionally with arguments for width and height:

> `$ lua init.lua [width] [height]

Images generated will be placed into images folder, each dated with Unix timestamp.

___

Update March 17, 2025: I changed the sampling method. The old files are now in the `archive` folder.

## Log10

A slight adjustment was made to the original Phi variant function:

```lua
  local function phi_variant(n)
    local n = math_abs(math_log10(n + math_sqrt(n + 1)) / 2 + n)
    local i = n % 1
    return n - i * i
  end
```

And instead of occurrences of 0.5, we now sample all values:

```lua
  local n = phi_variant(n)
    table_insert(colors, {
        string_sub(tostring(n), -3, -3),
        string_sub(tostring(n), -2, -2),
        string_sub(tostring(n), -1, -1)
    })
```

To elaborate, if phi_variant = 1234.56789, then we capture 7, 8, 9.

The captured numbers become index keys from a RGB map to render the images.

```lua
  local function phi_variant(n)
    local n = abs(log10(n + sqrt(n + 1)) / 2 + n)
    local i = n % 1
    return n-i * i
  end
```

this function, which increments `n` during a loop, is the phi golden formula with incremental values in the square and division part. 
the log10 is applied and then absolute value.
`n % 1` gets the decimal from `n`, then we substract it from `n` and multiply by `n`

in the inner loop, 

```lua
  local n = phi_variant(n)
  if n then
    local nchar = tostring(n)
    insert(color_keys, {
        sub(nchar, -3, -3),
        sub(nchar, -2, -2),
        sub(nchar, -4, -4)
    })
  end
```

after retreiving the value of `n`, we use sub to pick the digit of `n` of the sub(). In Lua indexes start at 1, so `-2` is the second from last digit.
These digits each represent an RGB color, for each row is R or G or B respectively.
To colorize the pixel, the gradient map is:

```lua
  for n = 9,0,-1 do
    local c = 16 * (n+1)
    rgb_map[tostring(n)] = c
  end
```
This gives us 10 colors. The digit of each row become a colored pixel.


___

Archived

___

## Frequency of x.5 depends on step size

By increasing the step size (Z) of (n), x.5 can be found at different intervals.

- When Z = n + 1: `y = (y + 2)`
- When Z = n + 2: `y = (y + 4)`
- When Z = n + 3: `y = (y * 2 + 2) ω (y / 2 + 1)`
  - alternates between the (y) values of (Z = 2) and (Z = 1)
- When Z = 4: `y = (y + 2)`
- When Z = 5, or 6, or 7, the pattern of y is:
  - "alternating between adding 4 and 6 to the number before the current position"

```
Z:6 n:48  x:75.5   y:4
Z:6 n:120 x:185.5  y:12 -- add 4 to previous number
Z:6 n:168 x:258.5  y:8  -- add 6 to previous number
Z:6 n:288 x:440.5  y:20 -- add 4 to previous number
Z:6 n:360 x:549.5  y:12 -- etc
Z:6 n:528 x:803.5  y:28
Z:6 n:624 x:948.5  y:16
Z:6 n:840 x:1274.5 y:36
```

- When Z = 8, `y = (y + 1)`
- When Z = 9, the pattern of y is similar to 5,6, and 7, instead alternating between 4 and 14.

![images/y_frequency_plot.png](images/y_frequency_plot.png)

___

## Serial Palindromes

From each appearance of x.5, we isolate the last integer of n (Ln), then add it to the series of it's step size.

- example:
  - if `x = 1234.5` and `n = 320`, then `Ln = 0`

We can now map the series of Ln to a grid, where the rows are step_size and columns are the steps between x.5

Multiple numerical palindromes are found virtually anywhere in the grid, some also containing "meta-palindromes"

  Example output of Ln:
```
    0385458309038545830903854583090385458309038545830903854583090385458309038545830
    0848008480084800848008480084800848008480084800848008480084800848008480084800848
    0354839085580938453003548390855809384530035483908558093845300354839085580938453
```

Wanting to visualize the pattern, we create a gradient color scheme and assign each number to a color.

The image produces creates an "multiplicative cascading" image along symmetric verical axes.

[Generated from 9217 different step sizes](images/last_of_n_long.png)

___

## Deviation from symmetry.

At line 1785, the first instance of asymmetry can be seen (when using a width of 80):

`09944444999994444449999944444999999444449999944444499999444449999994444499999444`

These asymmetrical numbers will increase in occurrence as the step size increases.

It is unclear why this happens, or whether it eventually regains stereoscopy.