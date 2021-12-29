game = {
  current_score = 0,
  current_lives = 3
}

scale = 3.5

player = {
  height = 32 * scale,
  width = 32 * scale,
  velx = 0,
  vely = 1,
  avatar_current_frame = 1
}

timer_counter = 0

function game.load()

  avatar_frames = {{}, {}, {}, {}}

  for i=1, 4 do
    avatar = Game.avatars[i]
    sprite_name = avatar .. "Sprite"

    for index=1, 6 do
      table.insert(avatar_frames[i], love.graphics.newImage("img/players/" .. sprite_name .. "/" .. sprite_name .. index .. ".png"))
    end
  end

  background = love.graphics.newImage("img/backgrounds/background.png")

  player.x = 0
  player.y = love.graphics.getHeight() - player.height - (55 * scale)
end

function game.draw()
  love.graphics.draw(background, 0, 0, 0)
  player_width = player.width
  player_height = player.height

  love.graphics.setColor(255 / 255, 255 / 255, 255 / 255)
  love.graphics.draw(avatar_frames[Game.selected_avatar][math.floor(player.avatar_current_frame)], player.x, player.y, 0, scale, scale)

  --Score e Pontuação
  love.graphics.setColor(0,0,0)
  love.graphics.print("pontuação: " .. game.current_score,0,90,0,2,2)
  love.graphics.print("vidas: " .. game.current_lives,0,110,0,2,2)
  love.graphics.setColor(1,1,1)
end

spacePressed = false

function game.update(dt)
  player.avatar_current_frame = player.avatar_current_frame + 10 * dt
  if player.avatar_current_frame >= 6 then
    player.avatar_current_frame = 1
  end

  maxY = love.graphics.getHeight() - player.height - (55 * scale) 

  if (love.keyboard.isDown("space") and timer_counter < 0.3) then
    player.vely = -18
    timer_counter = timer_counter + dt
  end

  player.vely = player.vely + 1
  player.y = player.y + player.vely

  if player.y > maxY then
    player.y = maxY
    timer_counter = 0
  end
  -- if player.x < 0 then
  --   player.x = 0
  -- end

  -- if player.x + player.width > game.width then
  --   player.x = game.width - player.width
  -- end

  -- ball.vely = ball.vely + 0.1

  -- ball.x = ball.x + ball.velx
  -- ball.y = ball.y + ball.vely

  -- -- bate na colisão
  -- if checkCollision(ball, player) or ball.y + ball.height > game.height then
  --   ball.vely = -7
  --   hitSound:play()
  -- end

  -- -- bate nos cantos
  -- if ball.x < 0 or ball.x + ball.width > game.width then
  --   ball.velx = ball.velx * -1
  --   hitSound:play()
  -- end
end

--Atualiza as vidas e pontuaçao se houve colisão
function object_collided(isBug) 
  --Se for bug
  if isBug then
    game.current_lives = game.current_lives - 1
    if game.current_lives == 0 then
      Game.scene = "game_over"
    end

  --Se nao for bug
  else 
    game.current_score = game.current_score + 1
  end
end