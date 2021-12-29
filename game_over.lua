game_over = {}

timer = 0

function game_over.draw()
  old_font = love.graphics.getFont()
  font = love.graphics.newFont(32)
  love.graphics.setFont(font)
  
  game_over_text = "Game over!"
  score_text =  "pontuação: " .. game.current_score

  love.graphics.print(game_over_text, Game.width / 2, 80)
  love.graphics.print(score_text, Game.width / 2, 90 + font:getHeight(game_over_text))

  love.graphics.setFont(old_font)
  
  local button = newButton(
    "Selecionar personagem",
    function()
      Game.scene = "character_selection"
    end
  )

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local button_width = ww / 3
  local button_height = 64

  local margin = 16

  local total_height = (button_height + margin) * #button
  local cursor_y = 0

  local bx = (ww * 0.5) - (button_width * 0.5)
  local by = (wh * 0.5) - (total_height * 0.5) + cursor_y

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

  local textW = font:getWidth(button.text)
  local textH = font:getHeight(button.text)

  love.graphics.setColor(0.35, 0.2, 0.2)
  love.graphics.print(
    button.text,
    font,
    (ww * 0.5) - textW * 0.5,
    by + (button_height * 0.5) - (textH * 0.5)
  )

  cursor_y = cursor_y + (button_height + margin)
end


function game_over.update(dt)
    
end
