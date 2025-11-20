-- enemies.lua
-- Three-state enemies: explore → stop → attack (steering arrival)
-- Per-enemy numeric parameters (no "modes"). Max baddies cap, separation, solid-tile collision.

local TAU = 2 * 3.14159
local MAX_BADDIES = 10
local SPR_W = 16 -- sprite hitbox size

function enemy(fr, x, y, fly, speed, att_speed, acc, drg, stop_time, pause_between, weight, slow_radius)
  return {
    fr = fr,
    x = x, y = y,
    dx = 0, dy = 0,
    can_fly = fly or false,
    -- movement tuning (per-enemy)
    speed = speed or 0.5, -- explore baseline
    att_speed = att_speed or 1, -- top chase speed
    acc = acc or 0.12, -- steering/acceleration
    drg = drg or 0.92, -- drag each frame
    stop_time = stop_time or 30, -- frames to pause on first sight
    pause_between = pause_between or 60, -- delay between explore decisions
    weight = weight or 1, -- used for repel strength
    slow_radius = slow_radius or 24, -- arrival slow radius
    -- state
    state = "explore",
    ttl = 0, burst_t = 0,
    hp = 10, start_hp = 10,
    alert_time = 0
  }
end

-- convenience factories (set per-enemy numbers here)
function bat(x, y) return enemy({ 236, 234, 232 }, x, y, true, 1.2, 1.6, 0.14, 0.95, 30, 40, 1, 28) end
function rat(x, y) return enemy({ 228, 230 }, x, y, false, 0.6, 0.9, 0.18, 0.88, 10, 90, 1.5, 8) end
function blob(x, y) return enemy({ 226 }, x, y, false, 0.8, 1.0, 0.12, 0.92, 20, 80, 1, 20) end

baddie_m = { baddies = {} }

function baddie_m.add(b)
  if #baddie_m.baddies < MAX_BADDIES then add(baddie_m.baddies, b) end
end

-- helpers
local function normalize(x, y)
  local l = sqrt(x * x + y * y)
  if l < 0.0001 then return 0, 0, 0 end
  return x / l, y / l, l
end

local function clamp_room(b)
  if b.x < mapx then
    b.x = mapx b.dx = abs(b.dx)
  end
  if b.x > mapx + 128 - SPR_W then
    b.x = mapx + 128 - SPR_W b.dx = -abs(b.dx)
  end
  if b.y < mapy then
    b.y = mapy b.dy = abs(b.dy)
  end
  if b.y > mapy + 128 - SPR_W then
    b.y = mapy + 128 - SPR_W b.dy = -abs(b.dy)
  end
end

local function solid_box(x, y)
  if solid(x, y) then return true end
  if solid(x + SPR_W - 1, y) then return true end
  if solid(x, y + SPR_W - 1) then return true end
  if solid(x + SPR_W - 1, y + SPR_W - 1) then return true end
  return false
end

-- drawing
local frb = 1
function baddie_draw(b)
  local flip = b.dx < 0
  frb = (frb < #b.fr + .9) and frb + .1 * t_increment or 1
  spr(b.fr[flr(frb)], b.x - 4, b.y - 4, 2, 2, flip)
  if b.hp < b.start_hp then
    rectfill(b.x, b.y + 10, b.x + b.start_hp, b.y + 10, 0)
    rectfill(b.x, b.y + 10, b.x + b.hp, b.y + 10, 9)
  end
  -- optional: exclamation during alert
  if b.state == "stop" then
    sspr(29, 80, 3, 7, b.x + 6, b.y - 4)
  end
end

function baddie_m.update()
  for b in all(baddie_m.baddies) do
    if b.x >= mapx and b.x <= mapx + 127 and b.y >= mapy and b.y <= mapy + 127 then
      baddie_update(b)
    end
  end
end

function baddie_m.draw()
  for b in all(baddie_m.baddies) do
    if b.x >= mapx and b.x <= mapx + 127 and b.y >= mapy and b.y <= mapy + 127 then
      baddie_draw(b)
    end
  end
end

-- main per-enemy update
function baddie_update(b)
  b.ttl -= 1

  -- apply drag
  b.dx *= b.drg
  b.dy *= b.drg

  -- SEE / ALERT / ATTACK logic (attack overrides explore)
  if sees(b, l_rad or 40, 0, 1, 1, 0) then
    -- if just saw player and was exploring -> stop (alert)
    if b.state ~= "stop" and b.state ~= "attack" then
      b.state = "stop"
      b.alert_time = b.stop_time
      b.dx, b.dy = 0, 0
      return
    end

    if b.state == "stop" then
      b.alert_time -= 1
      if b.alert_time <= 0 then b.state = "attack" end
      return
    end

    if b.state == "attack" then
      -- steering arrival: desired vel toward player; slow as approach
      local vx, vy = p.x - b.x, p.y - b.y
      local nx, ny, dist = normalize(vx, vy)
      local desired_speed = b.att_speed
      if dist < b.slow_radius then desired_speed = desired_speed * (dist / max(1, b.slow_radius)) end
      local desired_x, desired_y = nx * desired_speed, ny * desired_speed
      local steer_x, steer_y = desired_x - b.dx, desired_y - b.dy
      -- limit steering by acc
      local sl = sqrt(steer_x * steer_x + steer_y * steer_y)
      if sl > 0 then
        local lim = b.acc
        if sl > lim then steer_x, steer_y = steer_x / sl * lim, steer_y / sl * lim end
        b.dx += steer_x b.dy += steer_y
      end
      -- clamp speed to att_speed
      local vl = sqrt(b.dx * b.dx + b.dy * b.dy)
      if vl > b.att_speed then b.dx, b.dy = (b.dx / vl) * b.att_speed, (b.dy / vl) * b.att_speed end
    end
  else
    -- lost sight: if was attacking or stopping, revert to explore
    if b.state == "attack" or b.state == "stop" then
      b.state = "explore"
      b.ttl = 0
    end

    -- EXPLORE behaviour: periodic wander impulses (pause_between controls pacing)
    if b.ttl <= 0 then
      b.state = "explore"
      b.ttl = b.pause_between + flr(rnd(b.pause_between))
      -- small random steering impulse (can be tuned per enemy)
      local ang = rnd() * TAU
      b.dx += cos(ang) * b.speed
      b.dy += sin(ang) * b.speed
    end
  end

  -- compute next pos and respect solids (x then y)
  local nx = b.x + b.dx * t_increment
  local ny = b.y + b.dy * t_increment

  if not solid_box(nx, b.y) then b.x = nx else b.dx = 0 end
  if not solid_box(b.x, ny) then b.y = ny else b.dy = 0 end

  clamp_room(b)

  -- separation from others (velocity nudges, scaled by weight)
  for o in all(baddie_m.baddies) do
    if o ~= b then
      local rx, ry = o.x - b.x, o.y - b.y
      local d = sqrt(rx * rx + ry * ry)
      if d > 0 and d < 12 then
        local nxp, nyp = rx / d, ry / d
        local push = (12 - d) * 0.03 * b.weight
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