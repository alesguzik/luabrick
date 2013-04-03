Object = {}
function Object:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Object:inspect()
   for k in pairs(self) do print(k .. "=" .. self[k]) end
end
