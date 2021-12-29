how_to = {}

function how_to.load()
    font = love.graphics.newFont(32)
    how_to.spacebar_sprite = love.graphics.newImage("img/how_to/spacebar.png")
    how_to.left_arrow = love.graphics.newImage("img/how_to/seta-esquerda.png")
    how_to.right_arrow = love.graphics.newImage("img/how_to/seta-direita.png")
end

function how_to.draw()

    draw_how_to_button(Game)
    
    --spacebar sprite
    spacebar_scale = 4
    spacebar_x = ((Game.width*Game.scale)/2) - (how_to.spacebar_sprite:getWidth()*spacebar_scale/2)
    spacebar_y = ((Game.height*Game.scale)/2)
    love.graphics.draw(how_to.spacebar_sprite, spacebar_x,spacebar_y,0,spacebar_scale,spacebar_scale)

    --arrows sprites
    arrow_scale = 4
    left_arrow_x = ((Game.width*Game.scale)/3) - (how_to.left_arrow:getWidth()*arrow_scale/2)
    left_arrow_y = ((Game.height*Game.scale)/5)
    love.graphics.draw(how_to.left_arrow, left_arrow_x,left_arrow_y,0,arrow_scale,arrow_scale)

    right_arrow_x = ((Game.width*Game.scale)*2/3) - (how_to.right_arrow:getWidth()*arrow_scale/2)
    right_arrow_y = ((Game.height*Game.scale)/5)
    love.graphics.draw(how_to.right_arrow, right_arrow_x,right_arrow_y,0,arrow_scale,arrow_scale)

    --spacebar text
    spacebar_text = love.graphics.newText(love.graphics.newFont(30),"Pressione a barra de espaço para pular")
    spacebar_text_x = ((Game.width*Game.scale)/2) - (spacebar_text:getWidth()/2)
    spacebar_text_y = ((Game.height*Game.scale)/2) - how_to.spacebar_sprite:getHeight()*spacebar_scale

    --arrows text
    arrows_text = love.graphics.newText(love.graphics.newFont(30),"Use as setas para mudar de personagem")
    arrows_text_x = ((Game.width*Game.scale)/2) - (arrows_text:getWidth()/2)
    arrows_text_y = ((Game.height*Game.scale)/5) - how_to.left_arrow:getHeight()*arrow_scale

    --mouse text
    mouse_text = love.graphics.newText(love.graphics.newFont(30),"O resto é com o mouse :P")
    mouse_text_x = ((Game.width*Game.scale)/2) - (mouse_text:getWidth()/2)
    mouse_text_y = ((Game.height*Game.scale)*3/5)

     --how_to text
     how_to_text = love.graphics.newText(love.graphics.newFont(30),"E lembre, não chegue perto dos bugs")
     how_to_text_x = ((Game.width*Game.scale)/2) - (how_to_text:getWidth()/2)
     how_to_text_y = ((Game.height*Game.scale)*4/5)

    love.graphics.setColor(0,0,0)
    love.graphics.draw(spacebar_text,spacebar_text_x,spacebar_text_y)
    love.graphics.draw(arrows_text, arrows_text_x, arrows_text_y)
    love.graphics.draw(mouse_text, mouse_text_x, mouse_text_y)
    love.graphics.draw(how_to_text, how_to_text_x, how_to_text_y)
    love.graphics.setColor(1,1,1)
end

function how_to.update()

end


function draw_how_to_button(Game)
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    local button = {
        width = (Game.width*Game.scale) / 3,
        height = 64,
        text = "Voltar",
        last = false,
        now = false
    }
    
    button.last = button.now

    local bx = (ww * 0.5) - (button.width * 0.5)
    local by = (wh) - (button.height * 1.1)

    local button_color = {1.0, 0.83, 0.87, 1}

    local mx, my = love.mouse.getPosition() 

    local hot = mx > bx and mx < bx + button.width and
                my > by and my < by + button.height

    if hot then
      button_color = {1, 1, 1, 1}
    end

    button.now = love.mouse.isDown(1)
    if hot and button.now and not button.last then
      new_game = true
      Game.scene = "menu"
      Game.selected_avatar = character_selection.selected_avatar
      print("selected avatar: " .. character_selection.selected_avatar)
    end

    love.graphics.setColor(unpack(button_color))
    love.graphics.rectangle(
      "fill",
      bx,
      by,
      button.width,
      button.height
    )
    love.graphics.setColor(0.35, 0.2, 0.2)
    love.graphics.rectangle(
      "line",
      bx,
      by,
      button.width,
      button.height
    )

    local textW = font:getWidth(button.text)
    local textH = font:getHeight(button.text)

    love.graphics.setColor(0.35, 0.2, 0.2)
    love.graphics.print(
      button.text,
      font,
      (ww * 0.5) - textW * 0.5,
      by + (button.height * 0.5) - (textH * 0.5)
    )

    love.graphics.setColor(1, 1, 1)
end