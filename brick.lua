require 'object'
Brick = Object:new{x=0,y=0,w=70,h=20,kind=0}

function Brick:from_cell(row,col,delta,kind)
   local b = Brick:new{kind=kind}
   b.x = col * (b.w+delta)
   b.y = row * (b.h+delta)
   return b
end

function Brick:draw()
   local brick_colors = 8
   local brick_color = (self.kind % brick_colors)
   local r,g,b,a = love.graphics.getColor()
   love.graphics.push()
   love.graphics.translate(self.x, self.y)
   love.graphics.setColor(
      HSL(
         brick_color * 256 / brick_colors,
         256,
         100,
         a))
   love.graphics.rectangle('fill', 0, 0, self.w, self.h)
   love.graphics.pop()
   love.graphics.setColor(r,g,b,a)
end
