require 'object'
Ball = Object:new{r=20,x=0,y=0}

function Ball:initialize()
   self.body = love.physics.newBody(world,
                                    self.x,
                                    self.y,
                                    "dynamic")
   self.shape = love.physics.newCircleShape(self.r)
   self.fixture = love.physics.newFixture(self.body, self.shape, 1)
   local force = 250000
   self.body:applyForce(-force,force)
   self.fixture:setRestitution(1)   -- let the ball bounce
end

function Ball:draw()
   local r,g,b,a = love.graphics.getColor()
   love.graphics.setColor(HSL(85,200,100,a))
   love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.r, 32)
   love.graphics.setColor(r,g,b,a)
end

function Ball:update(dt)
end
