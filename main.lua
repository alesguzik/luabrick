require "util"
require "board"
require "ball"
require "brick"
require "wall"

function love.load()
   -- love.graphics.setMode(800,500)
   local width  = love.graphics.getWidth()
   local height = love.graphics.getHeight()
   
   love.physics.setMeter(64)
   world = love.physics.newWorld(0,0)

   board = Board:new{
       x = width/2,
       y = height-30
   }

   ball = Ball:new{
      x = board.body:getX() + 150,
      y = board.body:getY() - 150
   }
   walls = {
      Wall:new{x=width/2, y=0, w=width, h=1},     -- top
      Wall:new{x=width/2, y=height, w=width, h=1},-- bottom
      Wall:new{x=0, y=height/2, w=1, h=height},   -- left
      Wall:new{x=width, y=height/2, w=1, h=height}-- right
   }
   local brick_distance = 5
   bricks = {
      Brick:from_cell(1, 1, brick_distance, 0),
      Brick:from_cell(1, 2, brick_distance, 1),
      Brick:from_cell(1, 3, brick_distance, 2),
      Brick:from_cell(2, 0, brick_distance, 3),
      Brick:from_cell(2, 1, brick_distance, 4),
      Brick:from_cell(2, 2, brick_distance, 5),
      Brick:from_cell(3, 0, brick_distance, 6),
      Brick:from_cell(3, 1, brick_distance, 7),
      Brick:from_cell(3, 2, brick_distance, 8),
      Brick:from_cell(0, 1, brick_distance, 9),
      Brick:from_cell(0, 2, brick_distance, 10),
      Brick:from_cell(0, 3, brick_distance, 11),
      Brick:from_cell(1, 4, brick_distance, 0),
      Brick:from_cell(1, 6, brick_distance, 1),
      Brick:from_cell(1, 7, brick_distance, 2),
      Brick:from_cell(2, 5, brick_distance, 3),
      Brick:from_cell(2, 8, brick_distance, 4),
      Brick:from_cell(2, 9, brick_distance, 5),
      Brick:from_cell(3, 6, brick_distance, 6),
      Brick:from_cell(3, 4, brick_distance, 7),
      Brick:from_cell(3, 2, brick_distance, 8),
      Brick:from_cell(0, 5, brick_distance, 9),
      Brick:from_cell(0, 9, brick_distance, 10),
      Brick:from_cell(0, 8, brick_distance, 13)
   }
end

function use_mouse(x)
   love.mouse.setVisible(not x)
   love.mouse.setGrabbed(x)
end

function mouse_used()
   return love.mouse.isGrabbed()
end

function love.draw()
   for _,w in ipairs(walls) do
      w:draw()
   end
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
