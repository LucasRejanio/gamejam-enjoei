game_over = {
  moises = love.graphics.newImage('img/ending/moises.png')
}

timer = 0

function game_over.load()
  text_font = love.graphics.newFont(50)
  button_font = love.graphics.newFont(32)
end

function game_over.draw()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  if game.current_score > Game.highscore then
    Game.highscore = game.current_score
  end

  old_font = love.graphics.getFont()
  
  love.graphics.setFont(text_font)

  game_over_text = "GAME OVER!"
  score_text =  "pontuação: " .. game.current_score
  highscore_text = "highscore: " .. Game.highscore

  love.graphics.print(game_over_text, (ww * 0.5) - (text_font:getWidth(game_over_text) * 0.5), 120)
  love.graphics.print(score_text, (ww * 0.5) - (text_font:getWidth(score_text) * 0.5) , 200)
  love.graphics.print(highscore_text, (ww * 0.5) - (text_font:getWidth(highscore_text) * 0.5), 280)
  
  love.graphics.setFont(button_font)

  local button = newButton(
    "Selecionar personagem",
    function()
      new_game = true
      Game.scene = "character_selection"
    end
  )

  local button_width = ww / 2
  local button_height = 64

  local margin = 16

  local total_height = (button_height + margin) * #button

  local bx = (ww * 0.5) - (button_width * 0.5)
  local by = (wh * 0.8) - (total_height * 0.5)

  local button_color = {1.0, 0.83, 0.87, 1}

  local mx, my = love.mouse.getPosition() 

  local hot = mx > bx and mx < bx + button_width and
            my > by and my < by + button_height

  if hot then
    button_color = {1, 1, 1, 1}
  end

  button.now = love.mouse.isDown(1)
  if hot and button.now then
    button.fn()
  end

  love.graphics.setColor(unpack(button_color))
  love.graphics.rectangle(
    "fill",
    bx,
    by,
    button_width,
    button_height
  )
  love.graphics.setColor(0.35, 0.2, 0.2)
  love.graphics.rectangle(
    "line",
    bx,
    by,
    button_width,
    button_height
  )

  local textW = button_font:getWidth(button.text)
  local textH = button_font:getHeight(button.text)

  love.graphics.setColor(0.35, 0.2, 0.2)
  love.graphics.print(
    button.text,
    button_font,
    (ww * 0.5) - textW * 0.5,
    by + (button_height * 0.5) - (textH * 0.5)
  )

  love.graphics.setFont(old_font)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(game_over.moises, 1047, Game.height * Game.scale - 235)
  love.graphics.setColor(0.35, 0.2, 0.2)
end

function game_over.update(dt)
end
