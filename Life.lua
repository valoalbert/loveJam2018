--[[
lifes = {}


life = {}
life.x = 794
for i=1,4 do
  life.image = sprites.staticheart
  life.y = 10
  life.x = life.x + 48

  table.insert(lifes, life)
  print("vuelta"..i.." :" .." "..life.x)
end

function lifeDraw()
  for i=1,4 do
    print("print "..i)
    love.graphics.draw(lifes[i].image, lifes[i].x, lifes[i].y)
  end
end
]]
