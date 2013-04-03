love.graphics.setMode(800,500)

border = 10

real_screen_height = love.graphics.getHeight()
real_screen_width = love.graphics.getWidth()

screen_height = real_screen_height - 2 * border
screen_width  = real_screen_width  - 2 * border

board_w = 200
board_h = 20
board_x = (screen_width-board_w)/2
board_y = 0

ball_radius = 20
ball_x = board_x + board_w/2
ball_y = board_h + ball_radius

function use_mouse(x)
   love.mouse.setVisible(not x)
   love.mouse.setGrab(x)
end

function mouse_used()
   return love.mouse.isGrabbed()
end

function draw_bricks()
   draw_brick(15,0)
   draw_brick(15,1)
   draw_brick(15,2)
   draw_brick(16,3)
   draw_brick(16,1)
   draw_brick(16,2)
end

function draw_ball()
   love.graphics.circle("fill", ball_x, ball_y, ball_radius, 32)
end

function draw_brick(row,col)
   x = col
   y = row
   w = 70
   h = 20
   delta = 8
   love.graphics.rectangle('fill', x*(w+delta), y*(h+delta), w, h)
end

function draw_board()
   love.graphics.rectangle('fill', board_x, board_y, board_w, board_h)
end

function love.draw()
   love.graphics.push()
   love.graphics.scale(1, -1) -- flip screen around top side
   -- pull screen up so it fits same position, just upside-down:
   love.graphics.translate(0, -real_screen_height)
   love.graphics.translate(border, border)  -- add border
   draw_bricks()
   draw_board()
   draw_ball()
   love.graphics.pop()
end

function love.update(dt)
   if love.mouse.isDown('l') then
      use_mouse(true)
   end
   if mouse_used() then
      board_x = love.mouse.getX()
   else
      move_board = 0
      if love.keyboard.isDown('left') then
         move_board = move_board - 1
      end
      if love.keyboard.isDown('right') then
         move_board = move_board + 1
      end
      board_x = board_x + dt * 500 * move_board
   end
end

function love.keypressed(k)
   if k == 'left' or k == 'right' then
      use_mouse(false)
   end
   if k == 'escape' or k == 'q' then
      love.event.push('quit')
   end
end
