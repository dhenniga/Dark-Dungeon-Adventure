-- inventory.lua

local it = 0 -- inventory transition timer
item_selected = 1 -- which slot is currently active
player_light_enabled = true

-- 🩸 Draw hearts and handle inventory toggle
function draw_inventory()

  -- lanturn lighting
  for x = 121, 125 do
    for y = 104, 106 do 
      sset(x, y, player_light_enabled and 7 or 0)
    end
  end

  for i = 1, p.total_hearts do
    local filled = p.remaining_hearts >= i
    if zoom_view then
      -- draw small hearts above player
      sspr(
        filled and 96 or 101, 8, 3, 3,
        p.x + (i << 2) - 32, p.y + 29
      )
    else
      -- draw hearts in HUD
      spr(
        filled and 238 or 239,
        mapx + (i << 3) - 8, mapy + 118
      )
    end
  end

  -- open inventory with X button
  if btn(BTN_X) then
    t_increment = .05
    if it < 50 then it += 1 end
    if it == 1 then sfx(10, 3) end
    p.dx, p.dy = 0, 0
    allow_movement = false
    show_inventory()
  else
    -- close inventory
    t_increment = 1
    it = 0
    allow_movement = true
  end
end

-- 🧷 Pretty border text print helper
function pb(s, x, y, c, o)
  color(o)
  ?'\-f' .. s .. '\^g\-h' .. s .. '\^g\|f' .. s .. '\^g\|h' .. s, x, y
  ?s, x, y, c
end

-- 🗝️ Full inventory display overlay
function show_inventory()
  -- show item name banner
  for o in all(active_objects) do
    if o.flags.name and not reading then
      pb(o.name, mapx, mapy + 112, 11, 0) -- display the name of the room
    end
  end

  -- 🔑 draw collected keys (up to 5)
  if p.keys > 0 then
    for i = 1, min(p.keys, 5) do
      local x = mapx + 121 - (i - 1) * 13
      fillp(█)
      circfill(x, mapy + 6, 6, 129)
      spr(206, x - 3, mapy + 3)
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
  local outs, knob, ob = {}, outelastic(it, 0, 9, 50), outelastic(it,0,10,50)
  for i = 1, 4 do
    outs[i] = outelastic(it, 0, 11 + (item_selected == i and 7 or 0), 50)
  end

  -- background black border for top
  circfill(p.x+2,p.y-20,ob,0)
  circfill(p.x+23,p.y,ob,0)
  circfill(p.x+2,p.y+20,ob,0)
  circfill(p.x-19,p.y,ob,0)

  -- backgruond back
  circfill(p.x + 2, p.y, outelastic(it, 0, 26, 26), 0)
  
  -- backgruond front
  circfill(p.x + 2, p.y, outelastic(it, 0, 25, 25), 5)

    -- selection circles
  circfill(p.x + 2, p.y - 20, knob, 5)
  circfill(p.x + 23, p.y, knob, 5)
  circfill(p.x + 2, p.y + 20, knob, 5)
  circfill(p.x - 19, p.y, knob, 5)

  --light
  spr(207, p.x - 1, outelastic(it, p.y, -25, 25), 1, 2)

  --sword
  spr(72, outelastic(it, p.x, 16, 25), p.y - 8, 2, 2)

  -- draw character
  spr(192, p.x - 4, p.y - 8, 2, 2, p.direction)

end