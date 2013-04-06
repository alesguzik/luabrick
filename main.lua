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

   love.physics.setMeter(64)
   world = love.physics.newWorld(0,0)

   board = Board:new{
       x = screen_width/2-Board.w,
       y = 230
   }

   ball = Ball:new{
      x = board.body:getX() + 2*board.w,
      y = board.y
   }
   local brick_distance = 8
   bricks = {
      Brick:from_cell(6, 1, brick_distance, 0),
      Brick:from_cell(6, 2, brick_distance, 1),
      Brick:from_cell(6, 3, brick_distance, 2),
      Brick:from_cell(5, 0, brick_distance, 3),
      Brick:from_cell(5, 1, brick_distance, 4),
      Brick:from_cell(5, 2, brick_distance, 5),
      Brick:from_cell(4, 0, brick_distance, 6),
      Brick:from_cell(4, 1, brick_distance, 7),
      Brick:from_cell(4, 2, brick_distance, 8),
      Brick:from_cell(3, 1, brick_distance, 9),
      Brick:from_cell(3, 2, brick_distance, 10),
      Brick:from_cell(3, 3, brick_distance, 11)
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
   for _,b in ipairs(bricks) do
      b:draw()
   end
   board:draw()
   ball:draw()
end

function love.update(dt)
   world:update(dt)
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
