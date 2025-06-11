# Fantasy Console
A fantasy console, inspired by PICO-8 and made in Love2D because I'm not learning C++.
It currently has a pong demo as the cart.
Carts are formatted as `cart.lua` in `cart/`

## Built-in Functions
### Resolution
`set_resolution( resolution )`
Sets the screen resolution in pixels.

`get_resolution()`
Gets the resolution of the screen.

### Inputs
`key_up`
`key_down`
`key_left`
`key_right`
`key_Z`
`key_X`
Constants for input functions.

`key_held( key )`
Checks if a key is held.
**NOTE:** The key should be one from the list, I can't guarentee it will work with 
other keys.

`key_press( key )`
Checks if a key is pressed for a frame.

`btn_held( button )`
Checks if a button on a gamepad is held.
**NOTE:** I made the gamepad mappings and stuff for a USB NES gamepad I own, so 
unless you edit the code I don't know if your controllers will work.

### Assets
**NOTE:** All of the assets should be in the `cart/` folder, and should be 
referenced as; `player.png` and not `cart/player.png` unless you have a folder 
called cart.

`sprite_load( filepath )`
Loads a sprite from a file and returns image data that can be used 
with `sprite_draw( sprite, x, y, rotation, scale_x, scale_y, colour)` to draw it.

`sfx_load( filepath )`
Loads a sound from a file simalarly to `sprite_load()`, and sounds can be
played using `sfx_play( sfx )`. More sound functions will be added in future.

### Colours
**NOTE:** I sincerly apologise for using the forbidden American letter arrangement 
for the word "Colour", or as they speak of it "Color", however the American 
version had the advantageous ability of the lack of length, which could shorten 
code. I hope my apology has persuaded the watchful eyes of the elders to forgive 
me as my bloodline continues to thrive for generations to come.

`colors`
A table that can output several preset colours:
- `red`
- `orange`
- `yellow`
- `green`
- `cyan`
- `blue`
- `indigo`
- `violet`
- `purple`
- `white`
- `light_grey`
- `grey`
- `dark_grey`
- `black`
E.g. pixel(10, 10, colors.blue)


