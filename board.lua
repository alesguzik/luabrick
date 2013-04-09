require 'object'
Board = Object:new{x=0,y=0,h=20,w=200}

function Board:draw()
   local r,g,b,a = love.graphics.getColor()
   love.graphics.setColor(HSL(0,255,128,a))
   love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
   love.graphics.setColor(r,g,b,a)
end

function Board:initialize()
   self.body = love.physics.newBody(world,
                                    self.x,
                                    self.y,
                                    "kinematic")
   self.shape = love.physics.newRectangleShape(self.w,self.h)
   self.fixture = love.physics.newFixture(self.body, self.shape, 1)
   self.fixture:setRestitution(1)
end

function Board:update(dt)
   if mouse_used() then
      self.body:setX(love.mouse.getX()-self.w)
   else
      local x = self.body:getX();
      if love.keyboard.isDown('left') then
         self.body:setX(x-dt*500)
      end
      if love.keyboard.isDown('right') then
         self.body:setX(x+dt*500)
      end
   end
end
