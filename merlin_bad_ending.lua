merlin_bad_ending = {
    messages = {}
}
merlin_timer = 0

function merlin_bad_ending.load()
  merlin_bad_ending.image = love.graphics.newImage('img/ending/merlin_game_over.png')
  merlin_bad_ending.messages.fun_image = love.graphics.newImage('img/ending/merlin_message.png')
  merlin_bad_ending.messages.out_service_image = love.graphics.newImage('img/ending/out_of_service.png')
end

function merlin_bad_ending.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(assets.moises, 1047, Game.height * Game.scale - 235)
  love.graphics.draw(merlin_bad_ending.messages.fun_image, 450, 50)
  love.graphics.draw(merlin_bad_ending.messages.out_service_image, 470, 150)
  love.graphics.draw(merlin_bad_ending.image, 380, 300)
  
  if game.song:isPlaying() then
    game.song:stop()
  end

  songs.game_over:setLooping(true)
  songs.game_over:setVolume(0.3)
  songs.game_over:play()
end

function merlin_bad_ending.update(dt)
  merlin_timer = merlin_timer + dt

  if merlin_timer > 5.0 then
    Game.scene = "game_over"
  end
end
