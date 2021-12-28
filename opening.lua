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

  local spriteW = opening.image:getWidth() / 15
  local spriteH = opening.image:getHeight() / 3

  local g = anim8.newGrid(spriteW, spriteH, opening.image:getWidth(), opening.image:getHeight())
  opening.animation = anim8.newAnimation(g('1-15',1, '1-15',2, '1-12',3), 0.04, 'pauseAtEnd')

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
  opening.animation:draw(opening.image, 370, 150, nil, 0.5)
end
