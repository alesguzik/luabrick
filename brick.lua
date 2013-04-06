require 'object'
Brick = Object:new{x=0,y=0,w=70,h=20,kind=0}

function Brick:from_cell(row,col,delta,kind)
   return Brick:new{kind=kind,
                       x = (col * (b.w+delta)),
                       y = row * (b.h+delta)}
end

function Board:initialize()
   self.body = love.physics.newBody(world,
                                    self.x,
                                    self.y,
                                    "static")
   self.shape = love.physics.newRectangleShape(self.x,self.y,self.w,self.h)
   self.fixture = love.physics.newFixture(self.body, self.shape, 1)
   self.body:setPosition(self.x,self.y)
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
