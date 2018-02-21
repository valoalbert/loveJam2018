function spawnGal()
  gal = {}
  gal.x = math.random(0, love.graphics.getWidth())
  gal.y = math.random(0, love.graphics.getHeight())
  gal.speed = 200
  gal.dead = false

  gal.grid = anim8.newGrid(92, 144, 184, 720)
  gal.animations = {
    down = anim8.newAnimation(gal.grid('1-2', 1), 0.5),
    up = anim8.newAnimation(gal.grid('1-2', 2), 0.2),
    left = anim8.newAnimation(gal.grid('1-2', 3), 0.2),
    right = anim8.newAnimation(gal.grid('1-2', 4), 0.2),
  }

  gal.animation = gal.animations.down

  local side = math.random(1, 4)
  if side == 1 then
      gal.x = -30
      gal.y = math.random(0, love.graphics.getHeight())
  elseif side == 2 then
      gal.x = math.random(0, love.graphics.getWidth())
      gal.y = -30
  elseif side == 3 then
      gal.x = love.graphics.getWidth() + 30
      gal.y = math.random(0, love.graphics.getHeight())
  else
      gal.x = math.random(0, love.graphics.getWidth())
      gal.y = love.graphics.getHeight() + 30
  end

  table.insert(gals, gal)
end

function galDraw()
  for i,g in ipairs(gals) do
    g.animation:draw(sprites.galSheet, g.x, g.y)
  end
end

function galUpdate(dt)
  for i,g in ipairs(gals) do
    g.x = g.x + math.cos(galMouseAngle(g)) * g.speed * dt
    g.y = g.y + math.sin(galMouseAngle(g)) * g.speed * dt

    -- Eliminar enemigo si llega al centro
    if distanceBetween(g.x, g.y, x, y) < 5 then
      g.dead = true
      player.life = player.life - 1
      lifeCounter = lifeCounter - 1
    end
    g.animation:update(dt)
  end
end
