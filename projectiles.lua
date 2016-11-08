function loadProjectiles()
   projectiles = {}
end
function fireProjectile(x, y, angle, size, speed, isFriendly)
   local projectile = {}
   projectile.x = x - math.sin(player.angle) * 55
   projectile.y = y + math.cos(player.angle) * 55
   projectile.angle = angle
   projectile.size = size
   projectile.speed = speed
   projectile.isFriendly = isFriendly
   table.insert(projectiles, projectile)
end
function updateProjectiles()
   for i,p in ipairs(projectiles) do
      p.x = p.x - math.sin(p.angle) * p.speed
      p.y = p.y + math.cos(p.angle) * p.speed
      if p.y > totalHeight * scaleY + p.size or p.y < 0 - p.size or p.x < 0 - p.size or p.x > totalWidth * scaleX + p.size then
         table.remove(projectiles, i)
      end


   end
end
function drawProjectiles()
   for _,p in pairs(projectiles) do
      if p.isFriendly then
         love.graphics.setColor(255, 63, 63)
      else
         love.graphics.setColor(255, 31, 255)
      end
      love.graphics.scale(1/scaleX, 1/scaleY)
      love.graphics.translate(p.x, p.y)
      love.graphics.rotate(p.angle + math.pi / 2)
      love.graphics.circle("fill", 0, 0, p.size, 5)
      love.graphics.origin()
   end
end