game = {}

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

  frames = {}

  for i=1, 6 do
    name = Game.avatars[Game.selected_avatar] .. "Sprite"
    table.insert(frames, love.graphics.newImage("img/players/" .. name .. "/" .. name .. i .. ".png"))
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
  love.graphics.draw(frames[math.floor(player.avatar_current_frame)], player.x, player.y, 0, scale, scale)
  --love.graphics.draw(ball.image, ball.x, ball.y)
end

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
