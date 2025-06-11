
-- Fantasy console

-- get libraries
g3d = require("lib/g3d")

-- remove blur
love.graphics.setDefaultFilter("nearest", "nearest")

-- resolution
res = 128

-- window resizing
love.window.setFullscreen(true)
scale = love.graphics.getHeight() / res
transform_x = love.graphics.getWidth() / scale / 2 - (res / 2)
love.graphics.setPointSize(scale)
love.graphics.setLineStyle("rough")

-- button mapping
button_map = {
    ["up"] = "up",
    ["down"] = "down",
    ["left"] = "left",
    ["right"] = "right",
    ["z"] = "z",
    ["x"] = "x",
}
pressed_buttons = {}

-- gamepad buttons
gamepad_buttons = {
    x = false,
    z = false,
    up = false,
    down = false,
    left = false,
    right = false,
}

-- is cart playing
cart_playing = false

-- built in functions for the console
enviroment = {

    -- \/ ##### Resolution ##### \/

    set_resolution = function(n)
        res = n
        scale = love.graphics.getHeight() / res
        transform_x = love.graphics.getWidth() / scale / 2 - (res / 2)
        love.graphics.setPointSize(scale)
        canvas = love.graphics.newCanvas(res, res)
    end,

    get_resolution = function(n)
        return res
    end,

    -- \/ ##### Buttons ##### \/

    key_up = "up",
    key_down = "down",
    key_left = "left",
    key_right = "right",
    key_Z = "z",
    key_X = "x",

    key_held = function(button)
        return love.keyboard.isDown(button)
    end,

    key_press = function(button)
        if pressed_buttons[button] then
            pressed_buttons[button] = false
            return true
        else
            return false
        end
    end,

    btn_held = function(button)
        if love.joystick.getJoysticks()[1] then
            if button == "up" then return (love.joystick.getJoysticks()[1]:getAxis(2) == -1) end
            if button == "down" then return (love.joystick.getJoysticks()[1]:getAxis(2) == 1) end
            if button == "left" then return (love.joystick.getJoysticks()[1]:getAxis(1) == -1) end
            if button == "right" then return (love.joystick.getJoysticks()[1]:getAxis(1) == 1) end
            return love.joystick.getJoysticks()[1]:isDown(button)
        end
    end,

    -- \/ ##### Assets ##### \/

    sprite_load = function(filepath)
        return love.graphics.newImage("cart/"..filepath)
    end,

    sprite_draw = function(sprite, x, y, r, sx, sy, col)
        if col then love.graphics.setColor(col) end
        return love.graphics.draw(sprite, x, y, r, sx, sy)
    end,

    sfx_load = function(filepath)
        return love.audio.newSource("cart/"..filepath)
    end,

    sfx_play = function(sfx)
        return love.audio.play(sfx)
    end,

    -- \/ ##### Colors ##### \/

    colors = {
        red = {1,0,0},
        orange = {1,0.5,0},
        yellow = {1,1,0},
        lime = {0.5,1,0},
        green = {0,1,0},
        cyan = {0,1,1},
        blue = {0,0.5,1},
        indigo = {0,0,1},
        violet = {0.5,0,1},
        purple = {1,0,1},
        white = {1,1,1},
        light_grey = {0.8,0.8,0.8},
        grey = {0.5,0.5,0.5},
        dark_grey = {0.2,0.2,0.2},
        black = {0,0,0},
    },

    color = function(r, g, b, a)
        if a then return {r / 16, g / 16, b / 16, a / 16}
        else return {r / 16, g / 16, b / 16} end
    end,

    color_set =  function(r, g, b, a)
        love.graphics.setColor(r, g, b, a)
    end,

    -- \/ ##### Maths ##### \/

    pi = math.pi,

    random = function(min, max)
        return love.math.random(min, max)
    end,

    clamp = function(n, min, max)
        return math.max(math.min(n, max), min)
    end,

    abs = function(n)
        return math.abs(n)
    end,

    sqrt = function(n)
        return math.sqrt(n)
    end,

    floor = function(n)
        return math.floor(n)
    end,

    ceil = function(n)
        return math.ceil(n)
    end,

    sin = function(n)
        return math.sin(n)
    end,

    cos = function(n)
        return math.cos(n)
    end,

    tan = function(n)
        return math.tan(n)
    end,

    -- \/ ##### Arrays ##### \/

    pairs = function(n)
        return pairs(n)
    end,

    array_add = function(array, n)
        table.insert(array, #array + 1, n)
    end,

    array_delete = function(array, n)
        table.remove(array, n)
    end,

    array_random = function(array)
        return array[floor(love.math.random(1, #array))]
    end,

    -- \/ ##### Text ##### \/

    print = function(text, x, y, r, sx, sy, font, col)
        if font then love.graphics.setFont(font) end
        if col then love.graphics.setColor(col) end
        love.graphics.print(text, x, y, r, sx, sy)
    end,

    font_load = function(filepath)
        local font = love.graphics.newFont("cart/"..filepath)
        font:setFilter("nearest", "nearest")
        return font
    end,

    -- \/ ##### 2D Collision ##### \/

    point_in_rectangle = function(x, y, x2, y2, w, h)
        return x >= x2 and x <= x2 + w and y >= y2 and y <= y2 + h
    end,

    -- \/ ##### 3D Collision ##### \/

    point_in_cuboid = function(x, y, z, x2, y2, z2, w, h, d)
        return x >= x2 and x <= x2 + w and y >= y2 and y <= y2 + h and z >= z2 and z <= z2 + d
    end,

    -- \/ ##### 2D Shapes ##### \/

    pixel = function(x, y, col)
        if col then love.graphics.setColor(col) end
        love.graphics.points(x, y)
    end,

    rectangle = function(x, y, w, h, col)
        if col then love.graphics.setColor(col) end
        love.graphics.rectangle("line", x, y, w, h)
    end,

    rectangle_fill = function(x, y, w, h, col)
        if col then love.graphics.setColor(col) end
        love.graphics.rectangle("fill", x, y, w, h)
    end,

    line = function(x1, y1, x2, y2, col)
        if col then love.graphics.setColor(col) end
        love.graphics.line(x1,y1, x2,y2)
    end,

    triangle = function(x1, y1, x2, y2, x3, y3, col)
        if col then love.graphics.setColor(col) end
        love.graphics.polygon("line", x1, y1, x2, y2, x3, y3)
    end,

    triangle_fill = function(x1, y1, x2, y2, x3, y3, col)
        if col then love.graphics.setColor(col) end
        love.graphics.polygon("fill", x1, y1, x2, y2, x3, y3)
    end,

    circle = function(x, y, r, col)
        if col then love.graphics.setColor(col) end
        love.graphics.circle("line", x, y, r)
    end,

    circle_fill = function(x, y, r, col)
        if col then love.graphics.setColor(col) end
        love.graphics.circle("fill", x, y, r)
    end,

    -- \/ ##### 3D Shapes ##### \/

    model_load = function(filepath, texturepath)
        return g3d.newModel("cart/"..filepath, "cart/"..texturepath)
    end,

    model_draw = function(model, x, y, z, rx, ry, rz, sx, sy, sz)
        if sx then 
            model:setTransform({x,y,z}, {rx,ry,rz}, {sx,sy,sz})
        elseif rx then
            model:setTransform({x,y,z}, {rx,ry,rz})
        else
            model:setTransform({x,y,z})
        end
        model:draw()
    end,

}

-- set color to white
love.graphics.setColor(1,1,1, 1)

-- set bad cart to false
bad_cart = false

-- menu things
bad_cart_image = love.graphics.newImage("assets/sprites/bad_cart.png")
no_cart_image = love.graphics.newImage("assets/sprites/no_cart.png")

-- load
function love.load()
    -- canvas
    canvas = love.graphics.newCanvas(res, res)

    -- load cart
    load_cart()

end


-- update
function love.update(dt)
    -- cart update
    if cart_update and cart_playing then cart_update(dt)
    else
        if love.keyboard.isDown("z") or love.joystick.getJoysticks()[1] and love.joystick.getJoysticks()[1]:isDown(2) then load_cart() end
    end
    
end


-- draw
function love.draw()

    -- set canvas
    love.graphics.setCanvas(canvas)
    love.graphics.clear()

    -- draw
    if cart_draw and cart_playing then cart_draw()
    elseif bad_cart == false then
        love.graphics.rectangle("line", 1,1, 127,127)
        love.graphics.draw(no_cart_image, 0, 0, 0, res / no_cart_image:getWidth())
    elseif bad_cart == true then
        love.graphics.draw(bad_cart_image, 32, 0, 0, 2)
    end

    -- reset colour
    love.graphics.setColor(1,1,1,1)

    -- draw back to normal screen
    love.graphics.setCanvas()

    -- scale and transform
    love.graphics.scale(scale,scale)
    love.graphics.translate(transform_x, 0)

    -- draw canvas
    love.graphics.draw(canvas, 0, 0)

end

-- load cart
function load_cart()
    -- load cart
    if loadfile("cart/cart.lua") then
        cart = loadfile("cart/cart.lua")
        setfenv(cart, enviroment)
        cart()
        cart_load = enviroment.load
        cart_update = enviroment.update
        cart_draw = enviroment.draw
        cart_load()
        cart_playing = true
        bad_cart = false
    elseif not love.filesystem.getRealDirectory("cart/cart.lua") then
        bad_cart = false
    end
end

-- keypressed
function love.keypressed(key)
    for id, button in pairs(button_map) do
        if key == button then
            pressed_buttons[id] = true
        end
    end
end
