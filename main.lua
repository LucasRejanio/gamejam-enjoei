require("opening")
require("menu")
require("game")
require("character_selection")

Game = {
    width = 352,
    height = 256,
    scale = 3.5,
    scene = "menu"
}

function love.load()
    --Assets.bear.image = love.graphics.newImage("img/players/bear.jpg")

    opening.load()
    menu.load()
    game.load()
    love.window.setMode(Game.width * Game.scale, Game.height * Game.scale)
end

function love.draw()
    love.graphics.setBackgroundColor(255, 255, 255)

    if opening.is_opening then
        opening.draw()
    else
        if Game.scene == "menu" then
            menu.draw()
        elseif Game.scene == "character_selection" then
            character_selection.draw()
        elseif Game.scene == "game" then
            game.draw()
        end
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
