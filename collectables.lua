time_between_spawns = 3
spawn_timer = 0

scale = 3.5

collectable_types = {"bug", "dindin"}
--collectable_types = {"bug", "dindin", "bolsa", "brilhou", "celular", "argentina", "cupom"}
collectables = {}
onscreen_collectables = {}

collectable_speed = 2

function collectables.load()
  bug_image = love.graphics.newImage("img/objects/bug.png")
  dindin_image = love.graphics.newImage("img/objects/cash.png")

  bug_sfx = love.audio.newSource("audio/bug_sfx.wav", "static")
  collectable_sfx = love.audio.newSource("audio/collectable_sfx.wav", "static")

  collectables["bug"] = {
    image = bug_image,
    cw = bug_image:getWidth() * scale,
    ch = bug_image:getHeight() * scale,
    fn = function()
      game.current_lives = game.current_lives - 1
      play_bug_sfx()
      print("pegou um bug!")
      
      if game.current_lives == 0 then
        Game.scene = "game_over"
      end
    end
  }
  collectables["dindin"] = {
    image = dindin_image,
    cw = dindin_image:getWidth() * scale,
    ch = dindin_image:getHeight() * scale,
    fn = function()
      score_up()
      play_collectable_sfx()
      print("pegou um dindin!")
    end
  }
end

function collectables.update(dt, player)
  spawn_timer = spawn_timer + dt

  if spawn_timer > time_between_spawns then
    type_to_spawn = random_type()
    spawn_collectable(type_to_spawn)
    spawn_timer = 0
  end

  for i, collectable in ipairs(onscreen_collectables) do
    print(i .. "   " .. onscreen_collectables[1].width)
    collectable.x = collectable.x - collectable_speed

    if check_collision(collectable, player) then
      collectable.fn()
      table.remove(onscreen_collectables, i)
    end

    if collectable.x + (collectable.width * scale) < 0 then
      table.remove(onscreen_collectables, i)
    end
  end
end

function collectables.draw()
  for i, collectable in ipairs(onscreen_collectables) do
    love.graphics.draw(collectable.image, collectable.x, collectable.y, 0, scale, scale)
  end
end

function random_type()
  return collectable_types[ math.random( #collectable_types ) ]
end

function spawn_collectable(collectable_type)
  local ww = love.graphics.getWidth()

  local collectable = collectables[collectable_type]

  local new_collectable = {
    image = collectable.image,
    fn = collectable.fn,
    width = collectable.cw,
    height = collectable.ch,
    x = ww,
    y = random_height()
  }

  table.insert(onscreen_collectables, new_collectable)
end

function random_height()
  possible_heights = {100, 200, 300, 400}
  return possible_heights[ math.random( #possible_heights ) ]
end

function check_collision(a, b)
  -- não-colisão no eixo x
  if
    b.x > a.x + a.width or
    a.x > b.x + b.width then

    return false
  end

  -- não-colisão no eixo y
  if
    b.y > a.y + a.height or
    a.y > b.y + b.height then

    return false
  end

  return true
end

function play_bug_sfx()
  bug_sfx:setLooping(false)
  bug_sfx:setVolume(0.4)
  bug_sfx:play()
end

function play_collectable_sfx()
  collectable_sfx:setLooping(false)
  collectable_sfx:setVolume(0.4)
  collectable_sfx:play()
end

function score_up()
  game.current_score = game.current_score + 1
end