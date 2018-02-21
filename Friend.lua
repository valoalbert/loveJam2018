function spawnFriend()
  friend = {}
  friend.x = math.random(0, love.graphics.getWidth())
  friend.y = math.random(0, love.graphics.getHeight())
  friend.speed = 200
  friend.dead = false

  friend.grid = anim8.newGrid(92, 144, 184, 144)
  friend.animations = {
    down = anim8.newAnimation(friend.grid('1-2', 1), 0.5)
  }

  friend.animation = friend.animations.down

  local side = math.random(1, 4)
  if side == 1 then
      friend.x = -30
      friend.y = math.random(0, love.graphics.getHeight())
  elseif side == 2 then
      friend.x = math.random(0, love.graphics.getWidth())
      friend.y = -30
  elseif side == 3 then
      friend.x = love.graphics.getWidth() + 30
      friend.y = math.random(0, love.graphics.getHeight())
  else
      friend.x = math.random(0, love.graphics.getWidth())
      friend.y = love.graphics.getHeight() + 30
  end

  table.insert(friends, friend)
end

function friendDraw()
  for i,f in ipairs(friends) do
    f.animation:draw(sprites.friendSheet, f.x, f.y)
  end
end

function friendUpdate(dt)
  for i,f in ipairs(friends) do
    f.x = f.x + math.cos(galMouseAngle(f)) * f.speed * dt
    f.y = f.y + math.sin(galMouseAngle(f)) * f.speed * dt

    -- Eliminar enemigo si llega al centro
    if distanceBetween(f.x, f.y, x, y) < 5 then
      f.dead = true
      pointsCounter = pointsCounter + 50
    end
    f.animation:update(dt)
  end
end
