require 'object'
Board = Object:new{x=0,y=0,h=20,w=200}

function Board:draw()
   local r,g,b,a = love.graphics.getColor()
   love.graphics.setColor(HSL(0,256,128,a))
   love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
   love.graphics.setColor(r,g,b,a)
end

function Board:update(dt)
   if mouse_used() then
      self.x = love.mouse.getX()
   else
      local move_board = 0
      if love.keyboard.isDown('left') then
         move_board = move_board - 1
      end
      if love.keyboard.isDown('right') then
         move_board = move_board + 1
      end
      self.x = self.x + dt * move_board
   end
end

function Board:getWidth()
   return self.w
end
