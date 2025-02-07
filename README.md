Modular Sampling of Incremental Phi Variation
-----

The modular sampling behavior of a golden ratio (phi) variation.

By iteratively incrementing n in the formula:

> x = (n + √(n + 1)) / (n + 2)

Unique patterns can be observed when we sample x values ending in 'x.5'.

Included with this repo is a Lua implemenation of (n + √(n + 1)) / (n + 2)

Also includes helpers for plotting with gnuplot, and drawing a pixelmap images (.ppm)

___

# Frequency of x.5 determined by (n + Z)

By increasing the step size (Z) of (n), x.5 can be found at different intervals (y).

When Z = n + 1: `y = (y + 2)`

```
  Z:1 n:0  x:0.5  y:1
  Z:1 n:3  x:5.5  y:3
  Z:1 n:8  x:13.5 y:5
  Z:1 n:15 x:24.5 y:7
  Z:1 n:24 x:38.5 y:9
```

When Z = n + 2: `y = (y + 4)`

```
  Z:2 n:0  x:0.5    y:1
  Z:2 n:8  x:13.5   y:4
  Z:2 n:24 x:38.5   y:8
  Z:2 n:48 x:75.5   y:12
  Z:2 n:80 x:124.5  y:16
  Z:2 n:120 x:185.5 y:20
```

When Z = n + 3: `y = (y * 2 + 2) ω (y / 2 + 1)`
  - alternates between the (y) values of (Z = 2) and (Z = 1)

```
  Z:3 n:0   x:0.5   y:1
  Z:3 n:3   x:5.5   y:1
  Z:3 n:15  x:24.5  y:4
  Z:3 n:24  x:38.5  y:3
  Z:3 n:48  x:75.5  y:8
  Z:3 n:63  x:98.5  y:5
  Z:3 n:99  x:153.5 y:12
  Z:3 n:120 x:185.5 y:7
  Z:3 n:168 x:258.5 y:16
  Z:3 n:195 x:299.5 y:9
  Z:3 n:255 x:390.5 y:20
```

When Z = 4: `y = (y + 2)`


When Z = 5, or 6, or 7, the pattern of y is:

"alternating between adding 4 and 6 to the number before the current position"

Z:6 n:48  x:75.5   y:4
Z:6 n:120 x:185.5  y:12 -- add 4 to previous number
Z:6 n:168 x:258.5  y:8  -- add 6 to previous number
Z:6 n:288 x:440.5  y:20 -- add 4 to previous number
Z:6 n:360 x:549.5  y:12 -- etc
Z:6 n:528 x:803.5  y:28
Z:6 n:624 x:948.5  y:16
Z:6 n:840 x:1274.5 y:36

When Z = 8, `y = (y + 1)`

When Z = 9, the pattern of y is similar to 5,6, and 7, with the difference being alternating between 4 and 14.

Related image: [images/y_frequency_plot.png](images/y_frequency_plot.png)

___

# Serial Palindromes

From each appearance of x.5, we isolate the last integer digits of x (Lx) and n (Ln), then add it to the series of it's step size.

- example:
  - if `x = 1234.5` and `n = 320`, then `Lx = 4` and `Ln = 0`

We can now map the series of Lx or Ln to a grid, where the rows are step_size and columns are the steps between x.5

Multiple numerical palindromes are found virtually anywhere in the grid, some also containing "meta-palindromes"

  Example output of Ln:
```
    0385458309038545830903854583090385458309038545830903854583090385458309038545830
    0848008480084800848008480084800848008480084800848008480084800848008480084800848
    0354839085580938453003548390855809384530035483908558093845300354839085580938453
    0848008480084800848008480084800848008480084800848008480084800848008480084800848
    0550055005500550055005500550055005500550055005500550055005500550055005500550055
    0480880840048088084004808808400480880840048088084004808808400480880840048088084
    0538493805508394835005384938055083948350053849380550839483500538493805508394835
    0848008480084800848008480084800848008480084800848008480084800848008480084800848
    0398053485584350893003980534855843508930039805348558435089300398053485584350893
    0000000000000000000000000000000000000000000000000000000000000000000000000000000
    0930835845548538039009308358455485380390093083584554853803900930835845548538039
    0480880840048088084004808808400480880840048088084004808808400480880840048088084
    0354839085580938453003548390855809384530035483908558093845300354839085580938453
    0848008480084800848008480084800848008480084800848008480084800848008480084800848
    0505505005055050050550500505505005055050050550500505505005055050050550500505505
    0804884080080488408008048840800804884080080488408008048840800804884080080488408
    0538493805508394835005384938055083948350053849380550839483500538493805508394835
    0804884080080488408008048840800804884080080488408008048840800804884080080488408
    0398053485584350893003980534855843508930039805348558435089300398053485584350893
    0000000000000000000000000000000000000000000000000000000000000000000000000000000
    0389305089435058438558348505349805039830038930508943505843855834850534980503983
```

Wanting to visualize the pattern, we create a gradient color scheme and assign each number to a color.

The image produces creates an "multiplicative cascading" image along symmetric verical axes.

[./images/last_digit_of_n.png](images/last_digit_of_n.png)

___

That's all i got for now