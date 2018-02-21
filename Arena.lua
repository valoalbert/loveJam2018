Arena = {}

Arena.new = function(x, y, width, height)
  local self = self or {}
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end
