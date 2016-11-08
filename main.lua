--		This game was made by Mauritz Sverredal!!!
-- 	Isak Gyllenstrand made the "isaks", "traditional, "dragon" and "dragonfly ships...!
--		The "regular isak" ship is a recolor of the "isaks" ship, colored by Mauritz!

function love.load()
   require("player")
   require("projectiles")
   require("enemies")
   require("ui")
   love.window.setMode(0, 0, {resizable=true, vsync=true})
   fullscreen = false
   totalWidth = love.graphics.getWidth()
   totalHeight = love.graphics.getHeight()
   scaleY = 2
   scaleX = 2
   showTextBoxes = false
   t = 0
   textSize = 50
   ships = {"standard", "experimental", "isaks", "alpha", "plane", "regular isak", "pointy", "traditional", "dragon", "dragonfly"}
   colors = {
--    background:mixColor(0, 0, 0),
      textBoxes={64, 255, 64},
      shipMain={85, 255, 0},
      shipFront={85, 255, 0},
      shipSideThrusters={0, 255, 191},
--		gameOverText:mixColor(255, 0, 255),
      thrusterFire={255, 170, 0},
--		explosionInner:mixColor(255, 255, 0),
--		explosionMid:mixColor(255, 170, 0),
--		explosionOuter:mixColor(255, 85, 0),
      errorText={255, 0, 0},
      buttonColor={255, 102, 0}--,
--		Projectile:mixColor(255, 63, 63)
   }
   projectiles = {}
   loadPlayer()
   loadEnemies()
   loadProjectiles()
   love.window.setTitle("Space Shooter")
   love.graphics.setNewFont(36)
   love.graphics.setBackgroundColor(0, 0, 0)
end
function love.keypressed(key)
   if key == "d" then
      showTextBoxes = not showTextBoxes
   elseif key == "f" then
      if fullscreen == false then
         love.window.setFullscreen(true)
         fullscreen = true
      else
         love.window.setFullscreen(false)
         fullscreen = false
      end
   end
end
function love.mousepressed(x, y, button)
   if x > totalWidth - 480 then
      if y < 70 then
         if player.shipNum < #ships then
            player.shipNum = player.shipNum + 1
         else
            player.shipNum = 1
         end
      end
   end
end
function love.resize(w, h)
   totalWidth = w
   totalHeight = h
end
function love.update(dt)
   updateUI()
   updateProjectiles()
   updatePlayer(dt)
   updateEnemies()
   t = t + 1
--		sleep(0.01)
end
function love.draw()
   drawUI()
   drawProjectiles()
   drawEnemies()
   drawPlayer()
   testForEdges()
end