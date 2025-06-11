
-- Test cart

function load()
    time = 1
    bx = 64
    by = 64
    bspd = 1
    bxv = -1
    byv = -1
    p1y = 20
    p2y = 44
    pspeed = 1
    pwidth = 4
    pheight = 20
    score1 = 0
    scoresize1 = 1
    scoresize2 = 1
    score2 = 0

    background = model_load("cylinder.obj", "texture.png")
    level = model_load("level.obj", "texture.png")

    particles = {}
    font = font_load("fonts/CrimsonText-Bold.ttf")

end

function update(dt)
    time = time + 0.01
    
    -- paddle 1
    if key_held(key_down) or btn_held("down") then p1y = p1y + pspeed end
    if key_held(key_up) or btn_held("up") then p1y = p1y - pspeed end
    p1y = clamp(p1y, 2, 125 - pheight)

    -- paddle 2
    if by > p2y then p2y = p2y + pspeed
    elseif by < p2y + pheight then p2y = p2y - pspeed end
    p2y = clamp(p2y, 2, 125 - pheight)

    -- ball update
    bx = bx + bxv * bspd
    by = by + byv * bspd
    if point_in_rectangle(bx,by, 8,p1y - 2, 1,pheight + 3) or point_in_rectangle(bx,by, 117,p2y - 2, 1,pheight + 3) then 
        for i = 1, 10 do new_particle(bx, by, "bounce") end
        bxv = -bxv
        byv = (byv / abs(byv)) * random(0.8, 1.5)
    end
    if by <= 3 then 
        byv = -byv 
        for i = 1, 10 do new_particle(bx,by, "bounce2") end
    end
    if by >= 124 then 
        byv = -byv
        for i = 1, 10 do new_particle(bx,by, "bounce2") end 
    end
    if bx >= 124 then
        for i = 1, 10 do new_particle(bx,by,"score") end
        bx = 64
        by = 64
        byv = ((p2y - by) / abs(p2y - by)) / 2
        bxv = 1
        score1 = score1 + 1
        scoresize1 = 3
    end
    if bx <= 0 then
        for i = 1, 10 do new_particle(bx,by,"score") end
        bx = 64
        by = 64
        byv = ((p1y - by) / abs(p1y - by)) / 2
        bxv = -1
        score2 = score2 + 1
        scoresize2 = 3
    end

    -- ball trail
    new_particle(bx,by,"trail")

    -- update score text
    if scoresize1 > 1 then
        scoresize1 = scoresize1 - 0.1 
    end
    if scoresize2 > 1 then
        scoresize2 = scoresize2 - 0.1 
    end

    -- update particles
    update_particles()
end

function draw()
    model_draw(background, 20, 0, -30 + sin(time * 2) * 5, pi / 2, 0, time, 30, 30, 30)
    rectangle_fill(0,0, 128,128, {0,0,0, 0.8})

    -- draw paddles
    rectangle_fill(4,p1y + 1, pwidth,pheight - 1, colors.white)
    rectangle_fill(5,p1y, pwidth / 2, pheight + 1, colors.light_grey)
    rectangle_fill(120,p2y + 1, pwidth,pheight - 1, colors.white)
    rectangle_fill(121,p2y, pwidth / 2, pheight + 1, colors.light_grey)
    
    -- draw line
    line(64,0, 64,128, colors.light_grey)

    -- draw scores
    color_set(colors.white)
    if scoresize1 > 1 then color_set(colors.yellow) end
    print(score1, 32, 20, 0, scoresize1, scoresize1, font)
    color_set(colors.white)
    if scoresize2 > 1 then color_set(colors.yellow) end
    print(score2, 90, 20, 0, scoresize2, scoresize2, font)
    color_set(colors.white)
    
    -- draw ball
    circle_fill(bx, by, 3, colors.red)

    -- border
    rectangle(1,1, 127,127, colors.white)

    -- particle draw
    draw_particles()

    -- reset colour
    color_set(colors.white)
end

function new_particle(x, y, type)
    local new = {}
    new.x = x
    new.y = y
    new.type = type
    new.age = 0
    if new.type == "score" or new.type == "bounce" then
        new.xv = random(-bxv * 10,(-bxv + 1) * 10) / 10
        new.yv = random(-10, 10) / 10
    elseif new.type == "bounce2" then
        new.xv = random(-10, 10) / 10
        new.yv = random(byv * 10,(byv + 1) * 10) / 20
    end
    array_add(particles, new)
end

function draw_particles()
    for i = 1, #particles do
        local this = particles[i]
        if this.type == "trail" then
            circle_fill(this.x, this.y, 4 - this.age / 8, {1,0,0, (31 - this.age) / 31})
        elseif this.type == "score" then
            circle_fill(this.x, this.y, 5 - this.age / 5 + 1, colors.white)
            circle_fill(this.x, this.y, 5 - this.age / 5, colors.red)
        elseif this.type == "bounce" or "bounce2" then
            circle_fill(this.x, this.y, 3 - this.age / 8 + 1, colors.grey)
            circle_fill(this.x, this.y, 3 - this.age / 8, colors.white)
        end

    end
end

function update_particles()
    for i = #particles,1, -1 do
        local this = particles[i]
        this.age = this.age + 1
        if this.type == "trail" then
            if this.age > 31 then array_delete(particles, i) end
        elseif this.type == "score" or "bounce" then
            if this.age > 24 then array_delete(particles, i) end
            this.x = this.x + this.xv
            this.y = this.y + this.yv
            --this.yv = this.yv + 0.1
        elseif this.type == "bounce2" then
            if this.age > 24 then array_delete(particles, i) end
            this.x = this.x + this.xv
            this.y = this.y + this.yv
        end

    end
end