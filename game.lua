require "collectables"
require "achievements"

starting_lives = 3

game = {
  current_score = 0,
  current_lives = starting_lives,
  current_year = 2009,
  difficulty = 0,
  song = love.audio.newSource("audio/game_sound.mp3", "static")
}

scale = 3.5

bg_position = 0

player = {
  height = 32 * scale,
  width = 32 * scale,
  velx = 0,
  vely = 1,
  avatar_current_frame = 1
}

timer_counter = 0
playing_music = false

new_game = true

function game.load()
  collectables.load()
  achievements.load()

  avatar_frames = {{}, {}, {}, {}}

  for i=1, 4 do
    avatar = Game.avatars[i]
    sprite_name = avatar .. "Sprite"

    for index=1, 6 do
      table.insert(avatar_frames[i], love.graphics.newImage("img/players/" .. sprite_name .. "/" .. sprite_name .. index .. ".png"))
    end
  end
  
  year_font = love.graphics.newFont(32)
  score_font = love.graphics.newFont(24)

  background = love.graphics.newImage("img/backgrounds/bg-yellow.png")
  background:setWrap('repeat', 'clampzero')

  background_speed = 2.3

  player.x = 0
  player.y = love.graphics.getHeight() - player.height - (55 * scale)
end

function game.draw()
  ww = love.graphics:getWidth()

  sx = love.graphics:getWidth() / background:getWidth()
  sy = love.graphics:getHeight() / background:getHeight()
  bg_scroll:setViewport(-bg_position * background_speed, 0, background:getWidth(), background:getHeight())
  love.graphics.draw(background, bg_scroll, 0, 0, 0, sx, sy)
  
  player_width = player.width
  player_height = player.height

  love.graphics.setColor(255 / 255, 255 / 255, 255 / 255)
  love.graphics.draw(avatar_frames[Game.selected_avatar][math.floor(player.avatar_current_frame)], player.x, player.y, 0, scale, scale)

  old_font = love.graphics.getFont()

  --Score e Pontuação
  love.graphics.setFont(score_font)
  love.graphics.setColor(0,0,0)
  love.graphics.print("pontuação: " .. game.current_score, 10, 90)
  love.graphics.print("vidas: " .. game.current_lives, 10, 120)

  --Ano
  love.graphics.setFont(year_font)
  love.graphics.print(game.current_year, ww - year_font:getWidth(game.current_year) - 20, 100)
  love.graphics.setColor(1,1,1)

  love.graphics.setFont(old_font)

  --Coletáveis
  collectables.draw()

  --Conquistas
  achievements.draw()
end

spacePressed = false

function game.update(dt)
  print(game.difficulty)

  if new_game then
    game.current_lives = starting_lives
    game.current_score = 0
    game.current_year = 2009
    game.difficulty = 0
    collectables.reset_collectables()

    new_game = false
  end

  collectables.update(dt, player)
  achievements.update(dt)
  
  check_background_speed()

  bg_position = bg_position - 1
  bg_w = background:getWidth()
  bg_h = background:getHeight()

  bg_scroll = love.graphics.newQuad(-bg_position, -1, bg_w, bg_h, bg_w, bg_h)

  player.avatar_current_frame = player.avatar_current_frame + 10 * dt
  if player.avatar_current_frame >= 6 then
    player.avatar_current_frame = 1
  end

  maxY = love.graphics.getHeight() - player.height - (55 * scale) 

  if (love.keyboard.isDown("space") and timer_counter < 0.3) then
    player.vely = -18
    timer_counter = timer_counter + dt

    spacePressed = true
  end

  player.vely = player.vely + 1
  player.y = player.y + player.vely

  if player.y > maxY then
    player.y = maxY
    timer_counter = 0

    if spacePressed then
      spacePressed = false
    end
  end

  
  --Audio
  if playing_music == false then
    game.song:setLooping(true)
    game.song:setVolume(0.3)
    game.song:play()
    playing_music = true
  end
end

function check_background_speed()
  if game.difficulty == 0 then
    background_speed = 2.5
  elseif game.difficulty == 1 then
    background_speed = 4
  elseif game.difficulty == 2 then
    background_speed = 6
  elseif game.difficulty == 3 then
    background_speed = 8
  elseif game.difficulty == 4 then
    background_speed = 10
  end
end