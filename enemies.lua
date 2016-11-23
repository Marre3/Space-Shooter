function loadEnemies()
   enemies = {}
   lastEnemySpawned = 0
   enemiesKilled = 0
   difficulty = 0.1
end
function updateEnemies()
   for i,e in ipairs(enemies) do
      e.lifetime = e.lifetime + 1
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
               if e.type == "shooter" then
                  difficulty = difficulty + 0.2
               else
                  difficulty = difficulty + 0.1
               end
               table.remove(enemies, i)
               table.remove(projectiles, l)
               enemiesKilled = enemiesKilled + 1
               if enemiesKilled > highScore then
                  highScore = enemiesKilled
               end
            end
         end
      end
      if e.lifetime % 100 == 0 and e.type == "shooter" then
         fireProjectile(e.x, e.y, math.atan2(e.x - player.x, player.y - e.y), 20, 10, false)
      end
   end
   if #enemies < difficulty then
      if enemiesKilled % 5 == 3 then
         spawnEnemy(50, 2, "shooter")
      else
         spawnEnemy(50, 2, "standard")
      end
      lastEnemySpawned = t
   end
end
function spawnEnemy(size, speed, type)
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
   enemy.lifetime = 0
   enemy.angle = math.random(0, 360 * math.pi)/180
   enemy.size = size
   enemy.speed = speed
   enemy.type = type
   table.insert(enemies, enemy)
end
function drawEnemies()
   love.graphics.scale(1/scaleX, 1/scaleY)
   for _,e in pairs(enemies) do
      if e.type == "standard" then
         love.graphics.setColor(255, 0, 0)
         love.graphics.circle("fill", e.x, e.y, e.size, 6)
      else
         love.graphics.setColor(0, 0, 255)
         love.graphics.circle("fill", e.x, e.y, e.size, 6)
      end
   end
   love.graphics.origin()
end