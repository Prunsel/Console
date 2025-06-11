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
**NOTE : **The key should be one from the list, I can't guarentee it will work with other keys.
