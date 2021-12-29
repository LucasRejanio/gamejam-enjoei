cat_bad_ending = {}
cat_timer = 0

function cat_bad_ending.load()
  cat_font = love.graphics.newFont(35)
  cat_bad_ending.image = love.graphics.newImage('img/ending/cat_game_over.png')
end

function cat_bad_ending.draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(cat_font)
  text = "ops, deu algum xabu na internet"
  love.graphics.print(text, 310, 80)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(assets.moises, 1047, Game.height * Game.scale - 235)
  love.graphics.draw(cat_bad_ending.image, Game.width + 20, 180)
  
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
