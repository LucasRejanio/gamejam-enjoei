local anim8 = require 'lib/anim8'

opening = {
  intro_display_seconds = 3,
  intro_counter = 0
}

function opening.load(enjoeiAsset)
  local sound = love.audio.newSource('audio/pirilim.wav', 'static')
  love.graphics.draw(enjoeiAsset.image, 70, 70)

  sound:setLooping(false)

  local spriteDimension = 915
  local g = anim8.newGrid(spriteDimension, spriteDimension, enjoeiAsset.image:getWidth(), enjoeiAsset.image:getHeight())
  opening.animation = anim8.newAnimation(g('1-21',1, '1-21',2), 0.04, 'pauseAtEnd')
  
  sound:play()
end

function opening.update(dt)
  if opening.intro_counter < opening.intro_display_seconds then
    opening.intro_counter = opening.intro_counter + dt
    opening.animation:update(dt)
  end
end

function opening.draw(enjoeiAsset)
  opening.animation:draw(enjoeiAsset.image, 170, 20, nil, 0.5) -- corrigir posicionamento da abertura para ficar centralizado
end
