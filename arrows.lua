--arrows
room_shooters = {}

function get_room_shooters(x, y)
  local key = x .. "_" .. y
  if not room_shooters[key] then room_shooters[key] = {} end
  return room_shooters[key]
end

function spawn_arrow(shooter)
  if shooter.flags.s_shoot_v then
    direction = shooter.flp and 1 or 0
    dx = 0
    dy = shooter.speed * (direction == 1 and 1 or -1)
  else
    direction = shooter.flp and 3 or 2
    dy = 0
    dx = shooter.speed * (direction == 2 and 1 or -1)
  end
  add(
    arrows, {
      x = mapx + shooter.x,
      y = mapy + shooter.y,
      dx = dx,
      dy = dy,
      d = direction
    }
  )
  sfx(19, 3)
end

function update_shooters()
  local shooters = get_room_shooters(cur_room_x, cur_room_y)

  for s in all(shooters) do
    if s.active then
      s.delay -= t_increment
      if s.delay <= 0 then
        spawn_arrow(s)
        s.delay = s.timing
      end
    end
  end
end

function update_arrows()
  for arrow in all(arrows) do
    -- move the arrow
    arrow.x += arrow.dx * t_increment
    arrow.y += arrow.dy * t_increment

    if solid(arrow.x, arrow.y) then
      del(arrows, arrow)
    end

    -- collision with player
    if spr_coll(arrow) then
      arrow.stagger = 10
      player_hit()
      del(arrows, arrow)
    end

    -- arrow leaves the screen
    if arrow.x < mapx or arrow.x > mapx + 127 or arrow.y < mapy or arrow.y > mapy + 127 then
      del(arrows, arrow)
    end
  end
end

local adraw = {
  { 117, 48, 3, 8, false, false, 2, -4 }, -- 𝘥𝘰𝘸𝘯 to 𝘶𝘱 -- 𝘥𝘰𝘯𝘦
  { 117, 48, 3, 8, false, true, 2, -6 }, -- 𝘶𝘱 to 𝘥𝘰𝘸𝘯
  { 112, 61, 8, 3, false, false, 2, 2 }, -- 𝘭𝘦𝘧𝘵 to 𝘳𝘪𝘨𝘩𝘵 -- 𝘥𝘰𝘯𝘦
  { 112, 61, 8, 3, true, false, -4, 2 } -- 𝘳𝘪𝘨𝘩𝘵 to 𝘭𝘦𝘧𝘵
}

function draw_arrows()
  for arrow in all(arrows) do
    local d = adraw[arrow.d + 1]
    sspr(
      d[1], d[2], d[3], d[4], arrow.x + d[7], arrow.y + d[8], d[3], d[4], d[5], d[6]
    )
  end
end