# ModulArt

ModulArt explores the interference patterns produced by modular residue fields. Complex images emerge from the composition of simple residue layers, revealing moiré-like structures that remain deterministic and fully reproducible from a small set of parameters.

## Rendering Images

`modulart.lua` generates binary PPM images from a deterministic modular sampling rule:

> sample = ((z * y) % X) % M + 1

Where `sample` is the palette index used for the pixel, defined by:

- `z`, `y` are pixel coordinates.
- `X` is the modulus value that selects the pattern family.
- `M` is the number of palette slots.

Palette index placement radically changes macro patterns, and act like individual residue layers or combined overlays of the included residue layers.

The script creates `/tmp/modulart_images` if needed and writes `.ppm` files there. Each image is 128 pixels wide and 64 pixels tall.

Run the generator from command line:

```sh
lua modulart.lua
```

Uses:

- `min=40`
- `max=50`
- `palette=8`

This generates every non-empty active-layer combination for each `X` in the range from `min` through `max`.

> [!TIP]
> For best performace, use `LuaJIT` if available.

## Command Line Arguments

Arguments may be passed as `name=value` or `--name=value`.

```sh
lua modulart.lua min=40 max=42 palette=8
```

Supported arguments:

- `min`: first `X` value to render. Default: `40`.
- `max`: last `X` value to render. Default: `50`.
- `w`: image width in pixels. Default: `128`.
- `h`: image height in pixels. Default: `128`.
- `palette`: palette slot count for exhaustive generation. Default: `8`.
- `mask`: exact palette mask to render.

## Palette Masks

A palette mask is a string of two or more `B` and `C` characters:

- `B` means black / inactive residue layer.
- `C` means colored / active residue layer.

For example:

```sh
lua modulart.lua min=46 max=46 mask=BBCBCBBB
```

This renders only the exact `BBCBCBBB` palette for `X=46`.

When `mask` is omitted, the script generates every non-empty palette combination for the requested `palette` size. For `palette=8`, that is `2^8 - 1`, or 255 images per `X` value.

## Filenames

Output filenames include the current generation parameters:

```text
modulart_X46_BBCBCBBB.ppm
```

In this filename:

- `X46` means `X = 46`.
- `BBCBCBBB` is the palette mask.

The output is deterministic. The same `X` and palette mask produce the same image.

## PPM to PNG

PPM (P6) is a simple binary raster image format that stores raw RGB pixel data preceded by a small text header. No external libraries are required for Lua to generate PPM images directly.

To convert PPM images into more widely supported formats such as PNG, JPEG, or WebP, it is recommended to use ImageMagick's `convert` utility.

```bash
convert modulart_X46_BBCBCBBB.ppm modulart_X46_BBCBCBBB.png
```
