player = {}

player.x = x
player.y = y
player.speed = 200
player.life = 4

player.grid = anim8.newGrid(92, 144, 184, 720)
player.animations = {
  idle = anim8.newAnimation(player.grid('1-2', 1), 0.5),
  left = anim8.newAnimation(player.grid('1-2', 2), 0.2),
  right = anim8.newAnimation(player.grid('1-2', 3), 0.2),
  up = anim8.newAnimation(player.grid('1-2', 4), 0.2),
  down = anim8.newAnimation(player.grid('1-2', 5), 0.2)
}
player.animation = player.animations.idle

function playerDraw()
  player.animation:draw(sprites.playerSheet, player.x, player.y)
end

function playerUpdate(dt)
  player.animation = player.animations.idle
  if player.y > arena.y then
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
      player.y = player.y - player.speed * dt
      player.animation = player.animations.up
    end
  end
  if player.y < (arena.y)*2 then
    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
      player.y = player.y + player.speed * dt
      player.animation = player.animations.down
    end
  end
  if player.x > arena.x then
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
      player.x = player.x - player.speed * dt
      player.animation = player.animations.left
    end
  end
  if player.x < (arena.x)*2 then
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
      player.x = player.x + player.speed * dt
      player.animation = player.animations.right
    end
  end
  player.animation:update(dt)
end
