pointsCounter = 0

function scoreDraw()
  love.graphics.print(pointsCounter, 100, 20)
end

function scoreUpdate()
  pointsCounter = pointsCounter + 100
  levelCounter = levelCounter + 100
end
