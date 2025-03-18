# Sampled Digit Position

Below are examples of the images produced by sampling different positional digits.

Starting from Left, position 1, through 14, the last digit of each product of:

```lua
  local function phi_variant(n)
    local n = abs(log10(n + sqrt(n + 1)) / 2 + n)
    return tostring(n):gsub("%D", "")
  end
```

> pos 1

<img src="./phivar_pos-01.png" alt="./phivar_pos-01.png" width="256"/>

> pos 2

<img src="./phivar_pos-02.png" alt="./phivar_pos-02.png" width="256"/>

> pos 3

<img src="./phivar_pos-03.png" alt="./phivar_pos-03.png" width="256"/>

> pos 4

<img src="./phivar_pos-04.png" alt="./phivar_pos-04.png" width="256"/>

> pos 5

<img src="./phivar_pos-05.png" alt="./phivar_pos-05.png" width="256"/>

> pos 6

<img src="./phivar_pos-06.png" alt="./phivar_pos-06.png" width="256"/>

> pos 7

<img src="./phivar_pos-07.png" alt="./phivar_pos-07.png" width="256"/>

> pos 8

<img src="./phivar_pos-08.png" alt="./phivar_pos-08.png" width="256"/>

> pos 9

<img src="./phivar_pos-09.png" alt="./phivar_pos-09.png" width="256"/>

> pos 10

<img src="./phivar_pos-10.png" alt="./phivar_pos-10.png" width="256"/>

> pos 11

<img src="./phivar_pos-11.png" alt="./phivar_pos-11.png" width="256"/>

> pos 12

<img src="./phivar_pos-12.png" alt="./phivar_pos-12.png" width="256"/>

> pos 13

<img src="./phivar_pos-13.png" alt="./phivar_pos-13.png" width="256"/>

> pos 14

<img src="./phivar_pos-14.png" alt="./phivar_pos-14.png" width="256"/>
