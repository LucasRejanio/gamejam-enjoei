require("opening")
require("menu")
require("character-sellection")

Game = {
    width = 352,
    height = 256,
    scale = 3.5,
    scene = ""
}

Assets = {
    bear = {}
}

function love.load()
    Assets.bear.image = love.graphics.newImage("img/players/bear.jpg")

    opening.load()
    menu.load()
    love.window.setMode(Game.width * Game.scale, Game.height * Game.scale)

    Game.scene = "character-sellection"
end

function love.draw()
    love.graphics.setBackgroundColor(255, 255, 255)

    if opening.intro_counter < opening.intro_display_seconds then
        opening.draw()
    else
        menu.draw()
        
        --DrawBackground(Game.width * Game.scale, Game.height * Game.scale)
        
        --Game.scene = "character-sellection"
        --DrawCharacterSellection()
    end
end

function love.update(dt)
    opening.update(dt)
end

function drawBackground(width, height)
    local whiteRGB = { 1, 1, 1 }

    love.graphics.setColor(whiteRGB)
    love.graphics.rectangle("fill", 0, 0, width, height)
end
