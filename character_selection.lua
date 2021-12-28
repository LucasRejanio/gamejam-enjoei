character_selection = {
    selected_avatar_scale = 0.3,
    not_selected_avatar_scale = 0.15,
    selected_avatar = 1,
    avatars = {"bear", "cat", "pineapple", "watermelon"},
    assets = {}
}

local font = nil

timer_counter = 0

function character_selection.load(assets)
    font = love.graphics.newFont(32)
    --***IMPORTANTE***: Tem que ficar nessa ordem pra ficarem ordenados da mesma forma nos dois vetores
    bear = love.graphics.newImage('img/players/bear.png')
    cat = love.graphics.newImage('img/players/cat.png')
    pineapple = love.graphics.newImage('img/players/pineapple.png')
    watermelon = love.graphics.newImage('img/players/watermelon.png')

    character_selection.assets = {bear, cat, pineapple, watermelon}
    assets = character_selection.assets
    Game.avatars = character_selection.avatars
end

function character_selection.draw(Game)
    drawAvatars(character_selection.selected_avatar)
    drawButton(Game)
end

function drawAvatars(index)
    selected_asset = character_selection.assets[index]
    love.graphics.setColor(1,1,1,1)
    if (index > 1) then
        left_asset = character_selection.assets[index-1]
    else
        left_asset = character_selection.assets[4]
    end

    if (index < 4) then
        right_asset = character_selection.assets[index+1]
    else
        right_asset = character_selection.assets[1]
    end

    --Draw selected avatars
    x = ((Game.width*Game.scale)/2) - (selected_asset:getWidth()*character_selection.selected_avatar_scale/2)
    y = 70
    love.graphics.draw(selected_asset, x, y, 0, character_selection.selected_avatar_scale, character_selection.selected_avatar_scale)

    --Left avatar
    x = ((Game.width*Game.scale)/3) - (left_asset:getWidth()*character_selection.not_selected_avatar_scale/2)
    y = 70
    love.graphics.draw(left_asset, x, y, 0, character_selection.not_selected_avatar_scale, character_selection.not_selected_avatar_scale)

    --Right avatar
    x = (2*(Game.width*Game.scale)/3) - (right_asset:getWidth()*character_selection.not_selected_avatar_scale/2)
    y = 70
    love.graphics.draw(right_asset, x, y, 0, character_selection.not_selected_avatar_scale, character_selection.not_selected_avatar_scale)
end

function character_selection.update(dt)

    timer_counter = timer_counter + dt

    if (timer_counter > 0.3) then

        if love.keyboard.isDown("left") then
            if (character_selection.selected_avatar == 1) then
                character_selection.selected_avatar = 4
            else
                character_selection.selected_avatar = character_selection.selected_avatar-1    
            end
            timer_counter = 0
        end

        if love.keyboard.isDown("right") then
            if (character_selection.selected_avatar == 4) then
                character_selection.selected_avatar = 1
            else
                character_selection.selected_avatar = character_selection.selected_avatar+1    
            end
            timer_counter = 0
        end
    end
end

function drawButton(Game)
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    local button = {
        width = (Game.width*Game.scale) / 3,
        height = 64,
        text = "Selecionar e Jogar",
        last = false,
        now = false
    }
    
    button.last = button.now

    local bx = (ww * 0.5) - (button.width * 0.5)
    local by = (wh * 0.5) - (button.height * 0.5)

    local button_color = {1.0, 0.83, 0.87, 1}

    local mx, my = love.mouse.getPosition() 

    local hot = mx > bx and mx < bx + button.width and
                my > by and my < by + button.height

    if hot then
      button_color = {1, 1, 1, 1}
    end

    button.now = love.mouse.isDown(1)
    if hot and button.now and not button.last then
      Game.scene = "game"
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
end