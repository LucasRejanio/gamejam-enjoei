function DrawCharacterSellection()
    local CharacterSize = {
        width = 32,
        height = 32
    }

    DrawBear(CharacterSize)
    DrawCat(CharacterSize)
    DrawWaterMellon(CharacterSize)
    DrawPineApple(CharacterSize)
end

function DrawBear(charSize)
    blackRGB = { 0, 0, 0 }

    love.graphics.setColor(blackRGB)
    love.graphics.NewImage("")
end

function DrawCat(charSize)
    -- love.graphics.setBackgroundColor( red, green, blue, alpha )
    love.graphics.rectangle("fill", 0, 0, charSize.width, charSize.height)
end

function DrawWaterMellon(charSize)
    -- love.graphics.setBackgroundColor( red, green, blue, alpha )
    love.graphics.rectangle("fill", 0, 0, charSize.width, charSize.height)
end

function DrawPineApple(charSize)
    -- love.graphics.setBackgroundColor( red, green, blue, alpha )
    love.graphics.rectangle("fill", 0, 0, charSize.width, charSize.height)
end

function DrawBackground(width, height)
    local whiteRGB = { 1, 1, 1 }

    love.graphics.setColor(whiteRGB)
    love.graphics.rectangle("fill", 0, 0, width, height)
end
