require "achievements"

time_between_spawns = 3
spawn_timer = 0

collectable_types = {}

collectables = {}
onscreen_collectables = {}

collectable_speed = 2

function collectables.load()
  bug_image = love.graphics.newImage("img/objects/bug.png")
  cash_image = love.graphics.newImage("img/objects/cash.png")
  coin_image = love.graphics.newImage("img/objects/coin.png")
  cupom_image = love.graphics.newImage("img/objects/cupom.png")
  blog_image = love.graphics.newImage("img/objects/2009-blog.png")
  website_image = love.graphics.newImage("img/objects/2012-website.png")
  argentina_image = love.graphics.newImage("img/objects/2017-argentina.png")
  argentina_image = love.graphics.newImage("img/objects/2017-argentina.png")
  maneki_neeko_image = love.graphics.newImage("img/objects/maneki_neeko.png")
  android_image = love.graphics.newImage("img/objects/2015-android.png")
  iphone_image = love.graphics.newImage("img/objects/2015-iphone.png")
  wphone_image = love.graphics.newImage("img/objects/2015-wphone.png")
  ipo_image = love.graphics.newImage("img/objects/2020-ipo.png")
  bag_pink_image = love.graphics.newImage("img/objects/2021-bag-pink.png")
  bag_red_image = love.graphics.newImage("img/objects/2021-bag-red.png")

  bug_sfx = love.audio.newSource("audio/bug_sfx.wav", "static")
  collectable_sfx = love.audio.newSource("audio/collectable_sfx.wav", "static")
  maneki_sfx = love.audio.newSource("audio/maneki_sound.mp3", "static")

  collectables["bug"] = {
    image = bug_image,
    cw = bug_image:getWidth(),
    ch = bug_image:getHeight(),
    fn = bug_fn
  }
  collectables["cash"] = make_collectable(cash_image)
  collectables["coin"] = make_collectable(coin_image)
  collectables["cupom"] = make_collectable(cupom_image)

  collectables["blog"] = make_collectable(blog_image)

  collectables["website"] = make_collectable(website_image)

  collectables["argentina"] = make_collectable(argentina_image)

  collectables["android"] = make_collectable(android_image)
  collectables["iphone"] = make_collectable(iphone_image)
  collectables["wphone"] = make_collectable(wphone_image)

  collectables["ipo"] = make_collectable(ipo_image)

  collectables["bag_pink"] = make_collectable(bag_pink_image)
  collectables["bag_red"] = make_collectable(bag_red_image)
  
  collectables["maneki"] = {
    image = maneki_neeko_image,
    cw = maneki_neeko_image:getWidth()*0.1,
    ch = maneki_neeko_image:getHeight()*0.1,
    fn = maneki_fn
  }

  types_2009()
end

function make_collectable(image)
  return {
    image = image,
    cw = image:getWidth(),
    ch = image:getHeight(),
    fn = collectable_fn
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
  types_2009()
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
    time_between_spawns = 2
  elseif game.difficulty == 1 then
    collectable_speed = 3
    time_between_spawns = 1
  elseif game.difficulty == 2 then
    collectable_speed = 4
    time_between_spawns = 0.6
  elseif game.difficulty == 3 then
    collectable_speed = 5
    time_between_spawns = 0.3
  elseif game.difficulty == 4 then
    collectable_speed = 6
    time_between_spawns = 0.15
  end
end

function set_collectable_types(year)
  reset_types()

  
  if year == 2012 then
    table.insert(collectable_types, "website")
  elseif year == 2015 then
    table.insert(collectable_types, "bug")
    table.insert(collectable_types, "android")
    table.insert(collectable_types, "iphone")
    table.insert(collectable_types, "wphone")
  elseif year == 2017 then
    table.insert(collectable_types, "argentina")
  elseif year == 2020 then
    table.insert(collectable_types, "ipo")
  elseif year == 2021 then
    table.insert(collectable_types, "bag_pink")
    table.insert(collectable_types, "bag_red")
  end
end

function reset_types()
  collectable_types = {"bug", "bug", "cash", "coin", "cupom", "maneki"}
end

function types_2009()
  collectable_types = {"bug", "bug", "cash", "coin", "cupom", "maneki", "blog"}
end