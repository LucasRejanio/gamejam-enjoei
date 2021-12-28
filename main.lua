require "opening"
CharSellection = require("character-sellection")

Game = {
    width = 352,
    height = 256,
    scale = 3.5,
    scene = ""
}

function love.load()
    opening.load()
    love.window.setMode(Game.width * Game.scale, Game.height * Game.scale)
    Game.scene = "character-sellection"
end

function love.draw()
    love.graphics.setBackgroundColor(255, 255, 255)

    if opening.intro_counter < opening.intro_display_seconds then
        opening.draw()
    else
        drawMainMenu()
        
        DrawBackground(Game.width * Game.scale, Game.height * Game.scale)
        
        Game.scene = "character-sellection"
        DrawCharacterSellection()
    end
end

function love.update(dt)
    opening.update(dt)
end

function loadButtons()

end

function drawMainMenu()
  
end