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

assets = {}

function love.load()
    love.window.setMode(Game.width * Game.scale, Game.height * Game.scale)

    opening.load()
    menu.load(Game)
    character_selection.load(assets)
    game.load()
end

function love.draw()
    love.graphics.scale(game.scale, game.scale)
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
    if opening.is_opening then
        opening.update(dt)
    else
        if Game.scene == "menu" then
            menu.update(dt)
        elseif Game.scene == "character_selection" then
            character_selection.update(dt)
        elseif Game.scene == "game" then
            game.update(dt)
        end
    end
end

function drawBackground(width, height)
    local whiteRGB = { 1, 1, 1 }

    love.graphics.setColor(whiteRGB)
    love.graphics.rectangle("fill", 0, 0, width, height)
end
