-- enemies.lua

function enemy(room_id, fr, x, y, fly, speed, att_speed, acc, drg, stop_time, pause_between, weight, slow_radius)
  return {
    room_id = room_id,
    frames = fr,
    anim = 1,
    x = x,
    y = y,
    dx = 0,
    dy = 0,
    can_fly = fly,
    speed = speed,
    att_speed = att_speed,
    acc = acc,
    drg = drg,
    stop_time = stop_time,
    pause_between = pause_between,
    weight = weight,
    slow_radius = slow_radius,
    state = "explore",
    ttl = 0,
    hp = 10,
    start_hp = 10,
    alert_time = 0
  }
end

-- presets
function bat(x, y) return enemy(get_current_room(), { 232, 234, 236, 234 }, x, y, true, 1.2, 1.6, 0.64, 0.95, 40, 40, 10, 50) end
function rat(x, y) return enemy(get_current_room(), { 228, 230 }, x, y, false, 0.5, 0.8, 0.18, 0.99, 35, 90, 2, 20) end
function blob(x, y) return enemy(get_current_room(), { 226 }, x, y, false, 0.8, 1.0, 0.12, 0.92, 20, 80, 1, 20) end

baddie_m = { baddies = {} }

local function solid_box_global(gx, gy)
  return solid(gx, gy)
      or solid(gx + 15, gy)
      or solid(gx, gy + 15)
      or solid(gx + 15, gy + 15)
end

-- drawing (safe anim advance)
function baddie_draw(b)
  b.anim += 0.2 * t_increment
  if b.anim > #b.frames + 0.999 then b.anim = 1 end
  local frame, flip = b.frames[flr(b.anim)], (b.dx < 0)
  spr(frame, b.x - 4, b.y - 4, 2, 2, flip)

  if b.hp < b.start_hp then
    rectfill(b.x, b.y + 10, b.x + b.start_hp, b.y + 10, 0)
    rectfill(b.x, b.y + 10, b.x + b.hp, b.y + 10, 9)
  end

  if b.state == "stop" then
    sspr(29, 80, 3, 7, b.x + 6, b.y - 4)
  end
end

function baddie_m.update()
  for b in all(baddie_m.baddies) do
    if b and b.x>=mapx and b.x<=mapx+127 and b.y>=mapy and b.y<=mapy+127 then baddie_update(b) end
  end
end

function baddie_m.draw()
  for b in all(baddie_m.baddies) do
    if b and b.x>=mapx and b.x<=mapx+127 and b.y>=mapy and b.y<=mapy+127 then baddie_draw(b) end
  end
end

-- main per-enemy update
function baddie_update(b)
  b.ttl -= 1

 if not enemy_can_move(b) then 
  sfx(16,3) 
end

  -- apply drag to local velocity
  b.dx *= b.drg
  b.dy *= b.drg

  -- compute local coordinates relative to current camera
  local lx = b.x - mapx
  local ly = b.y - mapy

  -- SEE / ALERT / ATTACK logic (attack overrides explore)
  if sees(b, l_rad, 0, 1, 1, 0) then
    -- first sight: if coming from explore -> STOP/ALERT
    if b.state ~= "stop" and b.state ~= "attack" then
      b.state, b.alert_time, b.dx, b.dy = "stop", b.stop_time, 0, 0
      return
    end

    -- still in stop/alert: countdown
    if b.state == "stop" then
      b.alert_time -= 1
      if b.alert_time <= 0 then
        b.state = "attack"
      end
      return
    end

    -- ATTACK behaviour: steering arrival in local space
    if b.state == "attack" then
      local desired_gx, desired_gy = p.x - b.x, (p.y - 5) - b.y -- global delta
      local dist, ndx, ndy = sqrt(desired_gx * desired_gx + desired_gy * desired_gy), 0, 0
      if dist > 0.0001 then
        ndx, ndy = desired_gx / dist, desired_gy / dist
      end

      -- desired speed slows inside slow_radius
      local desired_speed = b.att_speed
      if dist < b.slow_radius then desired_speed = desired_speed * (dist / max(1, b.slow_radius)) end
      local desired_vx, desired_vy = ndx * desired_speed, ndy * desired_speed

      -- convert desired_v (global) to local vector is the same numerically, we operate on b.dx/b.dy (local px/frame)
      local steer_x, steer_y = desired_vx - b.dx, desired_vy - b.dy
      local sl = sqrt(steer_x * steer_x + steer_y * steer_y)
      if sl > 0 then
        local lim = b.acc
        if sl > lim then steer_x, steer_y = steer_x / sl * lim, steer_y / sl * lim end
        b.dx += steer_x
        b.dy += steer_y
      end

      -- clamp speed to att_speed
      local vl = sqrt(b.dx * b.dx + b.dy * b.dy)
      if vl > b.att_speed then b.dx, b.dy = (b.dx / vl) * b.att_speed, (b.dy / vl) * b.att_speed end
    end
  else
    -- lost sight: revert to explore if needed
    if b.state == "attack" or b.state == "stop" then
      b.state, b.ttl = "explore", 0
    end

    -- EXPLORE behaviour: periodic wander impulses
    if b.ttl <= 0 then
      b.state, b.ttl = "explore", b.pause_between + flr(rnd(b.pause_between))
      local ang = rnd() * 6.28318
      b.dx += cos(ang) * b.speed
      b.dy += sin(ang) * b.speed
    end
  end

  -- PROPOSED local next position (operate in local coords to keep additions small)
  local nx_local = lx + b.dx * t_increment
  local ny_local = ly + b.dy * t_increment

  -- convert back to global
  local nx_global = mapx + nx_local
  local ny_global = mapy + ny_local

  -- per-axis solid checks using global hitbox corners
  if not solid_box_global(nx_global, b.y) then
    b.x = nx_global
  else
    b.dx = 0
    -- small nudge away from obstacle
    -- try sliding: if x blocked, attempt small backstep
  end

  if not solid_box_global(b.x, ny_global) then
    b.y = ny_global
  else
    b.dy = 0
  end

  -- clamp inside room local bounds
  b.x = mapx + max(0, min(b.x - mapx, 112))
  b.y = mapy + max(0, min(b.y - mapy, 112))

  -- separation / gentle repel (velocity nudges scaled by weight)
  -- separation from others (velocity nudges, scaled by weight)
  for o in all(baddie_m.baddies) do
    if o ~= b and o.room_id == b.room_id then
      local rx, ry = o.x - b.x, o.y - b.y
      local d = sqrt(rx * rx + ry * ry)
      if d > 0 and d < 12 then
        local nxp, nyp = rx / d, ry / d
        local push = (12 - d) * 0.03 * b.weight
        -- clamp per-step push so it can't blow up
        if push > 0.5 then push = 0.5 end
        o.dx += nxp * push
        o.dy += nyp * push
        b.dx -= nxp * push
        b.dy -= nyp * push
      end
    end
  end

  -- sanity ttl clamp
  if b.ttl < -300 then b.ttl = 0 end
end