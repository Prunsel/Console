
-- Fantasy console

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

-- button mappings

-- built in functions for the 
enviroment = {

    -- \/ ##### Assets ##### \/

    sprite_load = function(filepath)
        return love.graphics.newImage("cart/"..filepath)
    end,

    sprite_draw = function(sprite, x, y, r, sx, sy, col)
        if col then love.graphics.setColor(col) end
        return love.graphics.draw(sprite, x, y, r, sx, sy)
    end,

    sfx_load = function(filepath)
        return love.audio.newSource(filepath)
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

    -- \/ ##### Shapes ##### \/

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
    end

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