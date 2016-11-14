function loadEnemies()
   enemies = {}
   lastEnemySpawned = 0
   enemiesKilled = 0
end
function updateEnemies()
   for i,e in ipairs(enemies) do
      e.x = e.x - math.sin(e.angle) * e.speed
      e.y = e.y + math.cos(e.angle) * e.speed
      if math.sqrt((player.x - e.x) ^ 2 + (player.y - e.y) ^ 2) < 25 + e.size then
         gameOver()
      end
      if e.y > totalHeight * scaleY + e.size or e.y < 0 - e.size or e.x < 0 - e.size or e.x > totalWidth * scaleX + e.size then
         table.remove(enemies, i)
      end
      for l,p in pairs(projectiles) do
         if projectiles[l].isFriendly == true then
            if math.sqrt((p.x - e.x) ^ 2 + (p.y - e.y) ^ 2) < p.size + e.size - 5 then
               table.remove(enemies, i)
               table.remove(projectiles, l)
               enemiesKilled = enemiesKilled + 1
               if enemiesKilled > highScore then
                  highScore = enemiesKilled
               end
            end
         end
      end
   end
   if #enemies < 0.1 + enemiesKilled / 10 then
      lastEnemySpawned = t
      spawnEnemy(50, 2)
   end
end
function spawnEnemy(size, speed)
   local enemy = {}
   local spawned = false
   while spawned == false do
      spawnX = math.random(0, totalWidth * scaleX)
      spawnY = math.random(0, totalHeight * scaleY)
      if math.sqrt((spawnX - player.x) ^ 2 + (spawnY - player.y) ^ 2) > 100 * (scaleX + scaleY) then
         enemy.x = spawnX
         enemy.y = spawnY
         break
      end
   end
   enemy.angle = math.random(0, 200 * math.pi)/100
   enemy.size = size
   enemy.speed = speed

   table.insert(enemies, enemy)
end
function drawEnemies()
   love.graphics.scale(1/scaleX, 1/scaleY)
   love.graphics.setColor(255, 0, 0)
   for _,e in pairs(enemies) do
      love.graphics.circle("fill", e.x, e.y, e.size, 10)
   end
   love.graphics.origin()
end