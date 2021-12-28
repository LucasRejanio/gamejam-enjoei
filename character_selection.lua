character_selection = {}

function character_selection.draw(assets)
    local CharacterSize = {
        width = 32,
        height = 32
    }

    drawBear(CharacterSize, assets.bear)
    drawCat(CharacterSize)
    drawWaterMellon(CharacterSize)
    drawPineApple(CharacterSize)
    loadButtons()
end

function drawBear(charSize, bearAsset)
    x = 70; y = 70
    bearAsset.image:setFilter("nearest", "nearest")

    love.graphics.draw(bearAsset.image, x, y)
end

function drawCat(charSize)
    -- love.graphics.setBackgroundColor( red, green, blue, alpha )
    love.graphics.rectangle("fill", 0, 0, charSize.width, charSize.height)
end

function drawWaterMellon(charSize)
    -- love.graphics.setBackgroundColor( red, green, blue, alpha )
    love.graphics.rectangle("fill", 0, 0, charSize.width, charSize.height)
end

function drawPineApple(charSize)
    -- love.graphics.setBackgroundColor( red, green, blue, alpha )
    love.graphics.rectangle("fill", 0, 0, charSize.width, charSize.height)
end

function loadButtons()
    
end
