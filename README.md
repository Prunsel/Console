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

`color(r, g, b, a)`
Returns a colour from the values, from `1` to `16`

`color_set(r, g, b, a)`/`(col)`
Sets the drawing colour from a table or the values.

### Maths
**NOTE:**These functions/constants don't really need explanations. If you dont 
know what these do then look them up, they are very simple. Also there is 
probably a lot missing here.

`pi`

`random(min, max)`

`clamp(value, min, max)`

`abs( value )`

`sqrt( value )`

`floor( value )`

`ceil( value )`

`sin( value )`

`cos( value )`

`tan( value )`

### Array functions

`pairs( array )`
Used for `for i, this in pairs(array)`

`array_add( array, value )`
Adds `value` to the end of `array`

`array_delete( array, index)`
Removes a value from an `array` at the `index`

`array_random( array )`
Returns a random value from an `array`.

### Text
`print(text, x, y, rotation, scale_x, scale_y, font, colour)`
Prints `text` at the given position. `font` and `colour` are optional.

`font_load( filepath )`
Loads the font at the `filepath` like `sprite_load` and returns a `font`

### 2D Collision
Useful functions for 2D Collision

point_in_rectangle( x, y, x2, y2, width, height)
Returns `true` or `false` depending in if the point `x y` is in the rectangle.

### 3D Collison
Ditto for 3D

`point_in_cuboid(x, y, z, x2, y2, z2, width, hight, depth)`
Returns `true` or `false` depending if the point `x y z ` is in the cuboid.

### 2D Shapes
**NOTE:** Colour is an optional argument
**NOTE:** These functions are also self explanatory.

`pixel(x, y, colour)`

`rectangle(x, y, width, height, colour)`

`rectangle_fill(x, y, width, hight, colour)`

`line(x1, y1, x2, y2, colour)`

`triangle(x1, y1, x2, y2, x3, y3, colour)`

`triangle_fill(x1, y1, x2, y2, x3, y3, colour)`

`circle(x, y, radius, colour)`

`circle_fill(x, y, radius, colour)`

## 3D Shapes + Models

`model_load( filepath, texture_path)`
Returns a 3D model.

`model_draw(model, x, y, z, rotate_x, rotate_y, rotate_z, scale_x, scale_y, scale_z)`
Draws a 3D model.








