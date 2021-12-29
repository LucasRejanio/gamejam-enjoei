menu = {}

local buttons = {}
local devs = {}
local font = nil

function newButton(text, fn)
  return {
    text = text,
    fn = fn,

    last = false,
    now = false
  }
end

function menu.load(Game)
  font = love.graphics.newFont(32)
  menu.title = love.graphics.newImage('img/opening/enjornada.png')
  menu.developedby = love.graphics.newImage('img/opening/developedby.png')
  devs.bernardo = love.graphics.newImage('img/opening/developers/bernardo.png')
  devs.claudia = love.graphics.newImage('img/opening/developers/claudia.png')
  devs.gabs = love.graphics.newImage('img/opening/developers/gabs.png')
  devs.jordana = love.graphics.newImage('img/opening/developers/jordana.png')
  devs.liam = love.graphics.newImage('img/opening/developers/liam.png')
  devs.marcos = love.graphics.newImage('img/opening/developers/marcos.png')
  devs.rejanio = love.graphics.newImage('img/opening/developers/rejanio.png')
  devs.venancio = love.graphics.newImage('img/opening/developers/venancio.png')

  table.insert(buttons, newButton(
    "Jogar",
    function()
      print("Iniciando Jogo")
      Game.scene = "character_selection" --depois voltar para character_selection
    end
  ))
  table.insert(buttons, newButton(
    "Instruções",
    function()
      Game.scene = "how_to"
    end
  ))
  table.insert(buttons, newButton(
    "Sair",
    function()
      love.event.quit(0)
    end
  ))
end

function menu.draw()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local button_width = ww / 3
  local button_height = 64

  local margin = 16

  local total_height = (button_height + margin) * #buttons
  local cursor_y = 0

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(menu.title, button_width, 100)

  for i, button in ipairs(buttons) do
    button.last = button.now

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
    if hot and button.now and not button.last then
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

  love.graphics.setColor(1, 1, 1)

  love.graphics.draw(menu.developedby, button_width, 650)
  love.graphics.draw(devs.bernardo, 0, 770)
  love.graphics.draw(devs.claudia, 154, 770)
  love.graphics.draw(devs.gabs, 308, 770)
  love.graphics.draw(devs.jordana, 482, 770)
  love.graphics.draw(devs.liam, 636, 770)
  love.graphics.draw(devs.marcos, 790, 770)
  love.graphics.draw(devs.venancio, 955, 770)
  love.graphics.draw(devs.rejanio, 1106, 770)
end

function menu.update(dt)

end
