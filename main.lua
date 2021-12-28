CharSellection = require("character-sellection")

Game = {
    width = 352,
    height = 256,
    scale = 3.5,
    scene = ""
}

function love.load()
    love.window.setMode(Game.width * Game.scale, Game.height * Game.scale)
    Game.scene = "character-sellection"
end

function love.draw()
    DrawBackground(Game.width * Game.scale, Game.height * Game.scale)
    
    Game.scene = "character-sellection"
    DrawCharacterSellection()


end

function love.update()
    
    
end


