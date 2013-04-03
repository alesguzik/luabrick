require "util"
require "board"
require "ball"
require "brick"

function love.load()
   love.graphics.setMode(800,500)
   border = 10

   real_screen_height = love.graphics.getHeight()
   real_screen_width = love.graphics.getWidth()

   screen_height = real_screen_height - 2 * border
   screen_width  = real_screen_width  - 2 * border

   board = Board:new{
       x = (screen_width-Board.w)/2,
       y = 0
   }

   ball = Ball:new{
      x = board.x + board.w/2,
      y = board.h + 20
   }
   local brick_distance = 8
   bricks = {
      Brick:from_cell(16, 1, brick_distance, 0),
      Brick:from_cell(16, 2, brick_distance, 1),
      Brick:from_cell(16, 3, brick_distance, 2),
      Brick:from_cell(15, 0, brick_distance, 3),
      Brick:from_cell(15, 1, brick_distance, 4),
      Brick:from_cell(15, 2, brick_distance, 5),
      Brick:from_cell(14, 0, brick_distance, 6),
      Brick:from_cell(14, 1, brick_distance, 7),
      Brick:from_cell(14, 2, brick_distance, 8),
      Brick:from_cell(13, 1, brick_distance, 9),
      Brick:from_cell(13, 2, brick_distance, 10),
      Brick:from_cell(13, 3, brick_distance, 11)
   }
end

function use_mouse(x)
   love.mouse.setVisible(not x)
   love.mouse.setGrab(x)
end

function mouse_used()
   return love.mouse.isGrabbed()
end

function love.draw()
   love.graphics.push()
   love.graphics.scale(1, -1) -- flip screen around top side
   -- pull screen up so it fits same position, just upside-down:
   love.graphics.translate(0, -real_screen_height)
   love.graphics.translate(border, border)  -- add border
   for _,b in ipairs(bricks) do
      b:draw()
   end
   board:draw()
   ball:draw()
   love.graphics.pop()
end

function love.update(delta)
   local dt = delta * 500
   board:update(dt)
   ball:update(dt)
end

function love.mousepressed(k)
   use_mouse(true)
end
function love.keypressed(k)
   if k == 'left' or k == 'right' then
      use_mouse(false)
   end
   if k == 'escape' or k == 'q' then
      love.event.push('quit')
   end
end
