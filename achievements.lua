achievements = {}

goals = {
  { year = 2010, done = false, goal = 3, difficulty = 0 },
  { year = 2011, done = false, goal = 7, difficulty = 1 },
  { year = 2012, done = false, goal = 12, difficulty = 2 },
  { year = 2013, done = false, goal = 16, difficulty = 3 },
  { year = 2014, done = false, goal = 23, difficulty = 3 },
  { year = 2015, done = false, goal = 29, difficulty = 3 },
  { year = 2016, done = false, goal = 35, difficulty = 0 },
  { year = 2017, done = false, goal = 40, difficulty = 1 },
  { year = 2018, done = false, goal = 45, difficulty = 2 },
  { year = 2019, done = false, goal = 50, difficulty = 3 },
  { year = 2020, done = false, goal = 55, difficulty = 3 },
  { year = 2021, done = false, goal = 60, difficulty = 3 },
  { year = 2025, done = false, goal = 70, difficulty = 4 },
  { year = 2030, done = false, goal = 80, difficulty = 4 }
}

goal_display = false
goal_display_timer = 0
goal_display_seconds = 2

function achievements.check_for_achievement(score)
  for i, goal in ipairs(goals) do
    if score == goal.goal then
      game.difficulty = goal.difficulty
      game.current_year = goal.year
      goal.done = true
      achievements.goal_display = true
      goal_display_timer = 0
    end
  end
end

function achievements.load()
  year_up_font = love.graphics.newFont(32)
end

function achievements.update(dt)
  if goal_display then
    goal_display_timer = goal_display_timer + dt
  end

  if goal_display_timer > goal_display_seconds then
    goal_display = false
    goal_display_timer = 0
  end
end

function achievements.draw()
  if goal_display then
    local ww = love.graphics.getWidth()

    local rectangleW = 190
    local rectangleH = 60

    old_font = love.graphics.getFont()
  
    love.graphics.setFont(year_up_font)

    local goal_display_text = "YEAR UP!"

    love.graphics.setColor(1, 0.4, 0.4)
    love.graphics.rectangle('fill', ww - rectangleW - 120, 100, rectangleW, rectangleH)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(goal_display_text, ww - (rectangleW * 0.5) - (year_up_font:getWidth(goal_display_text) * 0.5) - 120, 100 + (rectangleH * 0.5) - (year_up_font:getHeight(goal_display_text) * 0.5))

    love.graphics.setFont(old_font)
  end
end