require 'object'
Brick = Object:new{x=0,y=0,w=70,h=20,kind=0}

function Brick:from_cell(row,col,delta,kind)
   return Brick:new{kind = kind,
                    x = delta + Brick.w/2 + col * (Brick.w+delta),
                    y = delta + Brick.h/2 + row * (Brick.h+delta)}
end

function Brick:initialize()
   self.body = love.physics.newBody(world,
                                    self.x,
                                    self.y,
                                    "kinematic")
   self.shape = love.physics.newRectangleShape(self.w,
                                               self.h)
   self.fixture = love.physics.newFixture(self.body,
                                          self.shape,
                                          1)
   self.body:setPosition(self.x,self.y)
end

function Brick:draw()
   local brick_colors = 8
   local brick_color = (self.kind % brick_colors)
   local r,g,b,a = love.graphics.getColor()
   love.graphics.setColor(
      HSL(
         brick_color * 256 / brick_colors,
         256,
         100,
         a))
   love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
   love.graphics.setColor(r,g,b,a)
end
