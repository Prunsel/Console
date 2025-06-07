
-- Fantasy console

-- get libraries
g3d = require("lib/g3d")

-- remove blur
love.graphics.setDefaultFilter("nearest", "nearest")

-- pixel lines
love.graphics.setLineStyle("rough")

-- resolution
res = 128

-- window resizing
love.window.setFullscreen(true)
scale = love.graphics.getHeight() / res
transform_x = love.graphics.getWidth() / scale / 2 - (res / 2)
love.graphics.setPointSize(scale)

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

-- built in functions for the 
enviroment = {

    -- \/ ##### Buttons ##### \/

    key_up = "up",
    key_down = "down",
    key_left = "left",
    key_right = "right",
    key_Z = "z",
    key_X = "x",

    btn_held = function(button)
        return love.keyboard.isDown(button)
    end,

    btn_press = function(button)
        if pressed_buttons[button] then
            pressed_buttons[button] = false
            return true
        else
            return false
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

    -- \/ ##### 2D Collision ##### \/

    point_in_rectangle = function(x, y, x2, y2, w, h)
        return x >= x2 and x <= x2 + w and y >= y2 and y <= y2 + h
    end,

    -- \/ ##### Text ##### \/

    print = function(text, x, y, r, sx, sy, col)
        if col then love.graphics.setColor(col) end
        love.graphics.print(text, x, y, r, sx, sy)
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
bad_cart_image = love.graphics.newImage("assets/sprites/bad_cart.png")

-- load
function love.load()

    -- load cart
    if loadfile("cart/cart.lua") then
        cart = loadfile("cart/cart.lua")
        setfenv(cart, enviroment)
        cart()
        cart_load = enviroment.load
        cart_update = enviroment.update
        cart_draw = enviroment.draw
        cart_load()
    else
        bad_cart = true
    end

    -- canvas
    canvas = love.graphics.newCanvas(res, res)

end


-- update
function love.update(dt)
    if cart_update then cart_update(dt) end
end


-- draw
function love.draw()

    -- set canvas
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    
    -- draw
    if cart_draw then cart_draw() end
    if bad_cart == true then love.graphics.draw(bad_cart_image, 0, 0) end

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

-- keypressed
function love.keypressed(key)
    for id, button in pairs(button_map) do
        if key == button then
            pressed_buttons[id] = true
        end
    end
end