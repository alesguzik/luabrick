require 'object'
Wall = Object:new{x=0,y=0,h=1,w=1}

function Wall:draw()
   local r,g,b,a = love.graphics.getColor()
   love.graphics.setColor(HSL(0,0,255,a))
   love.graphics.polygon(
      'fill',
      self.body:getWorldPoints(self.shape:getPoints())
   )
   love.graphics.setColor(r,g,b,a)
end

function Wall:initialize()
   self.body = love.physics.newBody(world,
                                    self.x,
                                    self.y,
                                    "static")
   self.shape = love.physics.newRectangleShape(self.w,self.h)
   self.fixture = love.physics.newFixture(self.body,
                                          self.shape,
                                          1)
end

function Wall:update(dt)
end
