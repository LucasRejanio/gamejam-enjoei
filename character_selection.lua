character_selection = {
    selected_avatar_scale = 0.3,
    not_selected_avatar_scale = 0.15,
    selected_avatar = 1,
    avatars = {"bear", "cat", "pineapple", "watermelon"},
    assets = {}
}

timer_counter = 0

function character_selection.load(assets)
    --Tem que ficar nessa ordem pra ficarem ordenados da mesma forma nos dois vetores
    assets.bear = love.graphics.newImage('img/players/bear.png')
    assets.cat = love.graphics.newImage('img/players/cat.png')
    assets.pineapple = love.graphics.newImage('img/players/pineapple.png')
    assets.watermelon = love.graphics.newImage('img/players/watermelon.png')

    character_selection.assets = {assets.bear, assets.cat, assets.pineapple, assets.watermelon}
end

function character_selection.draw()
    drawAvatars(character_selection.selected_avatar)
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

    if (timer_counter > 1) then

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