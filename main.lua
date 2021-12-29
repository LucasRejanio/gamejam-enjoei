require("opening")
require("menu")
require("game")
require("character_selection")
require("cat_bad_ending")
require("merlin_bad_ending")
require("ending")
require("game_over")
require("how_to")

Game = {
    width = 352,
    height = 256,
    scale = 3.5,
    scene = "menu",
    selected_avatar = 1,
    highscore = 0
}

assets = {
    moises = love.graphics.newImage('img/ending/moises.png')
}

songs = {
    game_over = love.audio.newSource("audio/game_over.wav", "static"),
    ending = love.audio.newSource("audio/ending.wav", "static")
}

function love.load()
    love.window.setMode(Game.width * Game.scale, Game.height * Game.scale)
    love.window.setTitle("enjornada")

    opening.load()
    menu.load(Game)
    character_selection.load(assets)
    game.load()
    cat_bad_ending.load()
    merlin_bad_ending.load()
    game_over.load()
    how_to.load()
    ending.load()
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
        elseif Game.scene == "how_to" then
            how_to.draw()
        elseif Game.scene == "cat_bad_ending" then
            cat_bad_ending.draw()
        elseif Game.scene == "merlin_bad_ending" then
            merlin_bad_ending.draw()
        elseif Game.scene == "ending" then
            ending.draw()
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
        elseif Game.scene == "how_to" then
            how_to.update(dt)
        elseif Game.scene == "cat_bad_ending" then
            cat_bad_ending.update(dt)
        elseif Game.scene == "merlin_bad_ending" then
            merlin_bad_ending.update(dt)
        elseif Game.scene == "ending" then
            ending.update(dt)
        end
    end
end
