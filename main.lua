Lg = love.graphics
Lk = love.keyboard
Lm = love.mouse
Lp = love.physics
Lg.setMode(800,500)

border = 10

real_screen_height = Lg.getHeight()
real_screen_width = Lg.getWidth()

screen_height = real_screen_height - 2 * border
screen_width  = real_screen_width  - 2 * border

world = Lp.newWorld(border, border, border+screen_width, border+screen_height, 0, 0)


board_w = 200
board_h = 20
board_x = (screen_width-board_w)/2
board_y = 0
board = Lp.newFixture(Lp.newBody( world, board_x, board_y, 1, 0 ),
                      Lp.newRectangleShape(board_w, board_h))

ball_radius = 20
ball_x = board_x + board_w/2
ball_y = board_h + ball_radius
ball_v_x, ball_v_y = 1, 1 --ball speed vector

brick_w = 70
brick_h = 20

function use_mouse(x)
   Lm.setVisible(not x)
   Lm.setGrab(x)
end

function mouse_used()
   return Lm.isGrabbed()
end

function draw_bricks()
   draw_brick_at(16, 1, 0)
   draw_brick_at(16, 2, 1)
   draw_brick_at(16, 3, 2)
   draw_brick_at(15, 0, 3)
   draw_brick_at(15, 1, 4)
   draw_brick_at(15, 2, 5)
   draw_brick_at(14, 0, 6)
   draw_brick_at(14, 1, 7)
   draw_brick_at(14, 2, 8)
   draw_brick_at(13, 1, 9)
   draw_brick_at(13, 2, 10)
   draw_brick_at(13, 3, 11)
end

function draw_brick_at(row,col,brick_type)
   local x = col
   local y = row
   local delta = 8
   Lg.push()
   Lg.translate(x*(brick_w+delta), y*(brick_h+delta))
   draw_brick(brick_type)
   Lg.pop()
end

function draw_brick(brick_type)
   local brick_types = 8
   brick_type = (brick_type % brick_types)
   local r,g,b,a = Lg.getColor()
   Lg.setColor(HSL(brick_type*256/brick_types,256,100,a))
   Lg.rectangle('fill', 0, 0, brick_w, brick_h)
   Lg.setColor(r,g,b,a)
end

function draw_board()
   local r,g,b,a = Lg.getColor()
   Lg.setColor(HSL(0,256,128,a))
   Lg.rectangle('fill', board_x, board_y, board_w, board_h)
   Lg.setColor(r,g,b,a)
end

function draw_ball()
   local r,g,b,a = Lg.getColor()
   Lg.setColor(HSL(85,200,100,a))
   Lg.circle("fill", ball_x, ball_y, ball_radius, 32)
   Lg.setColor(r,g,b,a)
end

function love.draw()
   Lg.push()
   Lg.scale(1, -1) -- flip screen around top side
   -- pull screen up so it fits same position, just upside-down:
   Lg.translate(0, -real_screen_height)
   Lg.translate(border, border)  -- add border
   draw_bricks()
   draw_board()
   draw_ball()
   Lg.pop()
end

function love.update(delta)
   local dt = delta * 500
   if Lm.isDown('l') then
      use_mouse(true)
   end
   if mouse_used() then
      board_x = Lm.getX()
   else
      move_board = 0
      if Lk.isDown('left') then
         move_board = move_board - 1
      end
      if Lk.isDown('right') then
         move_board = move_board + 1
      end
      board_x = board_x + dt * move_board
   end
   ball_x = ball_x + dt * ball_v_x
   ball_y = ball_y + dt * ball_v_y
end

function love.keypressed(k)
   if k == 'left' or k == 'right' then
      use_mouse(false)
   end
   if k == 'escape' or k == 'q' then
      love.event.push('quit')
   end
end

-- Converts HSL to RGB. (input and output range: 0 - 255)
function HSL(h, s, l, a)
    if s<=0 then return l,l,l,a end
    h, s, l = h/256*6, s/255, l/255
    local c = (1-math.abs(2*l-1))*s
    local x = (1-math.abs(h%2-1))*c
    local m,r,g,b = (l-.5*c), 0,0,0
    if h < 1     then r,g,b = c,x,0
    elseif h < 2 then r,g,b = x,c,0
    elseif h < 3 then r,g,b = 0,c,x
    elseif h < 4 then r,g,b = 0,x,c
    elseif h < 5 then r,g,b = x,0,c
    else              r,g,b = c,0,x
    end return (r+m)*255,(g+m)*255,(b+m)*255,a
end
