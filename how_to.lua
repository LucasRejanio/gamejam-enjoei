how_to = {}

function how_to.load()
    how_to.spacebar_sprite = love.graphics.newImage("img/how_to/spacebar.png")
    how_to.left_arrow = love.graphics.newImage("img/how_to/seta-esquerda.png")
    how_to.right_arrow = love.graphics.newImage("img/how_to/seta-direita.png")
end

function how_to.draw()

    
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