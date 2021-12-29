cat_bad_ending = {}
cat_timer = 0

function cat_bad_ending.load()
  cat_bad_ending.image = love.graphics.newImage('img/ending/cat_game_over.png')
  cat_bad_ending.not_working_image = love.graphics.newImage('img/ending/not_working.png')
end

function cat_bad_ending.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(assets.moises, 1047, Game.height * Game.scale - 235)
  love.graphics.draw(cat_bad_ending.not_working_image, 430, 100)
  love.graphics.draw(cat_bad_ending.image, Game.width + 20, 230)
  
  if game.song:isPlaying() then
    game.song:stop()
  end

  songs.game_over:setLooping(true)
  songs.game_over:setVolume(0.3)
  songs.game_over:play()
end

function cat_bad_ending.update(dt)
  cat_timer = cat_timer + dt

  if cat_timer > 5.0 then
    Game.scene = "game_over"
  end
end
