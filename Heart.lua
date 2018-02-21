heart = {}

heart.grid = anim8.newGrid(48, 48, 96, 48)
heart.animation = anim8.newAnimation(heart.grid('1-2', 1), 0.2)

function heartDraw()
  heart.animation:draw(sprites.heartSheet, x-24, y-24)
end

function heartUpdate(dt)
  heart.animation:update(dt)
end
