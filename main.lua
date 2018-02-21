function love.load()
  require('libs')

  paused = not paused

  sprites = {}
  sprites.playerSheet = love.graphics.newImage('sprites/player_sheet.png')
  sprites.galSheet    = love.graphics.newImage('sprites/gal_sheet.png')
  sprites.friendSheet = love.graphics.newImage('sprites/friend_sheet.png')
  sprites.staticheart = love.graphics.newImage('sprites/heart.png')
  sprites.heartSheet  = love.graphics.newImage('sprites/heart_sheet.png')

  y = HEIGHT/2
  x = WIDTH/2

  anim8 = require('anim8/anim8')
  require('Player')
  require('Gal')
  require('Friend')
  require('Arena')
  require('Score')
  require('Heart')
  require('Life')

  arena = Arena.new(WIDTH/3, HEIGHT/3, 360, 270)
  bullets = {}
  gals = {}
  friends = {}
  maxtime = 2
  timerGal = maxtime
  timerFriend = 5
  level = 1

  levelCounter = 0
  lifeCounter = 4
  player.life = 4
  pointsCounter = 0

  -- 1. Start, 2. Gameplay, 3. GameOver, 4. Pause
  gameState = 1
end

function love.draw()
  love.graphics.draw(background, 0, 0)

  if gameState == 1 then
    love.graphics.printf("Click anywhere to start", 0, 550, love.graphics.getWidth(), "center")
  end

  if gameState == 4 then love.graphics.printf("Pause", 0, 50, love.graphics.getWidth(), "center") end
  if gameState == 3 then love.graphics.printf("Game Over\nRestart Y/N", 0, 50, love.graphics.getWidth(), "center") end

  heartDraw()
  playerDraw()
  galDraw()
  friendDraw()
  scoreDraw()
  love.graphics.print("Hearts stolen from you: "..lifeCounter, 590, 20)
  love.graphics.print("Level "..level, 200, 20)

  for i,b in ipairs(bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 10, 10)
  end
end

function love.update(dt)
  -- show FPS
  love.window.setTitle("Love Jam 2018! (FPS:" .. love.timer.getFPS() .. ")")

  if not paused and gameState == 2 then

    galUpdate(dt)
    heartUpdate(dt)
    playerUpdate(dt)
    friendUpdate(dt)

    for i,b in ipairs(bullets) do
      b.x = b.x + math.cos(b.direction) * b.speed * dt
      b.y = b.y + math.sin(b.direction) * b.speed * dt
    end

    -- si el jugador muere
    if player.life == 0 then
      gameState = 3
    end

    -- limpieza tabla bullets
    for i = #bullets,1, -1 do
      local b = bullets[i]
      if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() or b.dead == true then
        table.remove(bullets, i)
      end
    end

    -- limpieza tabla gals
    for i = #gals,1, -1 do
      local g = gals[i]
      if g.dead == true then
        table.remove(gals, i)
      end
    end

    for i = #friends,1, -1 do
      local f = friends[i]
      if f.dead == true then
        table.remove(friends, i)
      end
    end
    -- colision entre balas y gals
    for i,g in ipairs(gals) do
      for j,b in ipairs(bullets) do
        if distanceBetween(g.x +50 , g.y + 50, b.x, b.y) < 40 then
          g.dead = true
          b.dead = true
          scoreUpdate()
          levelCounter = levelCounter + 100
        end
      end
    end

    -- colision entre balas y gals
    for i,f in ipairs(friends) do
      for j,b in ipairs(bullets) do
        if distanceBetween(f.x +50 , f.y + 50, b.x, b.y) < 40 then
          f.dead = true
          b.dead = true
          if pointsCounter > 100 then
            pointsCounter = pointsCounter -200
          elseif pointsCounter <= 100 then
            pointsCounter = 0
          end
        end
      end
    end


    -- spawnGal
    timerGal = timerGal - dt
    if timerGal <= 0 then
        spawnGal()
        timerGal = maxtime
    end

    timerFriend = timerFriend - dt
    if timerFriend <= 0 then
      spawnFriend()
      timerFriend = 5
    end

    if levelCounter == 1000 and level < 20 then
      maxtime = maxtime - 0.1
      level = level + 1
      levelCounter = 0
    end
  end
  print(levelCounter.."\n"..maxtime.."\n"..level)
end

function love.focus(f)
  if not f then
    paused = true
  end
end

function spawnBullet()
  bullet = {}
  bullet.x = player.x + 50
  bullet.y = player.y + 50
  bullet.direction = playerMouseAngle()
  bullet.dead = false
  bullet.speed = 600

  table.insert(bullets, bullet)

  shoot:play()
end

function love.keypressed(key, scancode, isrepeat)
  -- body...
  if key == "escape" then
    if not paused and gameState == 2 then
      paused = true
      gameState = 4
      music:pause()
    elseif paused and gameState == 4 then
      paused = not paused
      gameState = 2
      music:resume()
    end
  elseif key == "y" and gameState == 3 then
      player.life = 4
      lifeCounter = 4
      pointsCounter = 0
      player.x = x
      player.y = y

      love.load()
  elseif key == "n" and gameState == 3 then
    love.event.quit()
  end
end

function love.mousepressed(x, y, button, isTouch)
  -- body...
  if button == 1 and not paused and gameState == 2 then
    spawnBullet()
  elseif button == 1 and gameState == 1 then
    gameState = 2
    paused = not paused
  end
end
