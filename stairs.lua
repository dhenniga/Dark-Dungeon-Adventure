-- stairs
circle_transitioning = false
local circle_t, circle_dir, circle_active = 0, 1, true

function start_level_reveal()
  circle_t, circle_dir, circle_active = 0, 1, true
  sfx(55, 3)
end

function start_level_hide()
  circle_t, circle_dir, circle_active = 1, -1, true
  sfx(54, 3)
end

function on_circle_hidden()
  if next_px then
    p.x, p.y = next_px, next_py
  end
  next_px, next_py, circle_transitioning = nil, nil, false
  start_level_reveal()
end

function use_transition(o)
  if circle_transitioning then return end
  circle_transitioning, allow_movement = true, false
  next_px, next_py, p.dx, p.dy = o.flx, o.fly, 0, 0
  start_level_hide()
end

function draw_circle()
  poke(0x5f34, 2)
  circfill(p.x + 4, p.y, inCubic(circle_t, 0, 175, 1), 0x1800)
end

function update_circle()
  if not circle_active then return end

  circle_t += 0.015 * circle_dir

  if circle_t >= 1 then
    circle_t, circle_active = 1, false
  elseif circle_t <= 0 then
    circle_t, circle_active = 0, false
    on_circle_hidden()
  end
end

function stairs_trigger(o)
  local ox, oy, px, py = mapx + o.x, mapy + o.y, p.x, p.y
  return px + 8 > ox and px < ox + 16 and py + 8 > oy and py < oy + 16
end