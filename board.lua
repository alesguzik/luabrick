require 'object'
Board = Object:new{x=0,y=0,h=20,w=200}

function Board:draw()
   local r,g,b,a = love.graphics.getColor()
   love.graphics.setColor(HSL(0,256,128,a))
   love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
   love.graphics.setColor(r,g,b,a)
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

function Board:update(dt)
   if mouse_used() then
      self.x = love.mouse.getX()
   else
      if love.keyboard.isDown('left') then
         self.body:applyForce(-400,0)
      end
      if love.keyboard.isDown('right') then
         self.body:applyForce(400,0)
      end
   end
end
