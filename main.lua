require("opening")
require("menu")
require("game")
require("character_selection")
require("game_over")

Game = {
    width = 352,
    height = 256,
    scale = 3.5,
    scene = "menu",
    selected_avatar = 1,
    highscore = 0
}

assets = {}

function love.load()
    love.window.setMode(Game.width * Game.scale, Game.height * Game.scale)

    opening.load()
    menu.load(Game)
    character_selection.load(assets)
    game.load()
    game_over.load()
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
            character_selection.draw(Game)
        elseif Game.scene == "game" then
            game.draw()
        elseif Game.scene == "game_over" then
            game_over.draw()
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
        elseif Game.scene == "game_over" then
            game_over.update(dt)
        end
    end
end
