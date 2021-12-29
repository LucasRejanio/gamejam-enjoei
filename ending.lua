ending = {}
ending_timer = 0

play_ending_song = true

function ending.load()
  ending_title_image = love.graphics.newImage('img/ending/endgame.png')
  newspaper_image = love.graphics.newImage('img/ending/future.png')
end

function ending.draw()
  local ww = love.graphics.getWidth()

  love.graphics.draw(ending_title_image, (ww * 0.5) - (ending_title_image:getWidth() * 0.5), -30)
  love.graphics.draw(newspaper_image, (ww * 0.5) - (newspaper_image:getWidth() * 0.5 * 0.9), ending_title_image:getHeight() - 60, 0, 0.9, 0.9)

  if game.song:isPlaying() then game.song:stop() end

  if play_ending_song then
    songs.ending:setLooping(false)
    songs.ending:setVolume(0.3)
    songs.ending:play()
    play_ending_song = false
  end
end

function ending.update(dt)
  ending_timer = ending_timer + dt

  if ending_timer > 12 then
    Game.scene = "menu"
  end
end
