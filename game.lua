game = {}

function game.load()
  background = love.graphics.newImage("img/backgrounds/background.png")
  player = love.graphics.newImage("img/players/bearSprite/bearSprite1.png")
end

function game.draw()
  love.graphics.draw(background, 0, 0)
end

function love.draw()
  love.graphics.scale(game.scale, game.scale)

  love.graphics.setColor(90 / 255, 215 / 255, 250 / 255)
  love.graphics.rectangle('fill', 3, 0, game.width, game.height)

  love.graphics.setColor(255 / 255, 255 / 255, 255 / 255)
  -- love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
  love.graphics.draw(player.image, player.x, player.y)
  love.graphics.draw(ball.image, ball.x, ball.y)

end

function love.update()
  if love.keyboard.isDown('left') then
    player.x = player.x - player.velx
  end

  if love.keyboard.isDown('right') then
    player.x = player.x + player.velx
  end

  if player.x < 0 then
    player.x = 0
  end

  if player.x + player.width > game.width then
    player.x = game.width - player.width
  end

  ball.vely = ball.vely + 0.1

  ball.x = ball.x + ball.velx
  ball.y = ball.y + ball.vely

  -- bate na colisão
  if checkCollision(ball, player) or ball.y + ball.height > game.height then
    ball.vely = -7
    hitSound:play()
  end

  -- bate nos cantos
  if ball.x < 0 or ball.x + ball.width > game.width then
    ball.velx = ball.velx * -1
    hitSound:play()
  end

end

