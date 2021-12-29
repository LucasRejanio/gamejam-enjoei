require "achievements"

time_between_spawns = 3
spawn_timer = 0

collectable_types = {"bug", "dindin", "argentina", "maneki"}
--collectable_types = {"bug", "dindin", "bolsa", "brilhou", "celular", "argentina", "cupom"}
collectables = {}
onscreen_collectables = {}

collectable_speed = 2

function collectables.load()
  bug_image = love.graphics.newImage("img/objects/bug.png")
  dindin_image = love.graphics.newImage("img/objects/cash.png")
  argentina_image = love.graphics.newImage("img/objects/2017-argentina.png")
  argentina_image = love.graphics.newImage("img/objects/2017-argentina.png")
  maneki_neeko_image = love.graphics.newImage("img/objects/maneki_neeko.png")

  bug_sfx = love.audio.newSource("audio/bug_sfx.wav", "static")
  collectable_sfx = love.audio.newSource("audio/collectable_sfx.wav", "static")
  maneki_sfx = love.audio.newSource("audio/maneki_sound.mp3", "static")

  collectables["bug"] = {
    image = bug_image,
    cw = bug_image:getWidth(),
    ch = bug_image:getHeight(),
    fn = bug_fn
  }
  collectables["dindin"] = {
    image = dindin_image,
    cw = dindin_image:getWidth(),
    ch = dindin_image:getHeight(),
    fn = collectable_fn
  }
  collectables["argentina"] = {
    image = argentina_image,
    cw = argentina_image:getWidth(),
    ch = argentina_image:getHeight(),
    fn = collectable_fn
  }
  collectables["maneki"] = {
    image = maneki_neeko_image,
    cw = maneki_neeko_image:getWidth(),
    ch = maneki_neeko_image:getHeight(),
    fn = maneki_fn
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
    collectable.x = collectable.x - collectable_speed

    if check_collision(collectable, player) then
      collectable.fn()
      table.remove(onscreen_collectables, i)
    end

    if collectable.x + (collectable.width) < 0 then
      table.remove(onscreen_collectables, i)
    end
  end

  check_speed()
end

function collectables.draw()
  for i, collectable in ipairs(onscreen_collectables) do
    if collectable.image == maneki_neeko_image then
      love.graphics.draw(collectable.image, collectable.x, collectable.y, 0, 0.1, 0.1)
    elseif collectable.image == argentina_image then
      love.graphics.draw(collectable.image, collectable.x, collectable.y, 0, 0.7, 0.8)
    else 
      love.graphics.draw(collectable.image, collectable.x, collectable.y, 0, 1.5, 1.5)  
    end
    
  end
end

function collectables.reset_collectables()
  onscreen_collectables = {}
  collectable_speed = 2
  time_between_spawns = 3
end

function random_type()
  type = collectable_types[ math.random( #collectable_types ) ]
  if type == "maneki" then
    if achievements.goal_display then
      achievements.goal_display = false
      return type
    else
      return random_type()
    end
  else 
    return type
  end
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
  possible_heights = {100, 200, 300, 400, 500}
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

function bug_fn()
  game.current_lives = game.current_lives - 1
  play_bug_sfx()
  
  if game.current_lives <= 0 then
    Game.scene = "game_over"
  end
end

function collectable_fn()
  game.current_score = game.current_score + 1
  achievements.check_for_achievement(game.current_score)
  play_collectable_sfx()
  print("pegou um dindin!")
end

function maneki_fn()
  game.current_lives = game.current_lives + 1
  play_maneki_sfx()
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

function play_maneki_sfx()
  maneki_sfx:setLooping(false)
  maneki_sfx:setVolume(0.4)
  maneki_sfx:play()
end

function check_speed()
  if game.difficulty == 0 then
    collectable_speed = 2
    time_between_spawns = 3
  elseif game.difficulty == 1 then
    collectable_speed = 4
    time_between_spawns = 2
  elseif game.difficulty == 2 then
    collectable_speed = 6
    time_between_spawns = 1
  elseif game.difficulty == 3 then
    collectable_speed = 8
    time_between_spawns = 0.5
  elseif game.difficulty == 4 then
    collectable_speed = 10
    time_between_spawns = 0.3
  end
end