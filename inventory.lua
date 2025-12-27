-- inventory.lua
i_transition = 0
item_selected = 1 -- 1: light, 2: sword, 3: bow, 4: bomb
local text_anim = 0

-- ユかたま 𝘥raw hearts and handle inventory toggle
function draw_inventory()
  -- lanturn lighting
  for x = 121, 125 do
    for y = 104, 106 do
      sset(x, y, player_light_enabled and 7 or 0)
    end
  end

  for i = 1, p.total_hearts do
    spr(p.remaining_hearts >= i and 238 or 239, mapx + (i << 3) - 8, mapy + 118)
  end

  -- open inventory with 𝘹 button
  if btn(BTN_X) and not reading and not circle_transitioning then
    t_increment = .05
    if i_transition < 50 then i_transition += 1 end
    if i_transition == 1 then sfx(10, 3) end
    allow_movement = false
    p.dx, p.dy = 0, 0
    show_inventory()
  elseif not circle_transitioning then
    t_increment, i_transition, allow_movement, text_anim = 1, 0, true, 0
  end
end

function pb(s, x, y, c, o)
  color(o)
  ?'\-f' .. s .. '\^g\-h' .. s .. '\^g\|f' .. s .. '\^g\|h' .. s, x, y
  ?s, x, y, c
end

function show_inventory()
  -- show item name banner
  for o in all(active_objects) do
    if o.flags.name and not reading then
      if text_anim < 12 then text_anim += 1 end
      pb(o.name, mapx, outcubic(text_anim, mapy + 127, -14, 12), 11, 0) -- display the name of the room
    end
  end

  if p.keys > 0 then
    for i = 1, min(p.keys, 10) do
      local x = mapx + 121 - (i - 1) * 13
      circfill(x, outcubic(text_anim, mapy, 6, 12), 6, 129)
      spr(206, x - 3, outcubic(text_anim, mapy, 3, 12))
    end
  end

  local dirs = { BTN_U, BTN_D, BTN_L, BTN_R }
  for i = 1, 4 do
    if btnp(dirs[i]) then
      if i == 1 then
        player_light_enabled = not player_light_enabled sfx(12, 3)
      end
      item_selected = i
    end
  end

  -- elastic animations
  local outs, knob, ob = {}, outelastic(i_transition, 0, 9, 50), outelastic(i_transition, 0, 10, 50)
  for i = 1, 4 do
    outs[i] = outelastic(i_transition, 0, 11 + (item_selected == i and 7 or 0), 50)
  end

  -- background black border for top
  for p2 in all { { 2, -20 }, { 23, 0 }, { 2, 20 }, { -19, 0 } } do
    circfill(p.x + p2[1], p.y + p2[2], ob, 0)
  end

  -- backgruond back
  circfill(p.x + 2, p.y, outelastic(i_transition, 0, 26, 26), 0)

  -- backgruond front
  circfill(p.x + 2, p.y, outelastic(i_transition, 0, 25, 25), 5)

  -- selection circles
  circfill(p.x + 2, p.y - 20, knob, 5)
  circfill(p.x + 23, p.y, knob, 5)
  circfill(p.x + 2, p.y + 20, knob, 5)
  circfill(p.x - 19, p.y, knob, 5)

  --light
  spr(207, p.x - 1, outelastic(i_transition, p.y, -25, 25), 1, 2)

  --sword
  spr(72, outelastic(i_transition, p.x, 16, 25), p.y - 8, 2, 2)

  -- draw character
  spr(192, p.x - 4, p.y - 8, 2, 2, p.direction)
end