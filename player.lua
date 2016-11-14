function loadPlayer()
  player = {
      angle=math.pi,
      x=(love.graphics.getWidth() / 2) * scaleX,
      y=(love.graphics.getHeight() / 2) * scaleY,
      yVelocity=0,
      xVelocity=0,
      decceleration=0.025,
      death="warp",
      shipNum=1,
      lastShot=0,
      fireRate=15,
      projectileSpeed=35,
      ship = "standard",
      lastShot=-15,
      thrust = 0
    }
  baseRocket = love.graphics.newMesh({{-20, -20, 0, 0, 85, 255, 0}, {20, -20, 0, 0, 85, 255, 0}, {20, 50, 0, 0, 85, 255, 0}, {-20, 50, 0, 0, 85, 255, 0}, {-40, -20, 0, 0, 0, 255, 191}, {-20, 20, 0, 0, 0, 255, 191}, {-20, -20, 0, 0, 0, 255, 191}, {40, -20, 0, 0, 0, 255, 191}, {20, 20, 0, 0, 0, 255, 191}, {20, -20, 0, 0, 0, 255, 191}}, "triangles", "static")
  baseRocket:setVertexMap(1, 2, 3, 1, 3, 4, 5, 6, 7, 8, 9, 10)
end
function updatePlayer(dt)
   player.ship = ships[player.shipNum]
   player.thrust = 0
   if keyLeft == true and keyRight == false then
      player.angle = player.angle - math.pi/48 
--			player.thrust = 2
   end
   if keyRight == true and keyLeft == false then
      player.angle = player.angle + math.pi/48 
--			player.thrust = 2
   end
   if keyUp == true then
      player.thrust = 10
   end	
   if player.angle < 0 - math.pi then
      player.angle = player.angle + 2 * math.pi
   end
   if player.angle >= math.pi then
      player.angle = player.angle - 2 * math.pi
   end
   player.xVelocity = (player.xVelocity * 15 - math.sin(player.angle) * player.thrust) / 15.3
   player.yVelocity = (player.yVelocity * 15 + math.cos(player.angle) * player.thrust) / 15.3

   if player.xVelocity < 0 then
      player.xVelocity = player.xVelocity + player.decceleration
      if player.xVelocity > 0 then
         player.xVelocity = 0
      end
   elseif player.xVelocity > 0 then
      player.xVelocity = player.xVelocity - player.decceleration
      if player.xVelocity < 0 then
         player.xVelocity = 0
      end
   end
   if player.yVelocity < 0 then
      player.yVelocity = player.yVelocity + player.decceleration
      if player.yVelocity > 0 then
         player.yVelocity = 0
      end
   elseif player.yVelocity > 0 then
      player.yVelocity = player.yVelocity - player.decceleration
      if player.yVelocity < 0 then
         player.yVelocity = 0
      end
   end

   player.y = player.y + player.yVelocity * 60 * dt
   player.x = player.x + player.xVelocity * 60 * dt
--		player.y = player.y + (math.cos(player.angle) * player.thrust)
--		player.x = player.x - (math.sin(player.angle) * player.thrust)

   if love.keyboard.isDown("space") and t - player.lastShot > player.fireRate then
      fireProjectile(player.x, player.y, player.angle, 20, player.projectileSpeed, true)
      player.lastShot = t
   end
end
function drawPlayer()
  	love.graphics.scale(1 / scaleX, 1 / scaleY)
		love.graphics.translate(player.x, player.y)
		love.graphics.rotate(player.angle)
		 
		if player.ship == "plane" then
			love.graphics.setColor(colors.thrusterFire)
			if keyUp == true then
				love.graphics.polygon("fill", -50, -9, -70, -9, -60, -60)
				love.graphics.polygon("fill", 50, -9, 70, -9, 60, -60)
			end
			if keyRight == true and keyLeft == false then
				love.graphics.polygon("fill", 50, -9, 70, -9, 60, -60)
			
			elseif keyLeft == true and keyRight == false then
				love.graphics.polygon("fill", -50, -9, -70, -9, -60, -60)
			end
		elseif player.ship == "alpha" or player.ship == "dragon" or player.ship == "dragonfly" then
		
		else
			love.graphics.setColor(colors.thrusterFire)
			if keyUp then
				love.graphics.polygon("fill", 0, -70, -12, -19, 12, -19)
			end
			if keyRight and not keyLeft then
				love.graphics.polygon("fill", 23, -19, 29, -50, 35, -19)
			elseif keyLeft and not keyRight then
				love.graphics.polygon("fill", -23, -19, -29, -50, -35, -19)
			end
		end
		
		if player.ship == "standard" then
      love.graphics.setColor(255, 255, 255)
      love.graphics.draw(baseRocket, 0, 0)
			love.graphics.setColor(colors.shipFront)
			love.graphics.circle("fill", 0, 50, 20, 50)
		elseif player.ship == "experimental" then
			love.graphics.setColor(colors.shipSideThrusters)
			love.graphics.rectangle("fill", -40, 30, 80, -50)
			love.graphics.circle("fill", -30, 25, 10)
			love.graphics.circle("fill", 30, 25, 10)
			love.graphics.setColor(colors.shipMain)
			love.graphics.rectangle("fill", -20, 50, 40, -70)
			love.graphics.setColor(colors.shipFront)
			love.graphics.circle("fill", 0, 50, 20)
		elseif player.ship == "isaks" then
			love.graphics.setColor(255, 0, 0)
			love.graphics.polygon("fill", 30, 30, 35, -20, 19, -20)
			love.graphics.polygon("fill", -30, 30, -35, -20, -19, -20)
			love.graphics.setColor(0, 0, 255)
			love.graphics.polygon("fill", -19, 20, -40, -20, -19, -20)
			love.graphics.polygon("fill", 19, 20, 40, -20, 19, -20)
			love.graphics.setColor(1000, 0, 0)
			love.graphics.rectangle("fill", -20, 50, 40, -70)
			love.graphics.setColor(0, 0, 255)
			love.graphics.polygon("fill", -20, 50, 20, 50, 0, 100)
		elseif player.ship == "alpha" then
			love.graphics.setColor(colors.thrusterFire)
			love.graphics.polygon("fill", 0, 70, -20, 0, 20, 0)	
		elseif player.ship == "plane" then
			love.graphics.setColor(colors.shipSideThrusters)
			love.graphics.polygon("fill", -19, 30, -90, -10, -19, -10)
			love.graphics.polygon("fill", 19, 30, 90, -10, 19, -10)
			love.graphics.polygon("fill", -19, -45, -45, -70, -19, -70)
			love.graphics.polygon("fill", 19, -45, 45, -70, 19, -70)
			love.graphics.setColor(colors.shipMain)
			love.graphics.rectangle("fill", -20, 50, 40, -120)
			love.graphics.setColor(colors.shipFront)
			love.graphics.circle("fill", 0, 50, 20)		
		elseif player.ship == "regular isak" then
			love.graphics.setColor(colors.shipSideThrusters)
			love.graphics.polygon("fill", 30, 30, 35, -20, 19, -20)
			love.graphics.polygon("fill", -30, 30, -35, -20, -19, -20)
      love.graphics.setColor(255, 255, 255)
      love.graphics.draw(baseRocket, 0, 0)
			love.graphics.setColor(colors.shipFront)
			love.graphics.polygon("fill", -20, 49, 20, 49, 0, 100)
		elseif player.ship == "pointy" then
			love.graphics.setColor(255, 255, 255)
      love.graphics.draw(baseRocket, 0, 0)
			love.graphics.setColor(colors.shipFront)
			love.graphics.polygon("fill", -20, 50, 20, 50, 0, 100)		
		elseif player.ship == "traditional" then
			love.graphics.setColor(255, 0, 0)
			love.graphics.polygon("fill", -19, 20, -40, -20, -19, -20)
			love.graphics.polygon("fill", 19, 20, 40, -20, 19, -20)
			love.graphics.setColor(191, 191, 191)
			love.graphics.rectangle("fill", -20, 50, 40, -70)
			love.graphics.setColor(255, 0, 0)
			love.graphics.polygon("fill", -20, 50, 20, 50, 0, 100)
			love.graphics.circle("fill", 0, 30, 10)
			love.graphics.setColor(0, 0, 0)
			love.graphics.circle("fill", 0, 30, 6)
			love.graphics.setColor(255, 0, 0)
			love.graphics.circle("fill", 0, 0, 10)
			love.graphics.setColor(0, 0, 0)
  		love.graphics.circle("fill", 0, 0, 6)
		elseif player.ship == "dragon" then
			love.graphics.setColor(0, 101, 0)
			--love.graphics.polygon("fill", -19, 20, -30, -20, -19, -20)
			love.graphics.polygon("fill", -19, 20, -30, -20, -15, -50)	--fot
			love.graphics.setColor(0, 150, 0)
			love.graphics.polygon("fill", -10, 20, -60, 70, -100, -20)	--vingar
			love.graphics.setColor(0, 101, 0)
			love.graphics.polygon("fill", -10, 20, -60, 70, -65, 60)	--vingar
			love.graphics.polygon("fill", -59, 69, -99, -20, -80, 50)	--vingar
			--love.graphics.polygon("fill", 19, 20, 30, -20, 19, -20)
			love.graphics.polygon("fill", 19, 20, 30, -20, 15, -50)		--fot
			love.graphics.setColor(0, 150, 0)
			love.graphics.polygon("fill", 10, 20, 60, 70, 100, -20)		--vingar
			love.graphics.setColor(0, 101, 0)
			love.graphics.polygon("fill", 10, 20, 60, 70, 65, 60)		--vingar
			love.graphics.polygon("fill", 59, 69, 99, -20, 80, 50)		--vingar
			love.graphics.rectangle("fill", -20, 51, 40, -71)			--bas
			love.graphics.polygon("fill", -20, 50, 20, 50, 0, 100)		--huvud mitten
			love.graphics.polygon("fill", -30, 50, 20, 50, 15, 80)		--huvud sida
			love.graphics.polygon("fill", -20, 50, 30, 50, -15, 80)		--huvud sida
			love.graphics.setColor(0, 150, 0)
			love.graphics.polygon("fill", 0, -100, -12, -19, 12, -19)	--svans
			love.graphics.setColor(255, 0, 0)
			love.graphics.circle("fill", 9, 70, 3)						--ögon
			love.graphics.setColor(0, 101, 0)
			love.graphics.circle("fill", 7, 68, 3)						--ögon
			love.graphics.setColor(255, 0, 0)
			love.graphics.circle("fill", -9, 70, 3)						--ögon
			love.graphics.setColor(0, 101, 0)
			love.graphics.circle("fill", -7, 68, 3)						--ögon
		elseif player.ship == "dragonfly" then
 		   --vinge höger upp
 		   love.graphics.setColor(colors.shipSideThrusters)
 		   love.graphics.polygon("fill", -20, 0, 100, 25, 100, 10) --vinge
		    love.graphics.circle("fill", 100, 18, 7) --vingände
		    --vinge vänster upp
		    love.graphics.polygon("fill", 20, 0, -100, 25, -100, 10) --vinge
		    love.graphics.circle("fill", -100, 18, 7) --vingände
		    --vinge höger ner
		    love.graphics.polygon("fill", -20, -0, 100, -25, 100, -10) --vinge
		    love.graphics.circle("fill", 100, -18, 7) --vingände
		    --vinge vänster ner
		    love.graphics.polygon("fill", 20, -0, -100, -25, -100, -10) --vinge
		    love.graphics.circle("fill", -100, -18, 7) --vingände
 		   --kropp
 		   love.graphics.setColor(colors.shipFront)
 		   love.graphics.circle("fill", 0, 0, 20) --kropp mitt
 		   love.graphics.circle("fill", 0, 5, 20) --kropp mitt2
 		   love.graphics.circle("fill", 0, -100, 7) --kropp bak
 		   love.graphics.rectangle("fill", 7, 0, -14, -100) --kropp bak ände
  		  --vänster öga
  		  love.graphics.setColor(255, 255, 255)
 		   love.graphics.circle("fill", 10, 15, 11) --kontur
 		   love.graphics.setColor(0, 0, 0)
 		   love.graphics.circle("fill", 10, 15, 10) --bakgrund
 		   love.graphics.setColor(255, 255, 255)
		    love.graphics.circle("fill", 14, 18, 4) --vit stor
 		   love.graphics.circle("fill", 10, 10, 2) --vit mellan
		    love.graphics.circle("fill", 5, 16, 3) --vit liten
		    --höger öga
 		   love.graphics.circle("fill", -10, 15, 11) --kontur
 		   love.graphics.setColor(0, 0, 0)
 		   love.graphics.circle("fill", -10, 15, 10) --bakgrund
 		   love.graphics.setColor(255, 255, 255)
 		   love.graphics.circle("fill", -6, 18, 4) --vit stor
 		   love.graphics.circle("fill", -10, 10, 2) --vit mellan
 		   love.graphics.circle("fill", -15, 16, 3) --vit liten
		else 
			love.graphics.setColor(colors.errorText)
			love.graphics.print("error: invalid ship",0, 0)
		end
		love.graphics.origin()
end
function testForEdges()
		if (player.death == true) then
			if player.x < 0 or player.x > scaleX * totalWidth or player.y < 0 or player.y > scaleY * totalHeight then
				gameOver()
			end
      else if player.death == "warp" then
			if player.x < 0 then	
				player.x = player.x + scaleX * totalWidth
			end
			if player.x > scaleX * totalWidth then
				player.x = player.x - scaleX * totalWidth
			end
			if player.y < 0 then
				player.y = player.y + scaleY * totalHeight
			end
			if player.y > scaleY * totalHeight then
				player.y = player.y - scaleY * totalHeight
			end
		end
	end
end