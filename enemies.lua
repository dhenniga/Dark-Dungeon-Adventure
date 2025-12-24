-- enemies.lua
baddie_m = { baddies = {} }

function enemy(room_id, fr, x, y, fly, speed, att_speed, acc, drg, stop_time, pause_between, weight, slow_radius, flash_frame)
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
    hp = 3,
    start_hp = 3,
    alert_time = 0,
    stagger = 0,
    flash = 0,
    flash_frame = flash_frame
  }
end

-- presets
function bat(x, y) return enemy(get_current_room(), split("232, 234, 236, 234"), x, y, true, 1.2, 1.6, 10, 0.90, 40, 40, 0.1, 60, 68) end
function rat(x, y) return enemy(get_current_room(), split("228, 230"), x, y, false, 1.5, 0.8, 0.64, 0.92, 35, 90, 0.1, 10, 70) end -- happy with the rats
function blob(x, y) return enemy(get_current_room(), { 226 }, x, y, false, 0.8, 1.0, 0.12, 0.92, 20, 80, 0.2, 20, 58) end

--

-- drawing (safe anim advance)
function baddie_draw(b)
  local bx, by = b.x, b.y
  -- poison_flames(b.x, b.y)
  -- fire_flames(b.x, b.y)

  -- animation
  b.anim += 0.2 * t_increment
  if b.anim > #b.frames + 0.999 then b.anim = 1 end
  local frame, flip = b.frames[flr(b.anim)], (b.dx < 0)

  if b.flash > 0 then
    spr(b.flash_frame, bx - 4, by - 4, 2, 2, flip)
  else
    spr(frame, bx - 4, by - 4, 2, 2, flip)
  end

  -- health bar
  if b.hp < b.start_hp then
    rectfill(bx, by + 10, bx + b.start_hp, by + 10, 0)
    rectfill(bx, by + 10, bx + b.hp, by + 10, 9)
  end

  --  alert icon
  if b.state == "alert" then
    sspr(29, 80, 3, 7, bx + 6, by - 4)
  end

  if b.state == "alert" or b.state == "attack" then
    if not darkrooms then line(p.x, p.y, bx + 8, by + 4, 5) end
  end
end

--

function baddie_m.update()
  for b in all(baddie_m.baddies) do
    if b and b.x >= mapx and b.x <= mapx + 127 and b.y >= mapy and b.y <= mapy + 127 then
      baddie_update(b)
    end
  end
end

--

function baddie_m.draw()
  for b in all(baddie_m.baddies) do
    if b and b.x >= mapx and b.x <= mapx + 127 and b.y >= mapy and b.y <= mapy + 127 then
      baddie_draw(b)
    end
  end
end

--

-- main per-enemy update
function baddie_update(b)
  b.ttl -= 1

  if b.flash >= 0 then
    b.flash -= 1
  end

  if spr_coll(b, p) and player_atk then
    b.flash = 8
    sfx(48, 3)
    b.hp -= 1
  end

  if b.hp == 0 then
    boom(b.x, b.y, 8, 4, 9, 11, 3)
    sfx(49, 3)
    del(baddie_m.baddies, b)
  end

  if b.stagger > 0 then
    b.stagger -= 1
  end

  if not enemy_can_move(b) then
    b.dx = 0
    b.dy = 0
    sfx(16, 3)
  end

  -- apply drag to local velocity
  b.dx *= b.drg
  b.dy *= b.drg

  -- 𝘴𝘦𝘦 / 𝘢𝘭𝘦𝘳𝘵 / 𝘢𝘵𝘵𝘢𝘤𝘬 logic (attack overrides explore)
  if sees(b, l_rad, 0, 1, 1, 0) then
    -- first sight: if coming from explore -> 𝘴𝘵𝘰𝘱/𝘢𝘭𝘦𝘳𝘵
    if b.state ~= "alert" and b.state ~= "attack" then
      b.state, b.alert_time, b.dx, b.dy = "alert", b.stop_time, 0, 0
      return
    end

    -- still in stop/alert: countdown
    if b.state == "alert" then
      b.alert_time -= 1
      if b.alert_time <= 0 then
        b.state = "attack"
      end
      return
    end

    if b.state == "attack" and b.stagger <= 0 then
      dx = p.x - b.x
      dy = p.y - 5 - b.y
      d = sqrt(dx * dx + dy * dy)
      if d > 0 then
        dx /= d dy /= d
      end
      sp = b.att_speed
      if d < b.slow_radius then sp *= d / max(1, b.slow_radius) end
      dx *= sp dy *= sp
      sx = dx - b.dx sy = dy - b.dy
      sl = sqrt(sx * sx + sy * sy)
      if sl > b.acc then
        sx = sx / sl * b.acc sy = sy / sl * b.acc
      end
      b.dx += sx b.dy += sy
      v = sqrt(b.dx * b.dx + b.dy * b.dy)
      if v > b.att_speed then
        b.dx = b.dx / v * b.att_speed b.dy = b.dy / v * b.att_speed
      end
    end
  else
    -- lost sight: revert to explore if needed
    if b.state == "attack" or b.state == "alert" then
      b.state, b.ttl = "explore", 0
    end

    -- 𝘦𝘹𝘱𝘭𝘰𝘳𝘦 behaviour: periodic wander impulses
    if b.ttl <= 0 then
      b.state, b.ttl = "explore", b.pause_between + flr(rnd(b.pause_between))
      local ang = rnd() * 6.28318
      b.dx += cos(ang) * b.speed
      b.dy += sin(ang) * b.speed
    end
  end

  --

  local nx = b.x + b.dx * t_increment
  local ny = b.y + b.dy * t_increment
  function sb(x, y)
    return solid(x, y) or solid(x + 15, y) or solid(x, y + 15) or solid(x + 15, y + 15)
  end
  if not sb(nx, b.y) then b.x = nx else b.dx = 0 end
  if not sb(b.x, ny) then b.y = ny else b.dy = 0 end
  b.x = mapx + max(0, min(b.x - mapx, 112))
  b.y = mapy + max(0, min(b.y - mapy, 112))

  -- spr_coll(b, p)

  for o in all(baddie_m.baddies) do
    if o ~= b and o.room_id == b.room_id then
      local rx, ry = o.x - b.x, o.y - b.y
      local d = sqrt(rx * rx + ry * ry)
      if d > 0 and d < 12 then
        local nxp, nyp = rx / d, ry / d
        local push = (12 - d) * b.weight
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