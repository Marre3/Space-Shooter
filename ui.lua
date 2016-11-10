function drawButtons()
		love.graphics.scale(1 / scaleX, 1 / scaleY)
		love.graphics.setColor(colors.buttonColor)
		love.graphics.rectangle("fill", (totalWidth - 480) * scaleX, 0, 480 * scaleX, 70 * scaleY)
		love.graphics.setNewFont(50 * scaleX)
		love.graphics.setColor(colors.textBoxes)
		love.graphics.print("Change Ship", (totalWidth - 450) * scaleX, 100 * scaleY - 100 * scaleY)
		love.graphics.origin()
		love.graphics.setNewFont(36)
	end		
function drawTextBoxes()
	textBoxes = {
		"thrust:" .. player.thrust, 
		"angle:" .. (math.floor(100 * (player.angle + math.pi) * 57.2957795131) / 100) .. "°", 
		"x:" .. player.x,
		"y:" .. player.y,
		"left = " .. tostring(keyLeft),
		"right = " .. tostring(keyRight),
		"up = " .. tostring(keyUp),
		"space = " .. tostring(keySpace),
		"x velocity:" .. player.xVelocity,
		"y velocity:" .. player.yVelocity,
		"x scale:" .. scaleX,
		"y scale:" .. scaleY,
		"death:" .. player.death,
		"ship:" .. player.ship,
		"ship id:" .. player.shipNum,
		"projectiles:" .. #projectiles,
      "enemies:" .. #enemies,
--		 changeShipCurrentFrame,
--		 lastChangeShip,
		 t,  
	}
	if showTextBoxes == true then
      love.graphics.scale(2 / scaleX, 2 / scaleY)
		love.graphics.setColor(colors.textBoxes)
		for i = 1, #textBoxes do
			love.graphics.print(textBoxes[i], 0, textSize * (i - 1) * 0.75)
		end
      love.graphics.origin()
	end
   love.graphics.setColor(255, 170, 0)
   love.graphics.print("Score:" .. enemiesKilled, 0, totalHeight - 50)
end
function updateUI()
   keyUp = love.keyboard.isDown("up")
   keyLeft = love.keyboard.isDown("left")
	keySpace = love.keyboard.isDown("space")
	keyRight = love.keyboard.isDown("right")
end
function drawUI()
   drawTextBoxes()
   drawButtons()
end
function gameOver()
   function love.update()

   end
   function love.draw()
      drawUI()
      drawProjectiles()
      drawEnemies()
      drawPlayer()
      testForEdges()
      love.graphics.setColor(255, 0, 255)
      love.graphics.print("Game Over!", totalWidth / 2 - 100, totalHeight / 2 - 100)
   end
end