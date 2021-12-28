local anim8 = require 'lib/anim8'

opening = {
  is_opening = true,
  intro_display_seconds = 3,
  intro_counter = 0
}

function opening.load()
  opening.image = love.graphics.newImage('img/opening/e.png')
  local sound = love.audio.newSource('audio/pirilim.wav', 'static')
  sound:setVolume(0.2)

  love.graphics.draw(opening.image, 70, 70)

  sound:setLooping(false)

  local spriteW = opening.image:getWidth() / 21
  local spriteH = opening.image:getHeight() / 2

  local g = anim8.newGrid(spriteW, spriteH, opening.image:getWidth(), opening.image:getHeight())
  opening.animation = anim8.newAnimation(g('1-21',1, '1-21',2), 0.04, 'pauseAtEnd')

  sound:play()
end

function opening.update(dt)
  if opening.is_opening and opening.intro_counter < opening.intro_display_seconds then
    opening.intro_counter = opening.intro_counter + dt
    opening.animation:update(dt)
  else
    opening.is_opening = false
  end
end

function opening.draw()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()
  local animation_size = 915

  opening.animation:draw(opening.image, 176, 128, nil, 0.5) -- corrigir posicionamento da abertura para ficar centralizado
end
