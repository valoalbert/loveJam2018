function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end

function playerMouseAngle()
    return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

function galMouseAngle(enemy)
    return math.atan2(y - enemy.y, x - enemy.x)
end

music = love.audio.newSource('music/topcity.ogg')
music:setLooping(true)
music:play()

shoot = love.audio.newSource('music/shoot.wav', "static")

WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()
background = love.graphics.newImage('sprites/background.png')


font = love.graphics.newFont('fonts/ComputerSpeak.ttf', 24)
love.graphics.setFont(font)
