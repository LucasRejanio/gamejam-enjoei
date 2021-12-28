game = {}

player = {
  height = 32,
  width = 32
}

function game.load()
  background = love.graphics.newImage("img/backgrounds/background.png")
  player.image = love.graphics.newImage("img/players/bearSprite/bearSprite1.png")

  player.x = 60
  player.y = love.graphics.getHeight() - player.height - 55
end

function game.draw()
  love.graphics.draw(background, 0, 0)
  player_width = player.width
  player_height = player.height

  
  love.graphics.setColor(255 / 255, 255 / 255, 255 / 255)
  love.graphics.rectangle('fill', player.x, player.y, player_width, player_height)
  love.graphics.draw(player.image, player.x, player.y)
  --love.graphics.draw(ball.image, ball.x, ball.y)
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

