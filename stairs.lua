-- stairs
circle_t = 0
circle_dir = 1
circle_active = true
circle_transitioning = false

function start_level_reveal()
  circle_t = 0
  circle_dir = 1
  circle_active = true
  sfx(55, 3)
end

function start_level_hide()
  circle_t = 1
  circle_dir = -1
  circle_active = true
  sfx(54, 3)
end

function on_circle_hidden()
  if next_px then
    p.x = next_px
    p.y = next_py
  end

  next_px = nil
  next_py = nil
  circle_transitioning = false
  -- allow_movement = false
  start_level_reveal()
end

function use_transition(o)
  if circle_transitioning then return end
  circle_transitioning = true
  allow_movement = false
  next_px = o.flx
  next_py = o.fly
  p.dx, p.dy = 0, 0
  start_level_hide()
end

function update_circle()
  if not circle_active then return end

  circle_t += 0.015 * circle_dir

  if circle_t >= 1 then
    circle_t = 1
    circle_active = false
  elseif circle_t <= 0 then
    circle_t = 0
    circle_active = false
    on_circle_hidden()
  end
end

function stairs_trigger(o)
  local ox, oy, px, py = mapx + o.x, mapy + o.y, p.x, p.y
  return px + 8 > ox and px < ox + 16 and py + 8 > oy and py < oy + 16
end