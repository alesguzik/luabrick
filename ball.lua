require 'object'
Ball = Object:new{r=20,x=0,y=0,speed_x=1,speed_y=1}

function Ball:draw()
   local r,g,b,a = love.graphics.getColor()
   love.graphics.setColor(HSL(85,200,100,a))
   love.graphics.circle("fill", self.x, self.y, self.r, 32)
   love.graphics.setColor(r,g,b,a)
end

function Ball:update(dt)
   self.x = self.x + dt * self.speed_x
   self.y = self.y + dt * self.speed_y
end
