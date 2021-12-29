merlin_bad_ending = {}
merlin_timer = 0

function merlin_bad_ending.load()
  merlin_font = love.graphics.newFont(30)
--   merlin_bad_ending.bulldog = love.graphics.newImage('img/.png')
--   merlin_bad_ending.poodle = love.graphics.newImage('img/.png')
--   merlin_bad_ending.audio = love.audio.newSource("audio/.mp3", "static")
end

function merlin_bad_ending.draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(merlin_font)
  text = "pelas barbas de merlin! o enjoei tá fora do ar."
  love.graphics.print(text, 300, 30)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(assets.moises, 1047, Game.height * Game.scale - 235)
--   love.graphics.draw(game_over.poodle, 1047, Game.height * Game.scale - 235)
--   love.graphics.draw(game_over.bulldog, 1047, Game.height * Game.scale - 235)
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
