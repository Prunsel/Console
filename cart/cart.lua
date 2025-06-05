
-- Test cart

function load()
    time = 0
    x = 0
    y = 0
end

function update(dt)
    time = time + 0.01
    x = sin(time) * 40 + 64
    y = cos(time) * 40 + 64
end

function draw()
    rectangle(1,1, 127, 127, colors.white)
    circle_fill(64, 64, 10, colors.yellow)
    circle_fill(64, 64, 5 + abs(sin(time * 2)) * 3, colors.orange)
    circle_fill(x, y, 7, colors.red)
    circle_fill(x + sin(time * 3.14) * 20, y + cos(time * 3.14) * 20, 3, colors.grey)
end